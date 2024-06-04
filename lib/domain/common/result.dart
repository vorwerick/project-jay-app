/// Result is a sum type that represents either a success or a failure.
/// Based on Either
/// This object is not from my head, it is a well-known pattern in functional programming.
sealed class Result<L, R> {
  const Result();

  factory Result.success(R value) {
    return Success(value);
  }

  factory Result.failure(L value) {
    return Failure(value);
  }

  bool get isSuccess => this is Success<L, R>;

  bool get isFailure => this is Failure<L, R>;

  L get failure => this.fold<L>(
      (value) => value, (failure) => throw Exception('Illegal use. You should check isFailure before calling'));

  R get success => this.fold<R>(
      (success) => throw Exception('Illegal use. You should check isSuccess before calling'), (value) => value);

  T fold<T>(T Function(L left) fnL, T Function(R right) fnR);
}

final class Success<L, R> extends Result<L, R> {
  final R value;

  Success(this.value);

  @override
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR) {
    return fnR(value);
  }
}

final class Failure<L, R> extends Result<L, R> {
  final L value;

  Failure(this.value);

  @override
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR) {
    return fnL(value);
  }
}
