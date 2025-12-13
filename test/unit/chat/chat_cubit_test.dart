import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t_store/features/chat/domain/entities/chat_message_entity.dart';
import 'package:t_store/features/chat/domain/repositories/chat_repository.dart';
import 'package:t_store/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:t_store/features/chat/presentation/cubit/chat_state.dart';

// Mocks
class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late ChatCubit chatCubit;
  late MockChatRepository mockChatRepository;
  late StreamController<ChatMessageEntity> messagesStreamController;

  // Test data
  const testUserId = 'user-1';
  const testOtherUserId = 'user-2';

  final testMessages = [
    ChatMessageEntity(
      id: 'msg-1',
      senderId: testUserId,
      receiverId: testOtherUserId,
      content: 'Hello!',
      messageType: MessageType.text,
      isRead: true,
      createdAt: DateTime(2024, 1, 15, 10, 30),
      senderName: 'Test User',
    ),
    ChatMessageEntity(
      id: 'msg-2',
      senderId: testOtherUserId,
      receiverId: testUserId,
      content: 'Hi there!',
      messageType: MessageType.text,
      isRead: false,
      createdAt: DateTime(2024, 1, 15, 10, 31),
      senderName: 'Other User',
    ),
  ];

  final newMessage = ChatMessageEntity(
    id: 'msg-3',
    senderId: testUserId,
    receiverId: testOtherUserId,
    content: 'New message',
    messageType: MessageType.text,
    isRead: false,
    createdAt: DateTime.now(),
    senderName: 'Test User',
  );

  setUp(() {
    mockChatRepository = MockChatRepository();
    messagesStreamController = StreamController<ChatMessageEntity>.broadcast();

    when(() => mockChatRepository.messagesStream)
        .thenAnswer((_) => messagesStreamController.stream);

    chatCubit = ChatCubit(repository: mockChatRepository);
  });

  tearDown(() {
    chatCubit.close();
    messagesStreamController.close();
  });

  group('ChatCubit', () {
    test('initial state is ChatInitial', () {
      expect(chatCubit.state, ChatInitial());
    });

    group('getMessages', () {
      blocTest<ChatCubit, ChatState>(
        'emits [ChatLoading, ChatLoaded] when getMessages succeeds',
        build: () {
          when(() => mockChatRepository.getMessages(
                otherUserId: testOtherUserId,
                page: 0,
                limit: 50,
              )).thenAnswer((_) async => Right(testMessages));
          return chatCubit;
        },
        act: (cubit) => cubit.getMessages(testOtherUserId),
        expect: () => [
          ChatLoading(),
          isA<ChatLoaded>()
              .having((s) => s.messages.length, 'messages count', 2)
              .having((s) => s.hasReachedMax, 'hasReachedMax', true),
        ],
      );

      blocTest<ChatCubit, ChatState>(
        'emits [ChatLoading, ChatError] when getMessages fails',
        build: () {
          when(() => mockChatRepository.getMessages(
                otherUserId: testOtherUserId,
                page: 0,
                limit: 50,
              )).thenAnswer((_) async => const Left('Failed to load messages'));
          return chatCubit;
        },
        act: (cubit) => cubit.getMessages(testOtherUserId),
        expect: () => [
          ChatLoading(),
          const ChatError('Failed to load messages'),
        ],
      );

      blocTest<ChatCubit, ChatState>(
        'emits [ChatLoading, ChatLoaded] with empty list when no messages',
        build: () {
          when(() => mockChatRepository.getMessages(
                otherUserId: testOtherUserId,
                page: 0,
                limit: 50,
              )).thenAnswer((_) async => const Right([]));
          return chatCubit;
        },
        act: (cubit) => cubit.getMessages(testOtherUserId),
        expect: () => [
          ChatLoading(),
          isA<ChatLoaded>()
              .having((s) => s.messages, 'messages', isEmpty)
              .having((s) => s.hasReachedMax, 'hasReachedMax', true),
        ],
      );

      blocTest<ChatCubit, ChatState>(
        'refresh resets pagination and loads fresh messages',
        build: () {
          when(() => mockChatRepository.getMessages(
                otherUserId: testOtherUserId,
                page: 0,
                limit: 50,
              )).thenAnswer((_) async => Right(testMessages));
          return chatCubit;
        },
        act: (cubit) => cubit.getMessages(testOtherUserId, refresh: true),
        expect: () => [
          ChatLoading(),
          isA<ChatLoaded>()
              .having((s) => s.messages.length, 'messages count', 2),
        ],
      );
    });

    group('sendMessage', () {
      blocTest<ChatCubit, ChatState>(
        'emits [MessageSending, MessageSent, ChatLoaded] when sendMessage succeeds',
        build: () {
          when(() => mockChatRepository.sendMessage(
                receiverId: testOtherUserId,
                content: 'New message',
                messageType: MessageType.text,
              )).thenAnswer((_) async => Right(newMessage));
          return chatCubit;
        },
        act: (cubit) => cubit.sendMessage(
          receiverId: testOtherUserId,
          content: 'New message',
        ),
        expect: () => [
          MessageSending(),
          MessageSent(newMessage),
          isA<ChatLoaded>()
              .having((s) => s.messages.length, 'messages count', 1),
        ],
      );

      blocTest<ChatCubit, ChatState>(
        'emits [MessageSending, ChatError] when sendMessage fails',
        build: () {
          when(() => mockChatRepository.sendMessage(
                receiverId: testOtherUserId,
                content: 'New message',
                messageType: MessageType.text,
              )).thenAnswer((_) async => const Left('Failed to send message'));
          return chatCubit;
        },
        act: (cubit) => cubit.sendMessage(
          receiverId: testOtherUserId,
          content: 'New message',
        ),
        expect: () => [
          MessageSending(),
          const ChatError('Failed to send message'),
        ],
      );

      blocTest<ChatCubit, ChatState>(
        'sends image message type correctly',
        build: () {
          final imageMessage = newMessage.copyWith(messageType: MessageType.image);
          when(() => mockChatRepository.sendMessage(
                receiverId: testOtherUserId,
                content: 'image.jpg',
                messageType: MessageType.image,
              )).thenAnswer((_) async => Right(imageMessage));
          return chatCubit;
        },
        act: (cubit) => cubit.sendMessage(
          receiverId: testOtherUserId,
          content: 'image.jpg',
          messageType: MessageType.image,
        ),
        verify: (_) {
          verify(() => mockChatRepository.sendMessage(
                receiverId: testOtherUserId,
                content: 'image.jpg',
                messageType: MessageType.image,
              )).called(1);
        },
      );
    });

    group('markAsRead', () {
      test('calls repository markAsRead', () async {
        when(() => mockChatRepository.markAsRead('msg-1'))
            .thenAnswer((_) async => const Right(null));

        await chatCubit.markAsRead('msg-1');

        verify(() => mockChatRepository.markAsRead('msg-1')).called(1);
      });
    });

    group('markAllAsRead', () {
      test('calls repository markAllAsRead', () async {
        when(() => mockChatRepository.markAllAsRead(testOtherUserId))
            .thenAnswer((_) async => const Right(null));

        await chatCubit.markAllAsRead(testOtherUserId);

        verify(() => mockChatRepository.markAllAsRead(testOtherUserId))
            .called(1);
      });
    });
  });

  group('ChatMessageEntity', () {
    test('isFromUser returns true when senderId matches', () {
      final message = testMessages.first;
      expect(message.isFromUser(testUserId), true);
    });

    test('isFromUser returns false when senderId does not match', () {
      final message = testMessages.first;
      expect(message.isFromUser(testOtherUserId), false);
    });

    test('copyWith creates a new instance with updated values', () {
      final original = testMessages.first;
      final updated = original.copyWith(
        content: 'Updated content',
        isRead: true,
      );

      expect(updated.id, original.id);
      expect(updated.senderId, original.senderId);
      expect(updated.content, 'Updated content');
      expect(updated.isRead, true);
    });

    test('equality works correctly', () {
      final message1 = ChatMessageEntity(
        id: 'msg-1',
        senderId: 'user-1',
        receiverId: 'user-2',
        content: 'Hello',
        createdAt: DateTime(2024, 1, 15),
      );

      final message2 = ChatMessageEntity(
        id: 'msg-1',
        senderId: 'user-1',
        receiverId: 'user-2',
        content: 'Hello',
        createdAt: DateTime(2024, 1, 15),
      );

      expect(message1, equals(message2));
    });

    test('MessageType enum has correct values', () {
      expect(MessageType.values.length, 3);
      expect(MessageType.values, contains(MessageType.text));
      expect(MessageType.values, contains(MessageType.image));
      expect(MessageType.values, contains(MessageType.system));
    });
  });

  group('ChatConversationEntity', () {
    test('equality works correctly', () {
      final conversation1 = ChatConversationEntity(
        oderId: 'order-1',
        userId: 'user-1',
        supportId: 'support-1',
        unreadCount: 5,
        updatedAt: DateTime(2024, 1, 15),
      );

      final conversation2 = ChatConversationEntity(
        oderId: 'order-1',
        userId: 'user-1',
        supportId: 'support-1',
        unreadCount: 5,
        updatedAt: DateTime(2024, 1, 15),
      );

      expect(conversation1, equals(conversation2));
    });
  });

  group('ChatLoaded', () {
    test('copyWith creates a new instance with updated values', () {
      final state = ChatLoaded(
        messages: testMessages,
        hasReachedMax: false,
      );

      final updated = state.copyWith(hasReachedMax: true);

      expect(updated.messages, testMessages);
      expect(updated.hasReachedMax, true);
    });
  });
}
