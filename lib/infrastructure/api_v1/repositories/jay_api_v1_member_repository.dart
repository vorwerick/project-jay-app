import 'package:app/domain/member/entity/member.dart';
import 'package:app/domain/member/repository/member_repository.dart';
import 'package:app/domain/primitives/result.dart';
import 'package:app/infrastructure/api_v1/common/dio_api_v1.dart';
import 'package:app/infrastructure/api_v1/mappers/alarm_member_mapper.dart';
import 'package:app/infrastructure/api_v1/validation/api_response_validation.dart';

final class JayApiV1MemberRepository with DioApiV1 implements MemberRepository {
  @override
  Future<Result<MemberRepositoryState, List<Member>>> getMembersById(final int id) async {
    final client = await createClient();

    try {
      final result = await client.getAlarmConfirmationById(id);

      if (ApiResponseValidation(result).isValid) {
        final members = result.data.alarmConfirmation!.alarmMembers
            .map(
              (final m) => AlarmMemberJsonMapper(m).toMember(),
            )
            .toList();

        return Result.success(members);
      } else {
        return Result.success([]);
      }
    } on Exception catch (e) {
      return Result.failure(MemberRepositoryFailure(e));
    }
  }
}
