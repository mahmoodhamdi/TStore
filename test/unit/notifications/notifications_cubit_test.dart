import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t_store/features/notifications/domain/entities/notification_entity.dart';
import 'package:t_store/features/notifications/domain/repositories/notification_repository.dart';
import 'package:t_store/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:t_store/features/notifications/presentation/cubit/notifications_state.dart';

// Mocks
class MockNotificationRepository extends Mock
    implements NotificationRepository {}

void main() {
  late NotificationsCubit notificationsCubit;
  late MockNotificationRepository mockNotificationRepository;
  late StreamController<NotificationEntity> notificationsStreamController;

  // Test data
  const testUserId = 'user-1';

  final testNotifications = [
    NotificationEntity(
      id: 'notif-1',
      userId: testUserId,
      title: 'Order Shipped',
      body: 'Your order #123 has been shipped',
      type: NotificationType.order,
      isRead: false,
      data: {'action_id': 'order-123', 'action_type': 'order_detail'},
      createdAt: DateTime(2024, 1, 15, 10, 30),
    ),
    NotificationEntity(
      id: 'notif-2',
      userId: testUserId,
      title: 'Special Offer',
      body: '50% off on selected items',
      type: NotificationType.promotion,
      isRead: true,
      createdAt: DateTime(2024, 1, 14, 9, 0),
    ),
    NotificationEntity(
      id: 'notif-3',
      userId: testUserId,
      title: 'System Update',
      body: 'App has been updated',
      type: NotificationType.system,
      isRead: false,
      createdAt: DateTime(2024, 1, 13, 8, 0),
    ),
  ];

  setUp(() {
    mockNotificationRepository = MockNotificationRepository();
    notificationsStreamController =
        StreamController<NotificationEntity>.broadcast();

    when(() => mockNotificationRepository.notificationsStream)
        .thenAnswer((_) => notificationsStreamController.stream);

    notificationsCubit =
        NotificationsCubit(repository: mockNotificationRepository);
  });

  tearDown(() {
    notificationsCubit.close();
    notificationsStreamController.close();
  });

  group('NotificationsCubit', () {
    test('initial state is NotificationsInitial', () {
      expect(notificationsCubit.state, NotificationsInitial());
    });

    test('unreadCount returns 0 initially', () {
      expect(notificationsCubit.unreadCount, 0);
    });

    group('getNotifications', () {
      blocTest<NotificationsCubit, NotificationsState>(
        'emits [NotificationsLoading, NotificationsLoaded] when getNotifications succeeds',
        build: () {
          when(() => mockNotificationRepository.getNotifications(
                page: 0,
                limit: 20,
              )).thenAnswer((_) async => Right(testNotifications));
          when(() => mockNotificationRepository.getUnreadCount())
              .thenAnswer((_) async => const Right(2));
          return notificationsCubit;
        },
        act: (cubit) => cubit.getNotifications(),
        expect: () => [
          NotificationsLoading(),
          isA<NotificationsLoaded>()
              .having((s) => s.notifications.length, 'notifications count', 3)
              .having((s) => s.unreadCount, 'unreadCount', 2)
              .having((s) => s.hasReachedMax, 'hasReachedMax', true),
        ],
      );

      blocTest<NotificationsCubit, NotificationsState>(
        'emits [NotificationsLoading, NotificationsError] when getNotifications fails',
        build: () {
          when(() => mockNotificationRepository.getNotifications(
                page: 0,
                limit: 20,
              )).thenAnswer(
              (_) async => const Left('Failed to load notifications'));
          return notificationsCubit;
        },
        act: (cubit) => cubit.getNotifications(),
        expect: () => [
          NotificationsLoading(),
          const NotificationsError('Failed to load notifications'),
        ],
      );

      blocTest<NotificationsCubit, NotificationsState>(
        'emits [NotificationsLoading, NotificationsLoaded] with empty list when no notifications',
        build: () {
          when(() => mockNotificationRepository.getNotifications(
                page: 0,
                limit: 20,
              )).thenAnswer((_) async => const Right([]));
          when(() => mockNotificationRepository.getUnreadCount())
              .thenAnswer((_) async => const Right(0));
          return notificationsCubit;
        },
        act: (cubit) => cubit.getNotifications(),
        expect: () => [
          NotificationsLoading(),
          isA<NotificationsLoaded>()
              .having((s) => s.notifications, 'notifications', isEmpty)
              .having((s) => s.unreadCount, 'unreadCount', 0),
        ],
      );

      blocTest<NotificationsCubit, NotificationsState>(
        'refresh resets pagination and loads fresh notifications',
        build: () {
          when(() => mockNotificationRepository.getNotifications(
                page: 0,
                limit: 20,
              )).thenAnswer((_) async => Right(testNotifications));
          when(() => mockNotificationRepository.getUnreadCount())
              .thenAnswer((_) async => const Right(2));
          return notificationsCubit;
        },
        act: (cubit) => cubit.getNotifications(refresh: true),
        expect: () => [
          NotificationsLoading(),
          isA<NotificationsLoaded>()
              .having((s) => s.notifications.length, 'notifications count', 3),
        ],
      );
    });

    group('markAsRead', () {
      blocTest<NotificationsCubit, NotificationsState>(
        'updates notification to read and decrements unread count',
        build: () {
          when(() => mockNotificationRepository.getNotifications(
                page: 0,
                limit: 20,
              )).thenAnswer((_) async => Right(testNotifications));
          when(() => mockNotificationRepository.getUnreadCount())
              .thenAnswer((_) async => const Right(2));
          when(() => mockNotificationRepository.markAsRead('notif-1'))
              .thenAnswer((_) async => const Right(null));
          return notificationsCubit;
        },
        act: (cubit) async {
          await cubit.getNotifications();
          await cubit.markAsRead('notif-1');
        },
        verify: (_) {
          verify(() => mockNotificationRepository.markAsRead('notif-1'))
              .called(1);
        },
      );
    });

    group('markAllAsRead', () {
      blocTest<NotificationsCubit, NotificationsState>(
        'marks all notifications as read and sets unread count to 0',
        build: () {
          when(() => mockNotificationRepository.getNotifications(
                page: 0,
                limit: 20,
              )).thenAnswer((_) async => Right(testNotifications));
          when(() => mockNotificationRepository.getUnreadCount())
              .thenAnswer((_) async => const Right(2));
          when(() => mockNotificationRepository.markAllAsRead())
              .thenAnswer((_) async => const Right(null));
          return notificationsCubit;
        },
        act: (cubit) async {
          await cubit.getNotifications();
          await cubit.markAllAsRead();
        },
        verify: (_) {
          verify(() => mockNotificationRepository.markAllAsRead()).called(1);
        },
      );
    });

    group('deleteNotification', () {
      blocTest<NotificationsCubit, NotificationsState>(
        'removes notification from list',
        build: () {
          when(() => mockNotificationRepository.getNotifications(
                page: 0,
                limit: 20,
              )).thenAnswer((_) async => Right(testNotifications));
          when(() => mockNotificationRepository.getUnreadCount())
              .thenAnswer((_) async => const Right(2));
          when(() => mockNotificationRepository.deleteNotification('notif-1'))
              .thenAnswer((_) async => const Right(null));
          return notificationsCubit;
        },
        act: (cubit) async {
          await cubit.getNotifications();
          await cubit.deleteNotification('notif-1');
        },
        verify: (_) {
          verify(() => mockNotificationRepository.deleteNotification('notif-1'))
              .called(1);
        },
      );
    });

    group('deleteAllNotifications', () {
      blocTest<NotificationsCubit, NotificationsState>(
        'clears all notifications',
        build: () {
          when(() => mockNotificationRepository.getNotifications(
                page: 0,
                limit: 20,
              )).thenAnswer((_) async => Right(testNotifications));
          when(() => mockNotificationRepository.getUnreadCount())
              .thenAnswer((_) async => const Right(2));
          when(() => mockNotificationRepository.deleteAllNotifications())
              .thenAnswer((_) async => const Right(null));
          return notificationsCubit;
        },
        act: (cubit) async {
          await cubit.getNotifications();
          await cubit.deleteAllNotifications();
        },
        verify: (_) {
          verify(() => mockNotificationRepository.deleteAllNotifications())
              .called(1);
          final state = notificationsCubit.state as NotificationsLoaded;
          expect(state.notifications, isEmpty);
          expect(state.unreadCount, 0);
        },
      );
    });
  });

  group('NotificationEntity', () {
    test('actionId returns correct value from data', () {
      final notification = testNotifications.first;
      expect(notification.actionId, 'order-123');
    });

    test('actionType returns correct value from data', () {
      final notification = testNotifications.first;
      expect(notification.actionType, 'order_detail');
    });

    test('actionId returns null when data is null', () {
      const notification = NotificationEntity(
        id: 'notif-1',
        userId: 'user-1',
        title: 'Test',
        body: 'Test body',
        type: NotificationType.system,
      );
      expect(notification.actionId, isNull);
    });

    test('copyWith creates a new instance with updated values', () {
      final original = testNotifications.first;
      final updated = original.copyWith(
        title: 'Updated Title',
        isRead: true,
      );

      expect(updated.id, original.id);
      expect(updated.userId, original.userId);
      expect(updated.title, 'Updated Title');
      expect(updated.isRead, true);
      expect(updated.body, original.body);
    });

    test('equality works correctly', () {
      final notification1 = NotificationEntity(
        id: 'notif-1',
        userId: 'user-1',
        title: 'Test',
        body: 'Test body',
        type: NotificationType.order,
        createdAt: DateTime(2024, 1, 15),
      );

      final notification2 = NotificationEntity(
        id: 'notif-1',
        userId: 'user-1',
        title: 'Test',
        body: 'Test body',
        type: NotificationType.order,
        createdAt: DateTime(2024, 1, 15),
      );

      expect(notification1, equals(notification2));
    });

    test('NotificationType enum has correct values', () {
      expect(NotificationType.values.length, 4);
      expect(NotificationType.values, contains(NotificationType.order));
      expect(NotificationType.values, contains(NotificationType.promotion));
      expect(NotificationType.values, contains(NotificationType.system));
      expect(NotificationType.values, contains(NotificationType.chat));
    });
  });

  group('NotificationsLoaded', () {
    test('copyWith creates a new instance with updated values', () {
      final state = NotificationsLoaded(
        notifications: testNotifications,
        unreadCount: 2,
        hasReachedMax: false,
      );

      final updated = state.copyWith(
        unreadCount: 0,
        hasReachedMax: true,
      );

      expect(updated.notifications, testNotifications);
      expect(updated.unreadCount, 0);
      expect(updated.hasReachedMax, true);
    });
  });
}
