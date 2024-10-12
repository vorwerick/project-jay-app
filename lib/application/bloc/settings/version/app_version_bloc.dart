import 'package:app/application/extensions/l.dart';
import 'package:app/application/shared/device_information.dart';
import 'package:app/infrastructure/shared/info_plus_device_information_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'app_version_event.dart';
part 'app_version_state.dart';

class AppVersionBloc extends Bloc<AppVersionEvent, AppVersionState> with L {
  AppVersionBloc() : super(AppVersionInitial()) {
    on<AppVersionStarted>((final event, final emit) async {
      l.i('Getting app version');
      final deviceInformation = await InfoPlusDeviceInformationService().createDeviceInformation();

      final version = deviceInformation?.version ?? '';

      emit(AppVersionLoadSuccess(version));
    });
  }
}
