import 'dart:async';
import 'dart:developer';

mixin ServicePooling {
  Timer? _timer;

  void start(
    final void Function() onPoolingTime, {
    final Duration period = const Duration(seconds: 5),
  }) {
    log('Starting timer', name: 'ServicePooling');

    if (_timer != null) {
      log('Timer already running', name: 'ServicePooling');
      return;
    }

    _timer = Timer.periodic(period, (final _) {
      onPoolingTime.call();
    });
  }

  void stop() {
    log('Stopping timer', name: 'ServicePooling');
    _timer?.cancel();
    _timer = null;
  }
}
