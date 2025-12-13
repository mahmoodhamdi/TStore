# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run Commands

```bash
# Get dependencies
flutter pub get

# Run development build
flutter run -t lib/main_development.dart

# Run production build
flutter run -t lib/main_production.dart

# Build APK
flutter build apk -t lib/main_production.dart

# Build App Bundle
flutter build appbundle -t lib/main_production.dart

# Analyze code
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

## Architecture Overview

TStore is a Flutter eCommerce app following **Clean Architecture** with three layers per feature:

```
lib/
├── core/
│   ├── common/widgets/           # Reusable UI components
│   ├── cubits/                   # App-wide state (navigation, carousel)
│   ├── dependency_injection/     # GetIt service locator (main DI)
│   ├── supabase/                 # Supabase client, service, tables, exceptions
│   ├── usecase/                  # Base UseCase<Type, Param> class
│   └── utils/
│       ├── constants/            # Colors, sizes, strings, API endpoints
│       ├── theme/                # Light/dark theme configuration
│       └── validators/           # Form validation
│
├── features/
│   ├── auth/                     # Authentication (Supabase Auth)
│   ├── shop/                     # Products, Categories, Brands, Banners
│   ├── cart/                     # Shopping cart
│   ├── wishlist/                 # Wishlist management
│   ├── orders/                   # Order management
│   ├── reviews/                  # Product reviews
│   ├── chat/                     # Real-time support chat
│   ├── notifications/            # User notifications
│   └── personalization/          # Profile, Addresses
│
├── main_development.dart         # Dev entry point
├── main_production.dart          # Prod entry point
└── t_store.dart                  # MaterialApp root widget
```

Each feature follows the same structure:
```
feature/
├── data/
│   ├── models/                   # DTOs with fromJson/toJson
│   └── repositories/             # Repository implementations
├── domain/
│   ├── entities/                 # Business objects
│   ├── repositories/             # Abstract repository interfaces
│   └── usecases/                 # Single-responsibility use cases
└── presentation/
    ├── cubit/                    # BLoC Cubits + States
    ├── views/                    # Screen widgets
    └── widgets/                  # Feature-specific widgets
```

## Key Patterns

### Dependency Injection

Single `sl` GetIt instance in `core/dependency_injection/service_locator.dart`:
- Initialized in main entry points after Supabase
- Registers: SupabaseService → Repositories → UseCases → Cubits
- Use `sl<Type>()` to resolve dependencies

```dart
// In main
await SupabaseService.initialize();
await setupServiceLocator();

// Usage
final cubit = sl<ProductsCubit>();
```

### Backend - Supabase

All data operations go through `SupabaseService` singleton:
- Auth: `signUp`, `signIn`, `signOut`, `resetPassword`, OAuth (Google/Facebook/Apple)
- Database: `getAll`, `getById`, `insert`, `update`, `upsert`, `delete`
- Storage: `uploadFile`, `getPublicUrl`, `deleteFile`
- Realtime: `subscribeToTable`, `unsubscribe`

Table names in `core/supabase/supabase_tables.dart`:
```dart
SupabaseTables.products    // 'products'
SupabaseTables.categories  // 'categories'
SupabaseTables.cartItems   // 'cart_items'
// etc.
```

### State Management

Uses **flutter_bloc** with Cubits. Pattern:
```dart
// State
abstract class FeatureState extends Equatable {}
class FeatureInitial extends FeatureState {}
class FeatureLoading extends FeatureState {}
class FeatureLoaded extends FeatureState { final Data data; }
class FeatureError extends FeatureState { final String message; }

// Cubit
class FeatureCubit extends Cubit<FeatureState> {
  final SomeUsecase usecase;

  Future<void> loadData() async {
    emit(FeatureLoading());
    final result = await usecase.call(param: params);
    result.fold(
      (error) => emit(FeatureError(error.message)),
      (data) => emit(FeatureLoaded(data)),
    );
  }
}
```

### Error Handling

Uses **dartz** `Either<Failure, T>` for functional error handling:
```dart
Future<Either<Failure, List<Product>>> getProducts();
```

Custom exceptions in `core/supabase/supabase_exception.dart`.

### Data Flow
Repository → UseCase → Cubit → View

## Environment Setup

1. Create `.env` file in root:
```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
```

2. Setup Supabase database using `supabase_schema.sql`
3. Optionally load sample data from `supabase_sample_data.sql`

## Database Schema

Main tables: profiles, categories, brands, products, wishlist, cart_items, orders, order_items, reviews, addresses, banners, chat_messages, notifications, coupons

## Testing Requirements

Write unit and integration tests for new features before pushing. All tests must pass.
