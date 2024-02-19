import 'package:app/application/bloc/alarms/alarm_history_bloc.dart';
import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/navigation/app_routes.dart';
import 'package:app/presentation/pages/widgets/list/list_event_pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class EventHistoryPage extends StatelessWidget {
  const EventHistoryPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider<AlarmHistoryBloc>(
        create: (final BuildContext context) => AlarmHistoryBloc()..add(AlarmHistoryStarted()),
        child: Scaffold(
          appBar: AppBar(
            title: JayWhiteText(AppLocalizations.of(context)!.eventHistory),
          ),
          body: JayContainer(
            child: Column(
              children: [
                BlocBuilder<AlarmHistoryBloc, AlarmHistoryState>(
                  builder: (final context, final state) {
                    if (state is AlarmHistoryLoadSuccess && state.events.isNotEmpty) {
                      return Flexible(
                        child: ListView.builder(
                          itemCount: state.events.length,
                          itemBuilder: (final context, final index) => InkWell(
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
                    if (state is AlarmHistoryLoadInProgress) {
                      return const Center(child: JayProgressIndicator());
                    }
                    return Center(
                      child: Text(AppLocalizations.of(context)!.eventEmpty),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
