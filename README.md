# TStore - Flutter E-Commerce App

[![Flutter](https://img.shields.io/badge/Flutter-3.38.4-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10.3-blue.svg)](https://dart.dev)
[![Supabase](https://img.shields.io/badge/Supabase-Backend-green.svg)](https://supabase.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![wakatime](https://wakatime.com/badge/user/018c9017-daf8-45c1-be71-8b16fd238022/project/018e3724-1bcf-41fe-86c2-770c411d1f5f.svg)](https://wakatime.com/badge/user/018c9017-daf8-45c1-be71-8b16fd238022/project/018e3724-1bcf-41fe-86c2-770c411d1f5f)

A full-featured e-commerce mobile application built with Flutter and Supabase, following Clean Architecture principles and SOLID design patterns. This project serves as a production-ready template for building scalable Flutter applications.

## Screenshots

<!-- Add your screenshots here -->
| Home | Products | Product Details |
|------|----------|-----------------|
| ![Home](screenshots/home.png) | ![Products](screenshots/products.png) | ![Details](screenshots/details.png) |

## Features

### Implemented
- [x] User Authentication (Email/Password)
- [x] OAuth Support (Google, Facebook, Apple - Ready)
- [x] Password Recovery Flow
- [x] OnBoarding Screens
- [x] Home Screen with Dynamic Banner Carousel
- [x] Product Listing (Grid/List View)
- [x] Product Search & Filtering
- [x] Product Sorting (Price, Rating, etc.)
- [x] Product Details with Variations
- [x] Categories & Brands
- [x] Wishlist Management
- [x] Shopping Cart
- [x] Order Management
- [x] User Profile Management
- [x] Address Management
- [x] Product Reviews & Ratings
- [x] Real-time Chat Support
- [x] Notifications System
- [x] Coupon System
- [x] Light/Dark Theme Support
- [x] Shimmer Loading Effects
- [x] Responsive Design

### Planned
- [ ] Push Notifications (FCM)
- [ ] Payment Integration (Stripe)
- [ ] Multi-language Support (i18n)
- [ ] Analytics Dashboard

## Architecture

This project follows **Clean Architecture** with three main layers:

```
lib/
├── core/                          # Shared functionality
│   ├── common/                    # Shared widgets & view models
│   ├── cubits/                    # App-wide state management
│   ├── supabase/                  # Supabase client & services
│   ├── utils/                     # Constants, helpers, themes
│   └── dependency_injection/      # Service locator (GetIt)
│
└── features/                      # Feature modules
    ├── auth/                      # Authentication feature
    │   ├── data/                  # Data sources, models, repos
    │   ├── domain/                # Entities, repos, use cases
    │   └── presentation/          # UI, cubits, widgets
    │
    ├── shop/                      # Shop feature (Products, Categories, Brands)
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    ├── cart/                      # Shopping Cart
    ├── wishlist/                  # Wishlist
    ├── orders/                    # Order Management
    ├── reviews/                   # Product Reviews
    ├── chat/                      # Real-time Chat
    ├── notifications/             # Notifications
    │
    └── personalization/           # User Profile & Settings
        ├── data/
        ├── domain/
        └── presentation/
```

### Key Design Patterns
- **Repository Pattern** - Abstracts data sources
- **Use Case Pattern** - Single responsibility for business logic
- **BLoC/Cubit Pattern** - Predictable state management
- **Dependency Injection** - Using GetIt for loose coupling

## Tech Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter 3.38.4 |
| Language | Dart 3.10.3 |
| Backend | Supabase (PostgreSQL) |
| Authentication | Supabase Auth |
| Database | Supabase Database |
| Storage | Supabase Storage |
| Realtime | Supabase Realtime |
| State Management | flutter_bloc 9.1.1 |
| Dependency Injection | get_it 9.2.0 |
| Error Handling | dartz 0.10.1 |
| Image Caching | cached_network_image 3.4.1 |
| Environment | flutter_dotenv 5.2.1 |

## Getting Started

### Prerequisites
- Flutter SDK 3.38.4 or higher
- Dart SDK 3.10.3 or higher
- Android Studio / VS Code
- Supabase Account (free tier available)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mahmoodhamdi/TStore.git
   cd TStore
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Setup Supabase**

   a. Create a Supabase project at [Supabase Dashboard](https://supabase.com/dashboard)

   b. Run the database schema:
      - Go to SQL Editor in Supabase Dashboard
      - Copy contents of `supabase_schema.sql` and run it
      - Copy contents of `supabase_sample_data.sql` and run it (optional - adds sample data)

   c. Create Storage Buckets:
      - Go to Storage in Supabase Dashboard
      - Create buckets: `avatars`, `products`, `reviews`, `chat`
      - Set each bucket to public (for image access)

4. **Environment Variables**

   Create a `.env` file in the root directory:
   ```env
   SUPABASE_URL=https://your-project.supabase.co
   SUPABASE_ANON_KEY=your-anon-key
   ```

   Find these values in: Supabase Dashboard > Settings > API

5. **Run the app**
   ```bash
   # Development
   flutter run -t lib/main_development.dart

   # Production
   flutter run -t lib/main_production.dart
   ```

## Project Structure

```
TStore/
├── android/                 # Android native code
├── ios/                     # iOS native code
├── lib/
│   ├── core/               # Core functionality
│   │   ├── supabase/       # Supabase services
│   │   └── ...
│   ├── features/           # Feature modules
│   ├── main_development.dart
│   ├── main_production.dart
│   └── t_store.dart        # App entry point
├── test/                   # Unit & widget tests
├── assets/
│   ├── fonts/              # Custom fonts
│   ├── images/             # Image assets
│   ├── icons/              # Icon assets
│   └── logos/              # Logo assets
├── supabase_schema.sql     # Database schema
├── supabase_sample_data.sql # Sample data with real images
├── pubspec.yaml
└── README.md
```

## Commands

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

# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/auth/auth_cubit_test.dart

# Run all unit tests
flutter test test/unit/

# Run all integration tests
flutter test test/integration/

# Analyze code
flutter analyze

# Generate launcher icons
flutter pub run flutter_launcher_icons

# Generate splash screen
flutter pub run flutter_native_splash:create
```

## Testing

The project includes comprehensive unit and integration tests covering all features.

### Test Structure

```
test/
├── unit/
│   ├── auth/
│   │   ├── auth_cubit_test.dart        # 16 tests
│   │   ├── auth_repository_test.dart   # 17 tests
│   │   └── auth_usecases_test.dart     # 12 tests
│   ├── shop/
│   │   ├── products_cubit_test.dart    # 15 tests
│   │   └── shop_usecases_test.dart     # 17 tests
│   ├── cart/
│   │   └── cart_cubit_test.dart        # 23 tests
│   ├── wishlist/
│   │   └── wishlist_cubit_test.dart    # 20 tests
│   └── orders/
│       └── orders_cubit_test.dart      # 16 tests
│
├── integration/
│   └── auth_flow_test.dart             # 11 tests
│
└── widget_test.dart
```

### Test Statistics

| Category | Tests | Coverage |
|----------|-------|----------|
| Auth Unit Tests | 45 | Cubit, Repository, UseCases |
| Shop Unit Tests | 32 | Cubit, UseCases, Entity helpers |
| Cart Unit Tests | 23 | Cubit, Entity calculations |
| Wishlist Unit Tests | 20 | Cubit, State management |
| Orders Unit Tests | 16 | Cubit, Entity helpers |
| Integration Tests | 11 | Complete auth flow |
| **Total** | **147** | - |

### Running Tests

```bash
# Run all tests
flutter test

# Run with verbose output
flutter test --reporter expanded

# Run specific feature tests
flutter test test/unit/auth/
flutter test test/unit/shop/
flutter test test/unit/cart/
flutter test test/unit/wishlist/
flutter test test/unit/orders/

# Run integration tests
flutter test test/integration/

# Generate coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html  # macOS
start coverage/html/index.html # Windows
```

### Test Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.4      # For mocking
  bloc_test: ^10.0.0    # For Cubit testing
```

## Database Schema

The app uses Supabase (PostgreSQL) with the following tables:

| Table | Description |
|-------|-------------|
| profiles | User profiles (linked to auth.users) |
| categories | Product categories |
| brands | Product brands |
| products | Product catalog |
| wishlist | User wishlists |
| cart_items | Shopping cart items |
| orders | User orders |
| order_items | Order line items |
| reviews | Product reviews |
| addresses | User addresses |
| banners | Promotional banners |
| chat_messages | Support chat messages |
| notifications | User notifications |
| coupons | Discount coupons |

## Sample Data

The `supabase_sample_data.sql` includes:
- 5 Categories (Electronics, Clothes, Shoes, Furniture, Accessories)
- 5 Brands
- 29 Products with real images
- 5 Promotional Banners
- 3 Discount Coupons (WELCOME10, SAVE20, FLASH25)

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) first.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use meaningful variable and function names
- Write unit tests for new features
- Update documentation as needed

## Roadmap

### v1.1.0 (Current)
- [x] Supabase migration (completed)
- [x] Unit tests coverage (147 tests)
- [x] Integration tests (auth flow)
- [ ] Performance optimizations

### v1.2.0
- [ ] Push notifications
- [ ] Payment integration (Stripe)
- [ ] Order tracking

### v2.0.0
- [ ] Multi-language support (i18n)
- [ ] Admin dashboard
- [ ] Analytics

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Mahmoud Hamdy**
- LinkedIn: [@mahmoud-hamdy-alashwah](https://www.linkedin.com/in/mahmoud-hamdy-alashwah/)
- GitHub: [@mahmoodhamdi](https://github.com/mahmoodhamdi)
- Email: hmdy7486@gmail.com

## Acknowledgments

- [Flutter Team](https://flutter.dev) for the amazing framework
- [Supabase Team](https://supabase.com) for the open-source backend
- [Bloc Library](https://bloclibrary.dev) for state management
- [Platzi Fake Store API](https://fakeapi.platzi.com/) for sample product images
- All contributors who helped improve this project

---

If you find this project helpful, please give it a star!
