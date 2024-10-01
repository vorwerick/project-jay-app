import 'package:equatable/equatable.dart';

final class MemberDto extends Equatable {
  final String name;

  final String surname;

  final DateTime dateOfAcceptation;

  final String function;

  final bool confirmed;

  MemberDto({
    required this.name,
    required this.surname,
    required this.dateOfAcceptation,
    required this.function,
    required this.confirmed,
  });

  @override
  List<Object?> get props => [name, surname, dateOfAcceptation, function, confirmed];

  @override
  bool? get stringify => true;
}
