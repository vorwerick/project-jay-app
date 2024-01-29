import 'package:app/domain/entities/user.dart';
import 'package:app/domain/primitives/result.dart';

abstract interface class UserRepository {
  Future<Result<UserRepositoryState, User>> getUser();
}

sealed class UserRepositoryState {}

final class UserRepositoryError extends UserRepositoryState {
  final Exception exception;

  UserRepositoryError(this.exception);
}
