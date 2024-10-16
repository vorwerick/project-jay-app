import 'package:app/application/bloc/alarms/alarm_history_bloc.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/event_page_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EventHistoryList extends StatelessWidget {
  final int memberId;

  const EventHistoryList({super.key, required this.memberId});

  @override
  Widget build(final BuildContext context) => BlocProvider<AlarmHistoryBloc>(
        create: (final BuildContext context) =>
            AlarmHistoryBloc()..add(AlarmHistoryStarted()),
        child: BlocBuilder<AlarmHistoryBloc, AlarmHistoryState>(
          builder: (final context, final state) {
            if (state is AlarmHistoryLoadSuccess) {
              state.events.removeWhere((e) =>
                  DateTime.now().millisecondsSinceEpoch -
                      e.date.millisecondsSinceEpoch <=
                  600000);
              if (state.events.isNotEmpty) {
                return JayContainer(
                  child: ListView.separated(
                    itemCount: state.events.length,
                    itemBuilder: (final context, final index) => ListTile(
                      minVerticalPadding: 0,
                      leading: DateTime.now().millisecondsSinceEpoch -
                                  state.events[index].date
                                      .millisecondsSinceEpoch >=
                              600000
                          ? const Icon(Icons.history)
                          : const Icon(
                              Icons.local_fire_department,
                              color: JayColors.primary,
                            ),
                      title: Text(state.events[index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.yMd()
                                .add_Hms()
                                .format(state.events[index].date),
                          ),
                          if (DateTime.now().millisecondsSinceEpoch -
                                  state.events[index].date
                                      .millisecondsSinceEpoch <=
                              600000)
                            Container(
                              color: JayColors.primary,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              margin: const EdgeInsets.all(4),
                              child: const Text("Aktivní",
                                  style: TextStyle(color: Colors.white)),
                            )
                        ],
                      ),
                      onTap: () async {
                        Navigator.of(context, rootNavigator: true).pop();
                        final bloc = context.read<AlarmHistoryBloc>();
                        showModalBottomSheet(
                            enableDrag: true,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                            padding: EdgeInsets.all(12),
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              size: 32,
                                            )),
                                        Row(mainAxisSize: MainAxisSize.min,mainAxisAlignment:MainAxisAlignment.center,children: [
                                          Text(state.events[index].name,style: TextStyle(fontSize: 20),)
                                        ]),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 8),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.90,
                                      child: EventPageHistory(
                                          eventId: state.events[index].eventId,
                                          title: state.events[index].name,
                                          memberId: memberId,
                                          isActive: DateTime.now()
                                                      .millisecondsSinceEpoch -
                                                  state.events[index].date
                                                      .millisecondsSinceEpoch <=
                                              600000),
                                    ),
                                  ],
                                ),
                              );
                            });
                        /*
                        Object? result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (final context) => EventPageHistory(
                                eventId: state.events[index].eventId,
                                title: state.events[index].name,
                                memberId: memberId,
                                isActive:
                                    DateTime.now().millisecondsSinceEpoch -
                                            state.events[index].date
                                                .millisecondsSinceEpoch <=
                                        600000),
                          ),
                        );


                        bloc.add(AlarmHistoryStarted());
                            */
                      },
                    ),
                    separatorBuilder:
                        (final BuildContext context, final int index) =>
                            const Divider(),
                  ),
                );
              }
            }
            if (state is AlarmHistoryLoadSuccess && state.events.isEmpty) {
              return Center(
                child: Text(AppLocalizations.of(context)!.eventEmpty),
              );
            }
            if (state is AlarmHistoryLoadInProgress) {
              return const Center(
                  child:
                      JayProgressIndicator(text: "Stahuji historii událostí"));
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
      );
}
