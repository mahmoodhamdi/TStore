import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/orders/domain/entities/order_entity.dart';
import 'package:t_store/features/orders/domain/repositories/order_repository.dart';
import 'package:t_store/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:t_store/features/orders/domain/usecases/get_order_by_id_usecase.dart';
import 'package:t_store/features/orders/domain/usecases/create_order_usecase.dart';
import 'package:t_store/features/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:t_store/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:t_store/features/orders/presentation/cubit/orders_state.dart';

// Mocks
class MockGetOrdersUsecase extends Mock implements GetOrdersUsecase {}

class MockGetOrderByIdUsecase extends Mock implements GetOrderByIdUsecase {}

class MockCreateOrderUsecase extends Mock implements CreateOrderUsecase {}

class MockCancelOrderUsecase extends Mock implements CancelOrderUsecase {}

// Fakes
class FakeNoParams extends Fake implements NoParams {}

class FakeCreateOrderParams extends Fake implements CreateOrderParams {}

void main() {
  late OrdersCubit ordersCubit;
  late MockGetOrdersUsecase mockGetOrdersUsecase;
  late MockGetOrderByIdUsecase mockGetOrderByIdUsecase;
  late MockCreateOrderUsecase mockCreateOrderUsecase;
  late MockCancelOrderUsecase mockCancelOrderUsecase;

  // Test data
  const testShippingAddress = AddressSnapshotEntity(
    fullName: 'Test User',
    phone: '+1234567890',
    address: '123 Test Street',
    city: 'Test City',
    state: 'Test State',
    postalCode: '12345',
    country: 'Test Country',
  );

  final testOrderItems = [
    const OrderItemEntity(
      id: 'item-1',
      orderId: 'order-1',
      productId: 'product-1',
      productName: 'Test Product 1',
      productImage: 'image1.jpg',
      price: 100,
      quantity: 2,
    ),
    const OrderItemEntity(
      id: 'item-2',
      orderId: 'order-1',
      productId: 'product-2',
      productName: 'Test Product 2',
      price: 50,
      quantity: 1,
    ),
  ];

  final testOrders = [
    OrderEntity(
      id: 'order-1',
      userId: 'user-1',
      addressId: 'address-1',
      status: OrderStatus.pending,
      subtotal: 250,
      shippingCost: 10,
      discount: 20,
      total: 240,
      paymentMethod: 'cash_on_delivery',
      items: testOrderItems,
      shippingAddress: testShippingAddress,
    ),
    const OrderEntity(
      id: 'order-2',
      userId: 'user-1',
      status: OrderStatus.delivered,
      subtotal: 100,
      total: 100,
      paymentMethod: 'cash_on_delivery',
    ),
  ];

  final cancelledOrder = OrderEntity(
    id: 'order-1',
    userId: 'user-1',
    addressId: 'address-1',
    status: OrderStatus.cancelled,
    subtotal: 250,
    shippingCost: 10,
    discount: 20,
    total: 240,
    paymentMethod: 'cash_on_delivery',
    items: testOrderItems,
    shippingAddress: testShippingAddress,
  );

  setUpAll(() {
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(FakeCreateOrderParams());
  });

  setUp(() {
    mockGetOrdersUsecase = MockGetOrdersUsecase();
    mockGetOrderByIdUsecase = MockGetOrderByIdUsecase();
    mockCreateOrderUsecase = MockCreateOrderUsecase();
    mockCancelOrderUsecase = MockCancelOrderUsecase();

    ordersCubit = OrdersCubit(
      getOrdersUsecase: mockGetOrdersUsecase,
      getOrderByIdUsecase: mockGetOrderByIdUsecase,
      createOrderUsecase: mockCreateOrderUsecase,
      cancelOrderUsecase: mockCancelOrderUsecase,
    );
  });

  tearDown(() {
    ordersCubit.close();
  });

  group('OrdersCubit', () {
    test('initial state is OrdersInitial', () {
      expect(ordersCubit.state, OrdersInitial());
    });

    group('getOrders', () {
      blocTest<OrdersCubit, OrdersState>(
        'emits [OrdersLoading, OrdersLoaded] when getOrders succeeds',
        build: () {
          when(() => mockGetOrdersUsecase(any()))
              .thenAnswer((_) async => Right(testOrders));
          return ordersCubit;
        },
        act: (cubit) => cubit.getOrders(),
        expect: () => [
          OrdersLoading(),
          OrdersLoaded(testOrders),
        ],
      );

      blocTest<OrdersCubit, OrdersState>(
        'emits [OrdersLoading, OrdersError] when getOrders fails',
        build: () {
          when(() => mockGetOrdersUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to load orders'));
          return ordersCubit;
        },
        act: (cubit) => cubit.getOrders(),
        expect: () => [
          OrdersLoading(),
          const OrdersError('Failed to load orders'),
        ],
      );

      blocTest<OrdersCubit, OrdersState>(
        'emits [OrdersLoading, OrdersLoaded] with empty list when no orders',
        build: () {
          when(() => mockGetOrdersUsecase(any()))
              .thenAnswer((_) async => const Right([]));
          return ordersCubit;
        },
        act: (cubit) => cubit.getOrders(),
        expect: () => [
          OrdersLoading(),
          const OrdersLoaded([]),
        ],
      );
    });

    group('getOrderById', () {
      blocTest<OrdersCubit, OrdersState>(
        'emits [OrderDetailLoading, OrderDetailLoaded] when getOrderById succeeds',
        build: () {
          when(() => mockGetOrderByIdUsecase('order-1'))
              .thenAnswer((_) async => Right(testOrders.first));
          return ordersCubit;
        },
        act: (cubit) => cubit.getOrderById('order-1'),
        expect: () => [
          OrderDetailLoading(),
          OrderDetailLoaded(testOrders.first),
        ],
      );

      blocTest<OrdersCubit, OrdersState>(
        'emits [OrderDetailLoading, OrdersError] when getOrderById fails',
        build: () {
          when(() => mockGetOrderByIdUsecase('non-existent'))
              .thenAnswer((_) async => const Left('Order not found'));
          return ordersCubit;
        },
        act: (cubit) => cubit.getOrderById('non-existent'),
        expect: () => [
          OrderDetailLoading(),
          const OrdersError('Order not found'),
        ],
      );
    });

    group('createOrder', () {
      blocTest<OrdersCubit, OrdersState>(
        'emits [OrderCreating, OrderCreated] when createOrder succeeds',
        build: () {
          when(() => mockCreateOrderUsecase(any()))
              .thenAnswer((_) async => Right(testOrders.first));
          return ordersCubit;
        },
        act: (cubit) => cubit.createOrder(
          addressId: 'address-1',
          items: [
            CreateOrderItemParams(
              productId: 'product-1',
              productName: 'Test Product',
              price: 100,
              quantity: 2,
            ),
          ],
          paymentMethod: 'cash_on_delivery',
        ),
        expect: () => [
          OrderCreating(),
          OrderCreated(testOrders.first),
        ],
      );

      blocTest<OrdersCubit, OrdersState>(
        'emits [OrderCreating, OrdersError] when createOrder fails',
        build: () {
          when(() => mockCreateOrderUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to create order'));
          return ordersCubit;
        },
        act: (cubit) => cubit.createOrder(
          addressId: 'address-1',
          items: [],
          paymentMethod: 'cash_on_delivery',
        ),
        expect: () => [
          OrderCreating(),
          const OrdersError('Failed to create order'),
        ],
      );

      blocTest<OrdersCubit, OrdersState>(
        'passes all parameters to usecase',
        build: () {
          when(() => mockCreateOrderUsecase(any()))
              .thenAnswer((_) async => Right(testOrders.first));
          return ordersCubit;
        },
        act: (cubit) => cubit.createOrder(
          addressId: 'address-1',
          items: [
            CreateOrderItemParams(
              productId: 'product-1',
              productName: 'Test',
              price: 100,
              quantity: 1,
            ),
          ],
          paymentMethod: 'card',
          couponCode: 'DISCOUNT10',
          notes: 'Please deliver quickly',
          shippingCost: 15,
          discount: 10,
        ),
        verify: (_) {
          final captured = verify(() => mockCreateOrderUsecase(captureAny()))
              .captured
              .first as CreateOrderParams;
          expect(captured.addressId, 'address-1');
          expect(captured.paymentMethod, 'card');
          expect(captured.couponCode, 'DISCOUNT10');
          expect(captured.notes, 'Please deliver quickly');
          expect(captured.shippingCost, 15);
          expect(captured.discount, 10);
        },
      );
    });

    group('cancelOrder', () {
      blocTest<OrdersCubit, OrdersState>(
        'emits [OrderCancelling, OrderCancelled] when cancelOrder succeeds',
        build: () {
          when(() => mockCancelOrderUsecase('order-1'))
              .thenAnswer((_) async => Right(cancelledOrder));
          return ordersCubit;
        },
        act: (cubit) => cubit.cancelOrder('order-1'),
        expect: () => [
          OrderCancelling(),
          OrderCancelled(cancelledOrder),
        ],
      );

      blocTest<OrdersCubit, OrdersState>(
        'emits [OrderCancelling, OrdersError] when cancelOrder fails',
        build: () {
          when(() => mockCancelOrderUsecase('order-1'))
              .thenAnswer((_) async => const Left('Cannot cancel this order'));
          return ordersCubit;
        },
        act: (cubit) => cubit.cancelOrder('order-1'),
        expect: () => [
          OrderCancelling(),
          const OrdersError('Cannot cancel this order'),
        ],
      );
    });
  });

  group('OrderEntity', () {
    test('statusText returns correct Arabic text for each status', () {
      const pendingOrder = OrderEntity(
        id: '1',
        userId: 'user-1',
        status: OrderStatus.pending,
        subtotal: 100,
        total: 100,
        paymentMethod: 'cash',
      );
      expect(pendingOrder.statusText, 'قيد الانتظار');

      const confirmedOrder = OrderEntity(
        id: '1',
        userId: 'user-1',
        status: OrderStatus.confirmed,
        subtotal: 100,
        total: 100,
        paymentMethod: 'cash',
      );
      expect(confirmedOrder.statusText, 'تم التأكيد');

      const processingOrder = OrderEntity(
        id: '1',
        userId: 'user-1',
        status: OrderStatus.processing,
        subtotal: 100,
        total: 100,
        paymentMethod: 'cash',
      );
      expect(processingOrder.statusText, 'قيد التجهيز');

      const shippedOrder = OrderEntity(
        id: '1',
        userId: 'user-1',
        status: OrderStatus.shipped,
        subtotal: 100,
        total: 100,
        paymentMethod: 'cash',
      );
      expect(shippedOrder.statusText, 'تم الشحن');

      const deliveredOrder = OrderEntity(
        id: '1',
        userId: 'user-1',
        status: OrderStatus.delivered,
        subtotal: 100,
        total: 100,
        paymentMethod: 'cash',
      );
      expect(deliveredOrder.statusText, 'تم التوصيل');

      const cancelledOrder = OrderEntity(
        id: '1',
        userId: 'user-1',
        status: OrderStatus.cancelled,
        subtotal: 100,
        total: 100,
        paymentMethod: 'cash',
      );
      expect(cancelledOrder.statusText, 'ملغي');

      const refundedOrder = OrderEntity(
        id: '1',
        userId: 'user-1',
        status: OrderStatus.refunded,
        subtotal: 100,
        total: 100,
        paymentMethod: 'cash',
      );
      expect(refundedOrder.statusText, 'مسترجع');
    });

    test('canCancel returns true only for pending and confirmed orders', () {
      const pendingOrder = OrderEntity(
        id: '1',
        userId: 'user-1',
        status: OrderStatus.pending,
        subtotal: 100,
        total: 100,
        paymentMethod: 'cash',
      );
      expect(pendingOrder.canCancel, true);

      const confirmedOrder = OrderEntity(
        id: '1',
        userId: 'user-1',
        status: OrderStatus.confirmed,
        subtotal: 100,
        total: 100,
        paymentMethod: 'cash',
      );
      expect(confirmedOrder.canCancel, true);

      const shippedOrder = OrderEntity(
        id: '1',
        userId: 'user-1',
        status: OrderStatus.shipped,
        subtotal: 100,
        total: 100,
        paymentMethod: 'cash',
      );
      expect(shippedOrder.canCancel, false);

      const deliveredOrder = OrderEntity(
        id: '1',
        userId: 'user-1',
        status: OrderStatus.delivered,
        subtotal: 100,
        total: 100,
        paymentMethod: 'cash',
      );
      expect(deliveredOrder.canCancel, false);
    });
  });

  group('OrderItemEntity', () {
    test('totalPrice calculates correctly', () {
      const item = OrderItemEntity(
        id: 'item-1',
        orderId: 'order-1',
        productId: 'product-1',
        productName: 'Test',
        price: 50,
        quantity: 3,
      );
      expect(item.totalPrice, 150);
    });
  });

  group('AddressSnapshotEntity', () {
    test('fullAddress formats correctly with state', () {
      expect(testShippingAddress.fullAddress,
          '123 Test Street, Test City, Test State, Test Country');
    });

    test('fullAddress formats correctly without state', () {
      const addressWithoutState = AddressSnapshotEntity(
        fullName: 'Test User',
        phone: '+1234567890',
        address: '123 Test Street',
        city: 'Test City',
        country: 'Test Country',
      );
      expect(addressWithoutState.fullAddress,
          '123 Test Street, Test City, Test Country');
    });
  });
}
