import 'package:app/domain/primitives/invalid_value_exception.dart';

final class Name {
  final String name;

  Name._(this.name);

  factory Name.fromString(String name) {
    if (name.length < 3) {
      throw InvalidValueException('Name $name is too short');
    }
    return Name._(name);
  }
}
