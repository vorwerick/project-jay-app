import 'package:app/domain/primitives/result.dart';
import 'package:app/domain/user/entity/user.dart';

abstract interface class UserRepository {
  Future<Result<UserRepositoryState, User>> getUser();
}

sealed class UserRepositoryState {}

final class UserRepositoryError extends UserRepositoryState {
  final Exception exception;

  UserRepositoryError(this.exception);
}
