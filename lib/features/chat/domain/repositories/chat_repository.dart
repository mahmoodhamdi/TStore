import 'package:dartz/dartz.dart';
import 'package:t_store/features/chat/domain/entities/chat_message_entity.dart';

abstract class ChatRepository {
  Future<Either<String, List<ChatMessageEntity>>> getMessages({
    required String otherUserId,
    int page = 0,
    int limit = 50,
  });

  Future<Either<String, ChatMessageEntity>> sendMessage({
    required String receiverId,
    required String content,
    MessageType messageType = MessageType.text,
  });

  Future<Either<String, void>> markAsRead(String messageId);

  Future<Either<String, void>> markAllAsRead(String senderId);

  Stream<ChatMessageEntity> get messagesStream;

  Future<Either<String, int>> getUnreadCount();
}
