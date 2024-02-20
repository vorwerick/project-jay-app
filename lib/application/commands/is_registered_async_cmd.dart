import 'dart:developer';

import 'package:app/application/commands/command.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';

final class IsRegisteredAsync implements AsyncCommand<bool> {
  final SettingRepository _settingRepository;

  IsRegisteredAsync(this._settingRepository);

  /// This is temporary method, so its now evaluating all results
  @override
  Future<bool> execute() async {
    final result = await _settingRepository.isRegistered();

    if (result.isFailure) {
      log('Can not get isRegistered flag', name: 'IsRegisteredAsync');
      return false;
    }

    return result.success;
  }
}
