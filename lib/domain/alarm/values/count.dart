import 'package:app/domain/primitives/invalid_value_exception.dart';

final class Count {
  final int value;

  Count._(this.value);

  factory Count.create(final int value) {
    if (value < 0) {
      throw InvalidValueException('Count cannot be negative');
    }
    return Count._(value);
  }
}
