import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

mixin L {
  Logger? _l;

  @protected
  Logger get l => _l ?? (_l = _isRegistered ? GetIt.I.get<Logger>() : Logger());

  bool get _isRegistered => GetIt.I.isRegistered<Logger>();
}
