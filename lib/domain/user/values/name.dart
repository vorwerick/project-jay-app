import 'package:app/domain/common/invalid_value_exception.dart';

final class Name {
  final String name;

  Name._(this.name);

  factory Name.fromString(final String name) {
    if (name.length < 3) {
      throw InvalidValueException('Name $name is too short');
    }
    return Name._(name);
  }
}
