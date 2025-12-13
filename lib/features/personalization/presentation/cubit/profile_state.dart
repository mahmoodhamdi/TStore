import 'package:equatable/equatable.dart';
import 'package:t_store/features/auth/domain/entities/user_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;

  const ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final UserEntity user;

  const ProfileUpdated(this.user);

  @override
  List<Object?> get props => [user];
}

class AvatarUploading extends ProfileState {}

class AvatarUploaded extends ProfileState {
  final String avatarUrl;

  const AvatarUploaded(this.avatarUrl);

  @override
  List<Object?> get props => [avatarUrl];
}
