import 'package:app/application/extensions/l.dart';
import 'package:app/application/services/alarm/alarm_service.dart';
import 'package:app/application/services/event_service.dart';
import 'package:app/domain/domain_repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> with L {
  final _repository = GetIt.I<SettingRepository>();

  LogoutCubit() : super(LogoutInitial());

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
    return emit(LogoutSuccess());
  }
}
