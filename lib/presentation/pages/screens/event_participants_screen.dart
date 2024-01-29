import 'package:app/application/bloc/events/event_detail_bloc.dart';
import 'package:app/presentation/pages/screens/event_details_screen.dart';
import 'package:app/presentation/pages/screens/participants_screen.dart';
import 'package:flutter/cupertino.dart';

// This screen is used when the device is in portrait mode
class EventParticipantScreen extends StatelessWidget {
  final LoadedDetailState detail;

  const EventParticipantScreen({super.key, required this.detail});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Flexible(
            child: EventDetailsScreen(detail: detail),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ParticipantsScreen(),
            ),
          ),
        ],
      );
}
