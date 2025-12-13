import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/notifications/domain/entities/notification_entity.dart';
import 'package:t_store/features/notifications/domain/repositories/notification_repository.dart';
import 'package:t_store/features/notifications/presentation/cubit/notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationRepository repository;
  StreamSubscription<NotificationEntity>? _notificationsSubscription;

  NotificationsCubit({required this.repository})
      : super(NotificationsInitial());

  List<NotificationEntity> _notifications = [];
  int _currentPage = 0;
  int _unreadCount = 0;
  static const int _limit = 20;

  void startListening() {
    _notificationsSubscription?.cancel();
    _notificationsSubscription = repository.notificationsStream.listen((notification) {
      _notifications = [notification, ..._notifications];
      _unreadCount++;
      emit(NewNotificationReceived(notification));
      emit(NotificationsLoaded(
        notifications: _notifications,
        unreadCount: _unreadCount,
      ));
    });
  }

  Future<void> getNotifications({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 0;
      _notifications = [];
    }

    if (_currentPage == 0) {
      emit(NotificationsLoading());
    }

    final result = await repository.getNotifications(
      page: _currentPage,
      limit: _limit,
    );

    result.fold(
      (error) => emit(NotificationsError(error)),
      (notifications) async {
        _notifications = [..._notifications, ...notifications];
        _currentPage++;

        // Get unread count
        final unreadResult = await repository.getUnreadCount();
        _unreadCount = unreadResult.fold((_) => 0, (count) => count);

        emit(NotificationsLoaded(
          notifications: _notifications,
          unreadCount: _unreadCount,
          hasReachedMax: notifications.length < _limit,
        ));
      },
    );
  }

  Future<void> loadMoreNotifications() async {
    if (state is NotificationsLoaded) {
      final currentState = state as NotificationsLoaded;
      if (currentState.hasReachedMax) return;
      await getNotifications();
    }
  }

  Future<void> markAsRead(String notificationId) async {
    await repository.markAsRead(notificationId);
    _notifications = _notifications.map((n) {
      if (n.id == notificationId && !n.isRead) {
        _unreadCount--;
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();
    emit(NotificationsLoaded(
      notifications: _notifications,
      unreadCount: _unreadCount,
    ));
  }

  Future<void> markAllAsRead() async {
    await repository.markAllAsRead();
    _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
    _unreadCount = 0;
    emit(NotificationsLoaded(
      notifications: _notifications,
      unreadCount: 0,
    ));
  }

  Future<void> deleteNotification(String notificationId) async {
    await repository.deleteNotification(notificationId);
    final notification = _notifications.firstWhere((n) => n.id == notificationId);
    if (!notification.isRead) _unreadCount--;
    _notifications = _notifications.where((n) => n.id != notificationId).toList();
    emit(NotificationsLoaded(
      notifications: _notifications,
      unreadCount: _unreadCount,
    ));
  }

  Future<void> deleteAllNotifications() async {
    await repository.deleteAllNotifications();
    _notifications = [];
    _unreadCount = 0;
    emit(NotificationsLoaded(
      notifications: [],
      unreadCount: 0,
    ));
  }

  int get unreadCount => _unreadCount;

  @override
  Future<void> close() {
    _notificationsSubscription?.cancel();
    return super.close();
  }
}
