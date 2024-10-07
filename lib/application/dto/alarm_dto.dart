import 'package:app/application/dto/file_pair_dto.dart';
import 'package:app/infrastructure/api_v1/models/json/fleet.dart';
import 'package:equatable/equatable.dart';

final class AlarmDto extends Equatable {
  final int eventId;
  final String unit;
  final String eventType;
  final String event;
  final List<Fleet>? technique;
  final String region;
  final String municipality;
  final String street;
  final String object;
  final String floor;
  final String explanation;
  final String lastUpdate;
  final List<Fleet>? otherTechnique;
  final String notifier;
  final String? num1;
  final String? num2;
  final String? clarification;

  final String notifierNumber;

  final List<FilePairDto> files;

  const AlarmDto({
    required this.eventId,
    required this.unit,
    required this.eventType,
    required this.event,
    required this.technique,
    required this.region,
    required this.municipality,
    required this.street,
    required this.object,
    required this.floor,
    required this.explanation,
    required this.lastUpdate,
    required this.otherTechnique,
    required this.notifier,
    required this.notifierNumber,
    required this.num1,
    required this.num2,
    required this.clarification,
    required this.files,
  });

  @override
  List<Object?> get props => [
        eventId,
        unit,
        eventType,
        event,
        technique,
        region,
        municipality,
        street,
        object,
        floor,
        explanation,
        lastUpdate,
        otherTechnique,
        notifier,
        otherTechnique,
        num1,
        num2,
        clarification,
        List.of(files),
      ];

  @override
  bool? get stringify => true;

  String toSpeechText() =>
      'Vyhlášen poplach pro jednotku ${this.unit}.Typ události ${this.eventType}. Kraj ${this.region}. Město ${this.municipality}. Ulice ${this.street}. Budova ${this.object}. Podlaží ${this.floor}. Popis ${this.explanation}.';
}
