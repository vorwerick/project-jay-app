import 'package:app/domain/primitives/entity.dart';
import 'package:app/domain/settings/values/app_version.dart';

final class Setting extends Entity {
  final AppVersion appVersion;

  final bool isTTSEnabled;

  Setting._(super.id, this.appVersion, this.isTTSEnabled);

  // TODO(Vojjta): make id random
  factory Setting.createNew(
    final String appVersion,
    final bool isTTSEnabled,
  ) =>
      Setting._(
        1,
        AppVersion.fromString(
          appVersion,
        ),
        isTTSEnabled,
      );
}
