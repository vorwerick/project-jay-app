/// [Either] is result object of two types but only with one value
/// Left side is used for failure and right side is used for result
sealed class Either<L, R> {
  const Either();

  factory Either.error(L value) {
    return Left<L, R>(value);
  }

  factory Either.success(R value) {
    return Right<L, R>(value);
  }

  bool get isSuccess => this is Left<L, R>;

  bool get isError => this is Right<L, R>;

  /// Get [Left] value, may throw an exception when the value is [Right]
  L get error =>
      this.fold<L>((value) => value, (right) => throw Exception('Illegal use. You should check isLeft before calling'));

  /// Get [Right] value, may throw an exception when the value is [Left]
  R get success =>
      this.fold<R>((left) => throw Exception('Illegal use. You should check isRight before calling'), (value) => value);

  /// Fold [Left] and [Right] into the value of one type
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR);
}

final class Left<L, R> extends Either<L, R> {
  final L value;

  Left(this.value);

  @override
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR) {
    return fnL(value);
  }
}

final class Right<L, R> extends Either<L, R> {
  final R value;

  Right(this.value);

  @override
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR) {
    return fnR(value);
  }
}
