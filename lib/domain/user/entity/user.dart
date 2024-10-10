import 'package:app/domain/common/entity.dart';
import 'package:app/domain/user/values/academic_title.dart';
import 'package:app/domain/user/values/name.dart';

final class User extends Entity {
  final Name name;
  final Name surname;
  final AcademicTitle academicTitle;
  final String email;
  final String? functionName;

  User._(super.id, this.name, this.surname, this.academicTitle, this.email,
      this.functionName);

  factory User.createNew({
    required final String name,
    required final String surname,
    required final String academicTitle,
    required final String email,
    required final String? functionName,
  }) =>
      User._(
        1,
        Name.fromString(name),
        Name.fromString(surname),
        AcademicTitle.fromString(academicTitle),
        email,
        functionName,
      );

  factory User.create({
    required final int id,
    required final String name,
    required final String surname,
    required final String academicTitle,
    required final String email,
    required final String? functionName,
  }) =>
      User._(
        id,
        Name.fromString(name),
        Name.fromString(surname),
        AcademicTitle.fromString(academicTitle),
        email,
        functionName,
      );

  String get fullNameWithTitle =>
      '$academicTitle. ${name.name} ${surname.name}';
}
