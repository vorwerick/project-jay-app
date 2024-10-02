import 'package:app/application/bloc/alarms/alarm_history_bloc.dart';
import 'package:app/configuration/navigation/app_routes.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EventHistoryPage extends StatelessWidget {
  const EventHistoryPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider<AlarmHistoryBloc>(
        create: (final BuildContext context) =>
            AlarmHistoryBloc()..add(AlarmHistoryStarted()),
        child: Scaffold(
          appBar: AppBar(
            title: JayWhiteText(AppLocalizations.of(context)!.eventHistory),
          ),
          body: BlocBuilder<AlarmHistoryBloc, AlarmHistoryState>(
            builder: (final context, final state) {
              if (state is AlarmHistoryLoadSuccess && state.events.isNotEmpty) {
                return JayContainer(
                  child: ListView.separated(
                    itemCount: state.events.length,
                    itemBuilder: (final context, final index) => ListTile(
                      minVerticalPadding: 0,
                      leading: DateTime.now().millisecondsSinceEpoch -
                                  state.events[index].date
                                      .millisecondsSinceEpoch >=
                              600000
                          ? Icon(Icons.history)
                          : Icon(
                              Icons.local_fire_department,
                              color: JayColors.primary,
                            ),
                      title: Text(state.events[index].name),
                      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat.yMd()
                              .add_Hms()
                              .format(state.events[index].date),),
                          if (DateTime.now().millisecondsSinceEpoch -
                                  state.events[index].date
                                      .millisecondsSinceEpoch <=
                              600000)
                            Container(
                              color: JayColors.primary,
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              margin: EdgeInsets.all(4),
                              child: Text("Aktivní",style: TextStyle(color: Colors.white)),
                            )
                        ],
                      ),
                      onTap: () {
                        context.pushNamed(
                          AppRoutes.eventDetail.name,
                          pathParameters: {
                            'eventId': state.events[index].eventId
                          },
                        );
                      },
                    ),
                    separatorBuilder:
                        (final BuildContext context, final int index) =>
                            const Divider(),
                  ),
                );
              }
              if (state is AlarmHistoryLoadSuccess && state.events.isEmpty) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.eventEmpty),
                );
              }
              if (state is AlarmHistoryLoadInProgress) {
                return const Center(child: JayProgressIndicator());
              }
              if (state is AlarmHistoryLoadFailure) {
                return Center(
                  child: JayWhiteText(
                      AppLocalizations.of(context)!.checkConnection,
                      fontSize: 20),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );
}
