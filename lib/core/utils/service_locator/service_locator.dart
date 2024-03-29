import 'package:get_it/get_it.dart';
import 'package:t_store/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:t_store/features/personalization/data/repositories/user_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<UserRepoImpl>(UserRepoImpl());

  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl(getIt<UserRepoImpl>()));
}
