import 'package:equatable/equatable.dart';
import 'package:t_store/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationEntity> notifications;
  final int unreadCount;
  final bool hasReachedMax;

  const NotificationsLoaded({
    required this.notifications,
    this.unreadCount = 0,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [notifications, unreadCount, hasReachedMax];

  NotificationsLoaded copyWith({
    List<NotificationEntity>? notifications,
    int? unreadCount,
    bool? hasReachedMax,
  }) {
    return NotificationsLoaded(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class NotificationsError extends NotificationsState {
  final String message;

  const NotificationsError(this.message);

  @override
  List<Object?> get props => [message];
}

class NewNotificationReceived extends NotificationsState {
  final NotificationEntity notification;

  const NewNotificationReceived(this.notification);

  @override
  List<Object?> get props => [notification];
}
