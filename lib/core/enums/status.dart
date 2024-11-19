enum RegisterStatus { initial, loading, success, failure }

enum LoginStatus { initial, loading, success, failure }

enum CachedUserStatus { initial, loading, success, failure }

enum LogoutStatus { initial, loading, success, failure }

enum ForgetPasswordStatus { initial, loading, success, failure }

enum SetNewPasswordStatus { initial, loading, success, failure }

enum SliderImagesStatus { initial, loading, success, failure }

enum CategoriesStatus { initial, loading, success, failure }

enum ProductStatus { initial, loading, loadingMore, success, failure }

enum CategoryNameStatus { initial, loading, success, failure }

enum GetUserFavouritesStatus { initial, loading, success, failure }

enum AddToFavouritesStatus { initial, loading, success, failure }

enum UpdateProfileStatus { initial, loading, success, failure }

enum ProfileStatus { initial, loading, success, failure }

enum FavouritesStatus {
  initial,
  addingToFavouritesLoading,
  addingToFavouritesSuccess,
  addingToFavouritesFailure,
  fetchingFavouritesLoading,
  fetchingFavouritesSuccess,
  fetchingFavouritesFailure
}
enum SnackBarType { info, success, error, warning }

enum CartStatus { initial, loading, success, error }
