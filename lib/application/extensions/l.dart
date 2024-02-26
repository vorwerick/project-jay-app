import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

mixin L {
  final l = GetIt.I.get<Logger>();
}
