import 'package:app/domain/common/invalid_value_exception.dart';
import 'package:app/domain/common/result.dart';
import 'package:app/domain/user/entity/user.dart';
import 'package:app/domain/user/repository/user_repository.dart';
import 'package:app/infrastructure/api_v1/models/json/feedback.dart';

final class MockedUserRepository implements UserRepository {
  @override
  Future<Result<UserRepositoryState, User>> getUser() async {
    try {
      return Result.success(User.createNew(
          name: 'John',
          surname: 'Doe',
          academicTitle: 'ing',
          email: "john.doe@doe.com",
          functionName: "Hasič"));
    } on InvalidValueException catch (e) {
      return Result.failure(UserRepositoryError(e));
    }
  }

  @override
  Future<Result<UserRepositoryState, bool>> setFeedback(final Feedback feedback) async {
    try {
      return Result.success(true);
    } on InvalidValueException catch (e) {
      return Result.failure(UserRepositoryError(e));
    }
  }


}
