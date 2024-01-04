import 'package:app/presentation/pages/screens/event_details_screen.dart';
import 'package:app/presentation/pages/screens/participants_screen.dart';
import 'package:flutter/cupertino.dart';

// This screen is used when the device is in portrait mode
class EventParticipantScreen extends StatelessWidget {
  const EventParticipantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: EventDetailsScreen(),
        ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ParticipantsScreen(),
        )),
      ],
    );
  }
}
