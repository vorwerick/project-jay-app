import 'package:app/domain/primitives/invalid_value_exception.dart';

sealed class AcademicTitle {
  const AcademicTitle();

  factory AcademicTitle.fromString(final String title) {
    switch (title.toLowerCase().replaceAll('.', '')) {
      case 'bc':
        return Bachelor();
      case 'ing':
        return Engineer();
      case 'mgr':
        return Master();
      case 'judr':
        return Judr();
      case '':
        return NoTitle();
      default:
        throw InvalidValueException('Unknown academic title $title');
    }
  }
}

final class Bachelor extends AcademicTitle {
  @override
  String toString() => 'Bc';
}

final class Engineer extends AcademicTitle {
  @override
  String toString() => 'Ing';
}

final class Master extends AcademicTitle {
  @override
  String toString() => 'Mgr';
}

final class NoTitle extends AcademicTitle {
  @override
  String toString() => '';
}

final class Judr extends AcademicTitle {
  @override
  String toString() => 'Judr';
}
