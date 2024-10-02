import 'package:app/domain/alarm/values/alarm_state.dart';
import 'package:app/domain/alarm/values/count.dart';
import 'package:app/domain/common/entity.dart';
import 'package:app/infrastructure/api_v1/models/json/fleet.dart';
import 'package:latlong2/latlong.dart';

final class Alarm extends Entity {
  final int eventId;
  final Count confirmedCount;

  final Count declinedCount;

  final AlarmState state;

  final String title;
  final String preview;
  final String unitName;

  final String region;

  final String district;

  final String city;

  final String street;

  final String floor;

  final String object;

  final String announcer;

  final String announcerPhone;

  final String eventType;

  final DateTime lastUpdate;

  final String explanation;

  final List<Fleet>? technique;

  final List<Fleet>? otherTechnique;

  final LatLng location;

  bool get isActive => state is Announced;

  Alarm._(
    super.id, {
    required this.eventId,
    required this.confirmedCount,
    required this.declinedCount,
    required this.state,
    required this.title,
    required this.preview,
    required this.unitName,
    required this.announcer,
    required this.announcerPhone,
    required this.eventType,
    required this.lastUpdate,
    required this.region,
    required this.district,
    required this.city,
    required this.street,
    required this.floor,
    required this.object,
    required this.explanation,
    required this.technique,
    required this.otherTechnique,
    required this.location,
  });

  factory Alarm.create(
    final int id, {
    required final int eventId,
    required final int confirmCount,
    required final int declineCount,
    required final int state,
    required final String title,
    required final String preview,
    required final String unitName,
    required final String announcer,
    required final String announcerPhone,
    required final String eventType,
    required final DateTime lastUpdate,
    required final String region,
    required final String district,
    required final String city,
    required final String street,
    required final String floor,
    required final String object,
    required final String explanation,
    required final List<Fleet>? technique,
    required final List<Fleet>? otherTechnique,
    required final double latitude,
    required final double longitude,
  }) =>
      Alarm._(
        id,
        eventId: eventId,
        confirmedCount: Count.create(confirmCount),
        declinedCount: Count.create(declineCount),
        state: AlarmState.fromInt(state),
        title: title,
        preview: preview,
        unitName: unitName,
        announcer: announcer,
        announcerPhone: announcerPhone,
        eventType: eventType,
        lastUpdate: lastUpdate,
        region: region,
        district: district,
        city: city,
        street: street,
        floor: floor,
        object: object,
        explanation: explanation,
        technique: technique,
        otherTechnique: otherTechnique,
        location: LatLng(latitude, longitude),
      );

  @override
  String toString() =>
      'Alarm{id: $id, confirmedCount: $confirmedCount, declinedCount: $declinedCount, state: $state, title: $title, preview: $preview, unitName: $unitName, announcer: $announcer, announcerPhone: $announcerPhone, eventType: $eventType}';
}
