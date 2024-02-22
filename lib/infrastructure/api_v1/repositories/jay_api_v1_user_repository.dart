import 'package:app/application/extensions/l.dart';
import 'package:app/domain/primitives/result.dart';
import 'package:app/domain/user/entity/user.dart';
import 'package:app/domain/user/repository/user_repository.dart';
import 'package:app/infrastructure/api_v1/common/dio_api_v1.dart';
import 'package:app/infrastructure/api_v1/mappers/user_info_mapper.dart';

final class JayApiV1UserRepository with DioApiV1, L implements UserRepository {
  @override
  Future<Result<UserRepositoryState, User>> getUser() async {
    final client = await createClient();

    try {
      final result = await client.getUserInfo();

      if (result.response.statusCode != 200) {
        Result.failure(UserRepositoryBadResponse<int?>(result.response.statusCode));
      }
      final user = UserInfoJsonMapper(result.data.userData).toEntity();

      return Result.success(user);
    } on Exception catch (e) {
      l.e('Failed to get user', error: e);
      return Result.failure(UserRepositoryError(e));
    }
  }
}
