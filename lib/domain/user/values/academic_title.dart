import 'package:app/domain/primitives/unexpected_value_exception.dart';

sealed class AcademicTitle {
  const AcademicTitle();

  factory AcademicTitle.fromString(final String title) {
    switch (title.toLowerCase()) {
      case 'bc':
        return Bachelor();
      case 'ing':
        return Engineer();
      case 'mgr':
        return Master();
      default:
        throw UnexpectedValueException('Unknown academic title $title');
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
