abstract class UseCase<T, Param> {
  Future<T> call({Param param});
}

class NoParams {}