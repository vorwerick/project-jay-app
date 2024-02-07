import 'package:app/domain/primitives/unexpected_value_exception.dart';

final class Name {
  final String name;

  Name._(this.name);

  factory Name.fromString(String name) {
    if (name.length < 3) {
      throw UnexpectedValueException('Name $name is too short');
    }
    return Name._(name);
  }
}
