import 'package:app/application/bloc/alarms/active_alarm_bloc.dart';
import 'package:app/application/bloc/events/events_history_bloc.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/navigation/app_routes.dart';
import 'package:app/presentation/pages/widgets/event_header.dart';
import 'package:app/presentation/pages/widgets/list_event_pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class EventHistoryPage extends StatelessWidget {
  const EventHistoryPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.eventHistory),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<ActiveAlarmBloc>(
              create: (BuildContext context) => ActiveAlarmBloc()..add(HasActiveAlarmEvent()),
            ),
            BlocProvider<EventsHistoryBloc>(
              create: (BuildContext context) => EventsHistoryBloc()..add(LoadHistoryEvent()),
            ),
          ],
          child: Column(
            children: [
              BlocBuilder<ActiveAlarmBloc, ActiveAlarmState>(
                builder: (context, state) {
                  if (state is ActiveAlarmInitial) {
                    return EventHeader(title: AppLocalizations.of(context)!.noActiveAlarmHeader);
                  }
                  return const SizedBox.shrink();
                },
              ),
              BlocBuilder<EventsHistoryBloc, EventsHistoryState>(
                builder: (context, state) {
                  if (state is LoadedEventsHistory) {
                    return Flexible(
                      child: ListView.builder(
                        itemCount: state.events.length,
                        itemBuilder: (context, index) => InkWell(
                          child: ListEventPair(
                            date: state.events[index].date,
                            name: state.events[index].name,
                          ),
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.eventDetail.name,
                              pathParameters: {'eventId': state.events[index].eventId},
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return const JayProgressIndicator();
                },
              ),
            ],
          ),
        ),
      );
}
