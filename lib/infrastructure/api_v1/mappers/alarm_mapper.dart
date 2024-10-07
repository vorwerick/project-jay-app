import 'package:app/domain/alarm/entity/alarm.dart' as entity;
import 'package:app/infrastructure/api_v1/models/json/alarm/alarm.dart';

final class AlarmJsonMapper {
  final Alarm alarm;

  AlarmJsonMapper(this.alarm);

  entity.Alarm toEntity() => entity.Alarm.create(
        alarm.eventId,
        eventId: alarm.eventId,
        confirmCount: alarm.confirmCount ?? 0,
        declineCount: alarm.declineCount ?? 0,
        state: alarm.alarmState,
        title: alarm.alarmTile,
        preview: alarm.alarmPreview,
        unitName: alarm.unitName,
        announcer: alarm.announced,
        announcerPhone: alarm.announcedPhone,
        eventType: alarm.eventType,
        lastUpdate: alarm.orderUpdate,
        region: alarm.region,
        district: alarm.district,
        city: alarm.city,
        street: alarm.street,
        floor: alarm.floor,
        object: alarm.orderObject,
        explanation: alarm.whatHappened,
        technique: alarm.unitFleet,
        otherTechnique: alarm.otherFleet,
        clarification: alarm.clarification,
        latitude: alarm.gps.x,
        longitude: alarm.gps.y, num1: alarm.num1,num2: alarm.num2
      );
}
