import 'package:app/domain/common/entity.dart';

final class Member extends Entity {
  final String name;

  final String surname;

  final String function;

  final bool confirmed;

  final DateTime confirmTime;

  final int memberFunctionType;

  Member(super.id,
      {required this.name,
      required this.surname,
      required this.function,
      required this.confirmed,
      required this.confirmTime,
      required this.memberFunctionType});
}
