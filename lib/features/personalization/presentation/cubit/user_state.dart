part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserSaving extends UserState {}

class UserSaved extends UserState {}

class UserImageUploading extends UserState {}

class UserImageUploadFailed extends UserState {
  final String message;
  const UserImageUploadFailed({required this.message});
}

class UserImageUploaded extends UserState {}

class UserSaveFailed extends UserState {
  final String message;
  const UserSaveFailed({required this.message});
}

class UserFetching extends UserState {}

class UserFetched extends UserState {
  final UserModel user;
  const UserFetched(this.user);
}

class UserUpdating extends UserState {}

class UserUpdated extends UserState {}

class UserFetchFailed extends UserState {
  final String message;
  const UserFetchFailed({required this.message});
}

class UserFailure extends UserState {
  final String message;
  const UserFailure({required this.message});
}
