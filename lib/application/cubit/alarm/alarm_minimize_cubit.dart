
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'alarm_minimize_state.dart';

class AlarmMinimizeCubit extends Cubit<AlarmMinimizeState> {
  AlarmMinimizeCubit() : super(AlarmMinimized());

  bool minimized = false;

  void minimize() async {
    if (!minimized) {
      minimized = true;
      emit(AlarmMinimized());
    }
  }

  void maximize() async {
    if (minimized) {
      minimized = false;
      emit(AlarmMaximized());
    }
  }
}
