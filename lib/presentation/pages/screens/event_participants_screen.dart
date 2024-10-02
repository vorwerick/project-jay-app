import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/pages/screens/event_details_screen.dart';
import 'package:app/presentation/pages/screens/participants_screen.dart';
import 'package:flutter/cupertino.dart';

// This screen is used when the device is in portrait mode
class EventParticipantScreen extends StatelessWidget {
  final AlarmDto detail;
  final bool isHistory;

  const EventParticipantScreen({super.key, required this.detail, required this.isHistory});

  @override
  Widget build(final BuildContext context) => Row(
        children: [
          Flexible(
            child: EventDetailsScreen(detail: detail),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ParticipantsScreen(
                isHistory: isHistory,
                detail: detail,
              ),
            ),
          ),
        ],
      );
}
