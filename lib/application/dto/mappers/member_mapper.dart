import 'package:app/application/dto/member_dto.dart';
import 'package:app/domain/member/entity/member.dart';

final class MemberMapper {
  final Member member;

  MemberMapper(this.member);

  MemberDto toMemberDto() => MemberDto(
      name: member.name,
      surname: member.surname,
      function: member.function,
      dateOfAcceptation: member.confirmTime.toLocal(),
      confirmed: member.confirmed,
      memberFunctionType: member.memberFunctionType);
}
