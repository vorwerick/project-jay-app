import 'package:equatable/equatable.dart';

final class EventDto extends Equatable {
  final String eventId;
  final String name;

  final DateTime date;

  const EventDto(this.eventId, this.name, this.date);

  @override
  List<Object?> get props => [eventId, name, date];
}
