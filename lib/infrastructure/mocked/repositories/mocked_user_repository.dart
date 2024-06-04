import 'package:app/domain/common/invalid_value_exception.dart';
import 'package:app/domain/common/result.dart';
import 'package:app/domain/user/entity/user.dart';
import 'package:app/domain/user/repository/user_repository.dart';

final class MockedUserRepository implements UserRepository {
  @override
  Future<Result<UserRepositoryState, User>> getUser() async {
    try {
      return Result.success(User.createNew(name: 'John', surname: 'Doe', academicTitle: 'ing'));
    } on InvalidValueException catch (e) {
      return Result.failure(UserRepositoryError(e));
    }
  }
}
