import 'package:app/domain/primitives/unexpected_value_exception.dart';

final class AppVersion {
  final String currentVersion;

  AppVersion._(this.currentVersion);

  factory AppVersion.fromString(String version) {
    if (version.isEmpty) {
      throw UnexpectedValueException('Version cannot be empty');
    }

    return AppVersion._(version);
  }
}
