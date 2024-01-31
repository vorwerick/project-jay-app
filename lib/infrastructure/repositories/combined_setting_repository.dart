import 'package:app/domain/entities/settings.dart';
import 'package:app/domain/primitives/result.dart';
import 'package:app/domain/primitives/unexpected_value_exception.dart';
import 'package:app/domain/repositories/setting_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

final class CombinedSettingRepository implements SettingRepository {
  @override
  Future<Result<SettingRepositoryState, Setting>> getSetting() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // TODO(Vojjta): Get setting from local storage
    try {
      return Result.success(
        Setting.createNew(
          packageInfo.version,
        ),
      );
    } on UnexpectedValueException catch (e) {
      return Result.failure(SettingRepositoryError(e));
    }
  }
}
