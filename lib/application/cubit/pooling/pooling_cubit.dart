import 'dart:async';
import 'dart:developer';

import 'package:app/application/extensions/l.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pooling_state.dart';

class PoolingCubit extends Cubit<PoolingState> with L {
  PoolingCubit() : super(PoolingStarted());

  Timer? timer;
  bool isDisposed = false;

  void start(final Duration duration) async {
    if (isDisposed) return;
    timer = Timer.periodic(duration, (final count) {
      log("refetch");
      emit(PoolingFetched());
    });
  }

  void dispose() {
    timer?.cancel();
    timer = null;
    isDisposed = true;
  }
}
