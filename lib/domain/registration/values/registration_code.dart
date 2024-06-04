import 'package:app/domain/common/invalid_value_exception.dart';

final class RegistrationCode {
  final String code;

  RegistrationCode._(this.code);

  factory RegistrationCode.fromString(final String code) {
    if (code.isEmpty) {
      throw InvalidValueException('Code cannot be empty');
    }

    if (code.length != 6) {
      throw InvalidValueException('Code {$code} must be exactly 6 characters long');
    }

    return RegistrationCode._(code);
  }
}
