import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/application/dto/file_pair_dto.dart';
import 'package:app/domain/alarm/entity/alarm.dart';
import 'package:intl/intl.dart';

final class AlarmMapper {
  final Alarm alarm;

  final List<FilePairDto> _mockedFiles = [
    const FilePairDto(name: 'Test pdf file', path: 'path1.pdf'),
    const FilePairDto(name: 'Test jpg file', path: 'path2.jpg'),
    const FilePairDto(name: 'Test csv file', path: 'path3.csv'),
  ];

  AlarmMapper(this.alarm);

  AlarmDto toAlarmDetail() => AlarmDto(
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
        lastUpdate: DateFormat.yMd().add_Hms().format(alarm.lastUpdate),
        otherTechnique: '',
        notifier: alarm.announcer,
        notifierNumber: alarm.announcerPhone,
        files: _mockedFiles,
      );
}
