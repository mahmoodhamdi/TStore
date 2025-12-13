import 'package:t_store/features/chat/domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    required super.content,
    super.messageType,
    super.isRead,
    super.createdAt,
    super.senderName,
    super.senderAvatar,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      content: json['content'] as String,
      messageType: _parseMessageType(json['message_type'] as String?),
      isRead: json['is_read'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      senderName: json['sender'] != null
          ? (json['sender'] as Map<String, dynamic>)['full_name'] as String?
          : null,
      senderAvatar: json['sender'] != null
          ? (json['sender'] as Map<String, dynamic>)['avatar_url'] as String?
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'content': content,
      'message_type': messageType.name,
      'is_read': isRead,
    };
  }

  static MessageType _parseMessageType(String? type) {
    switch (type) {
      case 'image':
        return MessageType.image;
      case 'system':
        return MessageType.system;
      default:
        return MessageType.text;
    }
  }
}
