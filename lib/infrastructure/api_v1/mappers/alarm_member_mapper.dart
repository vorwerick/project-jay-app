import 'package:app/domain/member/entity/member.dart';
import 'package:app/infrastructure/api_v1/models/json/alarm_confirmation/alarm_confirmation_detail.dart';

final class AlarmMemberJsonMapper {
  final AlarmMember json;

  AlarmMemberJsonMapper(this.json);

  Member toMember() => Member(
        json.memberId,
        name: json.firstName,
        surname: json.lastName,
        function: json.memberFunctionText,
        confirmed: json.confirmAlarm,
        confirmTime: json.confirmDate,
      );
}
