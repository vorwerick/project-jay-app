import 'package:app/domain/entities/user.dart';
import 'package:app/domain/primitives/result.dart';
import 'package:app/domain/primitives/unexpected_value_exception.dart';
import 'package:app/domain/repositories/user_repository.dart';

final class MockedUserRepository implements UserRepository {
  @override
  Future<Result<UserRepositoryState, User>> getUser() async {
    try {
      return Result.success(User.createNew(name: 'John', surname: 'Doe', academicTitle: 'ing'));
    } on UnexpectedValueException catch (e) {
      return Result.failure(UserRepositoryError(e));
    }
  }
}
