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
        lastUpdate: DateFormat.yMd().add_Hms().format(alarm.lastUpdate.toLocal()),
        otherTechnique: alarm.otherTechnique,
        notifier: alarm.announcer,
        notifierNumber: alarm.announcerPhone,
        files: _mockedFiles,
      );

  String toSpeechText() =>
      'Vyhlášen poplach pro jednotku ${this.alarm.unitName}.Typ události ${this.alarm.eventType}. Kraj ${this.alarm.region}. Město ${this.alarm.city}. Ulice ${this.alarm.street}. Budova ${this.alarm.object}. Podlaží ${this.alarm.floor}. Popis ${this.alarm.explanation}.';
}
