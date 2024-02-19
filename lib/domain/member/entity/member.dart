import 'package:app/domain/primitives/entity.dart';

final class Member extends Entity {
  final String name;

  final String surname;

  final String function;

  final bool confirmed;

  final DateTime confirmTime;

  Member(
    super.id, {
    required this.name,
    required this.surname,
    required this.function,
    required this.confirmed,
    required this.confirmTime,
  });
}
