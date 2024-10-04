import 'dart:developer';

import 'package:app/application/extensions/l.dart';
import 'package:app/application/services/alarm/alarm_service.dart';
import 'package:app/application/services/event_service.dart';
import 'package:app/domain/domain_repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with L {
  final _repository = GetIt.I<SettingRepository>();

  LoginCubit() : super(LoginInitial());

  void checkAuth() async {
    l.w('Check login');
    final result = await _repository.isRegistered();

    // change settings flag
    if (result.isFailure) {
      l.w('Failed to login: ${result.failure}');
      return;
    }
    log('Login check is: ${result.success}');
    if (result.success) {
      emit(LoggedIn());
    } else {
      emit(NotLogged());
    }
  }

  Future<void> logout() async {
    final result = await _repository.registered(false);

    // change settings flag
    if (result.isFailure) {
      l.w('Failed to logout: ${result.failure}');
      return;
    }

    // disable services
    GetIt.I<AlarmService>().stopPolling();
    GetIt.I<EventService>().stopPolling();

    l.d('Logout success');
    return emit(NotLogged());
  }
}
