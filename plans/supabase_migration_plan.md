# خطة ربط المشروع بـ Supabase وتنفيذ جميع الفيتشرز

## نظرة عامة

### الهدف
- ~~إزالة الـ APIs الحالية (DummyJSON & Master Market)~~ ✅ تم
- ~~ربط المشروع بـ Supabase كـ Backend كامل~~ ✅ تم
- ~~إزالة Firebase بالكامل~~ ✅ تم
- تنفيذ جميع الفيتشرز المخطط لها

### Supabase يوفر:
- **Authentication**: تسجيل/دخول بالبريد، Google، Facebook
- **Database**: PostgreSQL للبيانات
- **Storage**: تخزين الصور والملفات
- **Realtime**: للـ Chat والتحديثات الفورية
- **Edge Functions**: للـ Business Logic المعقدة

---

## الحالة الحالية ✅

### ما تم إنجازه:

#### Core Setup
- [x] إضافة `supabase_flutter` package
- [x] إنشاء `SupabaseConfig` للـ credentials
- [x] إنشاء `SupabaseService` للعمليات
- [x] إنشاء `SupabaseTables` للـ table names
- [x] إنشاء `SupabaseException` للأخطاء
- [x] إعداد `.env` للـ credentials
- [x] إعداد `service_locator.dart` للـ DI

#### Database Schema
- [x] إنشاء `supabase_schema.sql` الكامل
- [x] جداول: profiles, categories, brands, products, addresses, wishlist, cart_items, orders, order_items, reviews, banners, chat_messages, notifications, coupons
- [x] Indexes للأداء
- [x] Row Level Security (RLS) policies
- [x] Triggers للـ auto-update

#### Firebase Removal ✅
- [x] حذف `firebase_options.dart`
- [x] حذف `firebase.json`
- [x] حذف `google-services.json`
- [x] حذف Firebase exception files
- [x] إزالة Firebase plugins من `build.gradle`
- [x] إزالة Firebase من `settings.gradle`
- [x] تحديث `Fastfile` لإزالة Firebase App Distribution
- [x] حذف Firebase workflow من GitHub Actions

---

## المرحلة 3: تنفيذ الفيتشرز

### 3.1 Authentication (المصادقة) ✅
- [x] تسجيل بالبريد وكلمة المرور
- [x] تسجيل الدخول
- [x] تسجيل بـ Google (OAuth ready)
- [x] تسجيل بـ Facebook (OAuth ready)
- [x] تسجيل بـ Apple (OAuth ready)
- [x] نسيت كلمة المرور
- [x] Entity, Model, Repository, UseCases, Cubit

### 3.2 Products (المنتجات) ✅
- [x] Entity مع UUID String IDs
- [x] Model مع fromJson/toJson
- [x] Repository مع Supabase queries
- [x] UseCases (getProducts, getById, search)
- [x] ProductsCubit
- [x] دعم Pagination
- [x] دعم الفلترة (category, brand, featured)
- [x] دعم الترتيب

### 3.3 Categories & Brands ✅
- [x] CategoryEntity, CategoryModel
- [x] BrandEntity, BrandModel
- [x] CategoryRepository, BrandRepository
- [x] GetCategoriesUsecase, GetBrandsUsecase
- [x] CategoriesCubit, BrandsCubit

### 3.4 Banners ✅
- [x] BannerEntity, BannerModel
- [x] BannerRepository
- [x] GetBannersUsecase
- [x] BannersCubit

### 3.5 Wishlist (المفضلة) ✅
- [x] WishlistItemEntity, WishlistItemModel
- [x] WishlistRepository
- [x] UseCases (get, add, remove)
- [x] WishlistCubit

### 3.6 Cart (سلة التسوق) ✅
- [x] CartItemEntity, CartItemModel
- [x] CartRepository
- [x] UseCases (get, add, update, remove, clear)
- [x] CartCubit

### 3.7 Orders (الطلبات) ✅
- [x] OrderEntity مع OrderStatus enum
- [x] OrderItemEntity, AddressSnapshotEntity
- [x] OrderModel, OrderItemModel
- [x] OrderRepository
- [x] UseCases (getOrders, getById, create, cancel)
- [x] OrdersCubit

### 3.8 Reviews (التقييمات) ✅
- [x] ReviewEntity مع ProductReviewStats
- [x] ReviewModel
- [x] ReviewRepository
- [x] UseCases (getProductReviews, addReview)
- [x] ReviewsCubit

### 3.9 Addresses (العناوين) ✅
- [x] AddressEntity, AddressModel
- [x] AddressRepository
- [x] UseCases (get, add, update, delete)
- [x] AddressesCubit

### 3.10 Profile (الملف الشخصي) ✅
- [x] ProfileRepository
- [x] UseCases (getProfile, updateProfile)
- [x] ProfileCubit
- [x] Avatar upload support

### 3.11 Chat (الدعم) ✅
- [x] ChatMessageEntity مع MessageType enum
- [x] ChatMessageModel
- [x] ChatRepository مع Realtime streaming
- [x] ChatCubit مع real-time listening

### 3.12 Notifications (الإشعارات) ✅
- [x] NotificationEntity مع NotificationType enum
- [x] NotificationModel
- [x] NotificationRepository مع Realtime streaming
- [x] NotificationsCubit

---

## الخطوات التالية

### 1. تشغيل Schema في Supabase ✅
```bash
# انسخ محتوى supabase_schema.sql
# والصقه في Supabase SQL Editor
# ثم اضغط Run
```

### 2. إنشاء Storage Buckets ✅
في Supabase Dashboard → Storage:
- `avatars` - لصور المستخدمين ✅
- `products` - لصور المنتجات ✅
- `reviews` - لصور التقييمات ✅
- `chat` - للملفات في الشات ✅

### 3. تحديث الـ UI ✅
- [x] تحديث UI screens لاستخدام الـ Cubits الجديدة
- [x] إضافة BlocProviders في الـ widget tree
- [x] تحديث Home screen لاستخدام ProductsCubit
- [x] تحديث PromoBannerCarouselSlider لاستخدام BannersCubit
- [ ] تحديث Navigation (Optional - للمراجعة)

### 4. Testing
- [ ] Unit tests للـ repositories
- [ ] Integration tests للـ features
- [ ] End-to-end testing

### 5. إضافة Sample Data ✅
```sql
-- شغل الملف: supabase_sample_data.sql
-- في Supabase SQL Editor
-- يحتوي على:
-- - 5 Categories
-- - 5 Brands
-- - 29 Products (with real images from imgur)
-- - 5 Banners
-- - 3 Coupons
```

---

## ملفات مهمة

| الملف | الوصف |
|-------|-------|
| `lib/core/supabase/supabase_service.dart` | Supabase client و operations |
| `lib/core/supabase/supabase_config.dart` | Credentials من .env |
| `lib/core/supabase/supabase_tables.dart` | Table names constants |
| `lib/core/dependency_injection/service_locator.dart` | GetIt DI setup |
| `supabase_schema.sql` | Database schema الكامل |
| `supabase_sample_data.sql` | Sample data مع صور حقيقية |
| `.env` | Supabase credentials |

---

## ملاحظات مهمة

1. **الأمان**:
   - RLS مفعل على كل الجداول
   - Credentials في `.env` (مضاف لـ .gitignore)

2. **الأداء**:
   - Pagination في كل القوائم
   - Indexes على الأعمدة المهمة

3. **Realtime**:
   - Chat و Notifications يستخدمون Supabase Realtime

4. **Error Handling**:
   - `SupabaseException` للأخطاء الموحدة
   - `TExceptions` للأخطاء العامة

---

## التاريخ

| التاريخ | الإنجاز |
|---------|---------|
| 2025-12-13 | إزالة Firebase بالكامل |
| 2025-12-13 | إصلاح جميع الـ compilation errors |
| 2025-12-13 | إنشاء جميع الـ Features للـ Supabase |
| 2025-12-13 | إنشاء Database Schema الكامل |
| 2025-12-13 | تحديث UI لاستخدام Supabase Cubits (Home, Banners) |
| 2025-12-13 | تشغيل Schema في Supabase SQL Editor |
| 2025-12-13 | إنشاء Storage Buckets (avatars, products, reviews, chat) |
| 2025-12-13 | إنشاء Sample Data SQL مع صور حقيقية (29 منتج، 5 فئات، 5 براندات) |
