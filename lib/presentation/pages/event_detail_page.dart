import 'package:app/application/bloc/events/event_detail_bloc.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/screens/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDetailPage extends StatelessWidget {
  final int eventId;

  const EventDetailPage({super.key, required this.eventId});

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => EventDetailBloc()..add(EventDetailIdPressed(eventId)),
        child: Scaffold(
          appBar: AppBar(title: JayWhiteText(AppLocalizations.of(context)!.eventDetail)),
          body: SizedBox.expand(
            child: BlocBuilder<EventDetailBloc, EventDetailState>(
              builder: (final context, final state) {
                if (state is EventDetailLoadSuccess) {
                  return EventDetailsScreen(detail: state);
                }
                return const JayProgressIndicator();
              },
            ),
          ),
        ),
      );
}
