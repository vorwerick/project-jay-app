import 'package:app/domain/primitives/entity.dart';
import 'package:app/domain/values/app_version.dart';

final class Setting extends Entity {
  final AppVersion appVersion;

  Setting._(super.id, this.appVersion);

  // TODO(Vojjta): make id random
  factory Setting.createNew(String appVersion) => Setting._(1, AppVersion.fromString(appVersion));
}
