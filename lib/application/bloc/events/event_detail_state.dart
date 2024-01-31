part of 'event_detail_bloc.dart';

@immutable
abstract class EventDetailState extends Equatable {}

class EventDetailInitial extends EventDetailState {
  @override
  List<Object?> get props => [this];
}

final class LoadedDetailState extends EventDetailState {
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

  LoadedDetailState({
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
  });

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
      ];
}
