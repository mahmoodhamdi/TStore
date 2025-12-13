import 'package:dartz/dartz.dart';

abstract class UseCase<T, Params> {
  Future<Either<String, T>> call(Params params);
}

class NoParams {
  const NoParams();
}
