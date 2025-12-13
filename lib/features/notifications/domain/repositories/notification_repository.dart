import 'package:dartz/dartz.dart';
import 'package:t_store/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<String, List<NotificationEntity>>> getNotifications({
    int page = 0,
    int limit = 20,
  });

  Future<Either<String, void>> markAsRead(String notificationId);

  Future<Either<String, void>> markAllAsRead();

  Future<Either<String, void>> deleteNotification(String notificationId);

  Future<Either<String, void>> deleteAllNotifications();

  Future<Either<String, int>> getUnreadCount();

  Stream<NotificationEntity> get notificationsStream;
}
