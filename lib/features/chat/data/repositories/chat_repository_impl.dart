import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:t_store/core/supabase/supabase_service.dart';
import 'package:t_store/core/supabase/supabase_tables.dart';
import 'package:t_store/features/chat/data/models/chat_message_model.dart';
import 'package:t_store/features/chat/domain/entities/chat_message_entity.dart';
import 'package:t_store/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final SupabaseService supabaseService;
  StreamController<ChatMessageEntity>? _messagesController;

  ChatRepositoryImpl({required this.supabaseService});

  String get _userId => supabaseService.currentUser?.id ?? '';

  @override
  Future<Either<String, List<ChatMessageEntity>>> getMessages({
    required String otherUserId,
    int page = 0,
    int limit = 50,
  }) async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      final from = page * limit;
      final to = from + limit - 1;

      final response = await supabaseService.client
          .from(SupabaseTables.chatMessages)
          .select('*, sender:profiles!sender_id(full_name, avatar_url)')
          .or('and(sender_id.eq.$_userId,receiver_id.eq.$otherUserId),and(sender_id.eq.$otherUserId,receiver_id.eq.$_userId)')
          .order('created_at', ascending: false)
          .range(from, to);

      final messages = (response as List)
          .map((json) => ChatMessageModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(messages);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ChatMessageEntity>> sendMessage({
    required String receiverId,
    required String content,
    MessageType messageType = MessageType.text,
  }) async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      final response = await supabaseService.client
          .from(SupabaseTables.chatMessages)
          .insert({
            'sender_id': _userId,
            'receiver_id': receiverId,
            'content': content,
            'message_type': messageType.name,
          })
          .select('*, sender:profiles!sender_id(full_name, avatar_url)')
          .single();

      return Right(ChatMessageModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> markAsRead(String messageId) async {
    try {
      await supabaseService.client
          .from(SupabaseTables.chatMessages)
          .update({'is_read': true})
          .eq('id', messageId)
          .eq('receiver_id', _userId);

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> markAllAsRead(String senderId) async {
    try {
      await supabaseService.client
          .from(SupabaseTables.chatMessages)
          .update({'is_read': true})
          .eq('sender_id', senderId)
          .eq('receiver_id', _userId)
          .eq('is_read', false);

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Stream<ChatMessageEntity> get messagesStream {
    if (_userId.isEmpty) {
      return Stream.empty();
    }

    _messagesController?.close();
    _messagesController = StreamController<ChatMessageEntity>.broadcast();

    supabaseService.client
        .from(SupabaseTables.chatMessages)
        .stream(primaryKey: ['id'])
        .eq('receiver_id', _userId)
        .listen((data) async {
          for (final item in data) {
            // Fetch with sender info
            try {
              final response = await supabaseService.client
                  .from(SupabaseTables.chatMessages)
                  .select('*, sender:profiles!sender_id(full_name, avatar_url)')
                  .eq('id', item['id'])
                  .single();
              _messagesController?.add(ChatMessageModel.fromJson(response));
            } catch (_) {}
          }
        });

    return _messagesController!.stream;
  }

  @override
  Future<Either<String, int>> getUnreadCount() async {
    try {
      if (_userId.isEmpty) {
        return const Right(0);
      }

      final response = await supabaseService.client
          .from(SupabaseTables.chatMessages)
          .select('id')
          .eq('receiver_id', _userId)
          .eq('is_read', false);

      return Right((response as List).length);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
