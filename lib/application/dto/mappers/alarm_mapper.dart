import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/application/dto/file_pair_dto.dart';
import 'package:app/domain/alarm/entity/alarm.dart';
import 'package:intl/intl.dart';

final class AlarmMapper {
  final Alarm alarm;

  final List<FilePairDto> _mockedFiles = [
    const FilePairDto(name: 'Plan domu test', path: 'assets/plan-domu.pdf'),
  ];

  AlarmMapper(this.alarm);

  AlarmDto toAlarmDetail() => AlarmDto(
        confirmCount: alarm.confirmedCount.value,
        declineCount: alarm.declinedCount.value,
        orderSentTimestamp: alarm.orderSent.millisecondsSinceEpoch,
        eventId: alarm.eventId,
        unit: alarm.unitName,
        eventType: alarm.eventType,
        event: alarm.title,
        technique: alarm.technique,
        region: alarm.region,
        municipality: alarm.city,
        street: alarm.street,
        object: alarm.object,
        floor: alarm.floor,
        explanation: alarm.explanation,
        lastUpdate: DateFormat("dd.MM.yyyy\nHH:mm:ss")
            .format(alarm.lastUpdate.toLocal()),
        otherTechnique: alarm.otherTechnique,
        notifier: alarm.announcer,
        notifierNumber: alarm.announcerPhone,
        files: _mockedFiles,
        num1: alarm.num1,
        num2: alarm.num2,
        clarification: alarm.clarification,
      );
}
