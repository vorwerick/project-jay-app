import 'package:equatable/equatable.dart';

final class MemberDto extends Equatable {
  final String name;

  final String surname;

  final DateTime dateOfAcceptation;

  final String function;

  final bool confirmed;

  final int memberFunctionType;

  const MemberDto({
    required this.memberFunctionType,
    required this.name,
    required this.surname,
    required this.dateOfAcceptation,
    required this.function,
    required this.confirmed,
  });

  @override
  List<Object?> get props => [
        name,
        surname,
        dateOfAcceptation,
        function,
        confirmed,
        memberFunctionType
      ];

  @override
  bool? get stringify => true;
}
