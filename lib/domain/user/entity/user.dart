import 'package:app/domain/common/entity.dart';
import 'package:app/domain/user/values/academic_title.dart';
import 'package:app/domain/user/values/name.dart';

final class User extends Entity {
  final Name name;
  final Name surname;
  final AcademicTitle academicTitle;

  User._(super.id, this.name, this.surname, this.academicTitle);

  factory User.createNew({
    required final String name,
    required final String surname,
    required final String academicTitle,
  }) =>
      User._(
        1,
        Name.fromString(name),
        Name.fromString(surname),
        AcademicTitle.fromString(academicTitle),
      );

  factory User.create({
    required final int id,
    required final String name,
    required final String surname,
    required final String academicTitle,
  }) =>
      User._(
        id,
        Name.fromString(name),
        Name.fromString(surname),
        AcademicTitle.fromString(academicTitle),
      );

  String get fullNameWithTitle => '$academicTitle. ${name.name} ${surname.name}';
}
