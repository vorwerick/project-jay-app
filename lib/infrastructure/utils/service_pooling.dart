import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

mixin ServicePooling {
  final l = GetIt.I<Logger>();
  Timer? _timer;

  void start(
    final void Function() onPoolingTime, {
    final Duration period = const Duration(seconds: 5),
  }) {
    l.i('Starting timer');

    if (_timer != null) {
      l.w('Timer already running');
      return;
    }

    _timer = Timer.periodic(period, (final timer) {
      onPoolingTime.call();
    });
  }

  void stop() {
    l.d('Stopping timer');
    _timer?.cancel();
    _timer = null;
  }
}
