import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/chat/domain/entities/chat_message_entity.dart';
import 'package:t_store/features/chat/domain/repositories/chat_repository.dart';
import 'package:t_store/features/chat/presentation/cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;
  StreamSubscription<ChatMessageEntity>? _messagesSubscription;

  ChatCubit({required this.repository}) : super(ChatInitial());

  List<ChatMessageEntity> _messages = [];
  int _currentPage = 0;
  static const int _limit = 50;
  String? _currentOtherUserId;

  void startListening() {
    _messagesSubscription?.cancel();
    _messagesSubscription = repository.messagesStream.listen((message) {
      if (_currentOtherUserId != null &&
          (message.senderId == _currentOtherUserId ||
              message.receiverId == _currentOtherUserId)) {
        _messages = [message, ..._messages];
        emit(NewMessageReceived(message));
        emit(ChatLoaded(messages: _messages));
      }
    });
  }

  Future<void> getMessages(String otherUserId, {bool refresh = false}) async {
    _currentOtherUserId = otherUserId;

    if (refresh) {
      _currentPage = 0;
      _messages = [];
    }

    if (_currentPage == 0) {
      emit(ChatLoading());
    }

    final result = await repository.getMessages(
      otherUserId: otherUserId,
      page: _currentPage,
      limit: _limit,
    );

    result.fold(
      (error) => emit(ChatError(error)),
      (messages) {
        _messages = [..._messages, ...messages];
        _currentPage++;
        emit(ChatLoaded(
          messages: _messages,
          hasReachedMax: messages.length < _limit,
        ));
      },
    );
  }

  Future<void> loadMoreMessages(String otherUserId) async {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;
      if (currentState.hasReachedMax) return;
      await getMessages(otherUserId);
    }
  }

  Future<void> sendMessage({
    required String receiverId,
    required String content,
    MessageType messageType = MessageType.text,
  }) async {
    emit(MessageSending());

    final result = await repository.sendMessage(
      receiverId: receiverId,
      content: content,
      messageType: messageType,
    );

    result.fold(
      (error) => emit(ChatError(error)),
      (message) {
        _messages = [message, ..._messages];
        emit(MessageSent(message));
        emit(ChatLoaded(messages: _messages));
      },
    );
  }

  Future<void> markAsRead(String messageId) async {
    await repository.markAsRead(messageId);
  }

  Future<void> markAllAsRead(String senderId) async {
    await repository.markAllAsRead(senderId);
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
