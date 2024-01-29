import 'package:app/application/bloc/events/event_detail_bloc.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/pages/screens/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDetailPage extends StatelessWidget {
  final int eventId;

  const EventDetailPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => EventDetailBloc()..add(LoadDetailEvent(eventId)),
        child: Scaffold(
          appBar: AppBar(title: Text(AppLocalizations.of(context)!.eventDetail)),
          body: SizedBox.expand(
            child: BlocBuilder<EventDetailBloc, EventDetailState>(
              builder: (context, state) {
                if (state is LoadedDetailState) {
                  return EventDetailsScreen(detail: state);
                }
                return const JayProgressIndicator();
              },
            ),
          ),
        ),
      );
}
