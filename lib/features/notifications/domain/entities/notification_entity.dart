import 'package:equatable/equatable.dart';

enum NotificationType { order, promotion, system, chat }

class NotificationEntity extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String body;
  final NotificationType type;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime? createdAt;

  const NotificationEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    this.data,
    this.isRead = false,
    this.createdAt,
  });

  String? get actionId => data?['action_id'] as String?;
  String? get actionType => data?['action_type'] as String?;

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        body,
        type,
        data,
        isRead,
        createdAt,
      ];

  NotificationEntity copyWith({
    String? id,
    String? userId,
    String? title,
    String? body,
    NotificationType? type,
    Map<String, dynamic>? data,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      data: data ?? this.data,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
