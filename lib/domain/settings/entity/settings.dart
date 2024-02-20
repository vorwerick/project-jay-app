import 'package:app/domain/primitives/entity.dart';

final class Setting extends Entity {
  // final AppVersion appVersion;

  final bool isTTSEnabled;

  final bool isRegistered;

  Setting._(super.id, this.isTTSEnabled, this.isRegistered);

  // TODO(Vojjta): make id random
  factory Setting.createNew(
    final bool isTTSEnabled,
    final bool isRegistered,
  ) =>
      Setting._(
        1,
        isTTSEnabled,
        isRegistered,
      );
}
