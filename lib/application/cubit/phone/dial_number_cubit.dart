import 'dart:developer';

import 'package:app/application/commands/dial_number_async_cmd.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'dial_number_state.dart';

class DialNumberCubit extends Cubit<DialNumberState> {
  DialNumberCubit() : super(DialNumberInitial());

  void dialNumber(final String phoneNumber, final String prefix) async {
    log('Dial number pressed: $phoneNumber', name: 'DialNumberCubit');

    if (!(await DialNumberAsyncCmd(prefix: prefix, phoneNumber: phoneNumber)
        .execute())) {
      emit(DialNumberFailed(number: phoneNumber));
      log('Dial number failed: $phoneNumber', name: 'DialNumberCubit');
      return;
    }

    log('Dial number success: $phoneNumber', name: 'DialNumberCubit');
  }

  @override
  void onChange(final Change<DialNumberState> change) {
    super.onChange(change);
    log('DialNumberCubit state changed: $change', name: 'DialNumberCubit');
  }
}
