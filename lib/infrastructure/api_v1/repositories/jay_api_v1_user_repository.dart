import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app/application/extensions/l.dart';
import 'package:app/domain/common/result.dart';
import 'package:app/domain/user/entity/user.dart';
import 'package:app/domain/user/repository/user_repository.dart';
import 'package:app/infrastructure/api_v1/common/dio_api_v1.dart';
import 'package:app/infrastructure/api_v1/mappers/user_info_mapper.dart';
import 'package:app/infrastructure/api_v1/models/json/feedback.dart';
import 'package:dio/dio.dart';

final class JayApiV1UserRepository with DioApiV1, L implements UserRepository {
  @override
  Future<Result<UserRepositoryState, User>> getUser() async {
    final client = await createClient();

    try {
      log("GOLIA "+"START");
      final result = await client.getUserInfo();
      log("GOLIA BOBO");
      if (result.response.statusCode == 200) {
        final user = UserInfoJsonMapper(result.data.userData).toEntity();
        log("GOLIA "+"FETER");
        return Result.success(user);
      }
      log("GOLIA "+"BEBEo");
      return Result.failure(UserRepositoryBadResponse<int?>(result.response.statusCode));

    } on DioException catch (e) {
      l.e('Failed to get user', error: e);
      return Result.failure(UserRepositoryError(e));
    }

  }

  @override
  Future<Result<UserRepositoryState, bool>> setFeedback(final Feedback feedback) async {
    final client = await createClient();

    try {
      final result = await client.setFeedback(feedback);

      log("HARMON " + result.response.statusCode.toString());
      if (result.response.statusCode == 200) {
        return Result.success(true);
      }
      return Result.failure(UserRepositoryBadResponse<int?>(result.response.statusCode));

    } on DioException catch (e) {
      l.e('Failed to send feedback', error: e);
      return Result.failure(UserRepositoryError(e));
    }

  }
}
