import 'package:app/infrastructure/api_v1/models/json/alarm/alarm.dart';
import 'package:app/infrastructure/api_v1/validation/validation.dart';

final class ActiveAlarmValidation extends Validation<Alarm> {
  ActiveAlarmValidation(super.alarms);

  @override
  bool get isValid => _isValid();

  bool _isValid() {
    final beforeTime = DateTime.now().add(const Duration(days: -2, minutes: -30));

    if (data.orderSent.isBefore(beforeTime)) {
      return false;
    }

    return true;
  }
}
