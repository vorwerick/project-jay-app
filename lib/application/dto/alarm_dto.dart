import 'package:app/application/dto/file_pair_dto.dart';
import 'package:equatable/equatable.dart';

final class AlarmDto extends Equatable {
  final String unit;
  final String eventType;
  final String event;
  final String technique;
  final String region;
  final String municipality;
  final String street;
  final String object;
  final String floor;
  final String explanation;
  final String lastUpdate;
  final String otherTechnique;
  final String notifier;

  final String notifierNumber;

  final List<FilePairDto> files;

  const AlarmDto(
      {required this.unit,
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
      required this.files});

  @override
  List<Object?> get props => [
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
        List.of(files),
      ];

  @override
  bool? get stringify => true;
}
