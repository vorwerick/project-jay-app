import 'dart:developer';

import 'package:app/application/cubit/pooling/pooling_cubit.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/components/custom_tab_bar.dart';
import 'package:app/presentation/components/fab/jay_fab.dart';
import 'package:app/presentation/pages/screens/event_details_screen.dart';
import 'package:app/presentation/pages/screens/map_screen.dart';
import 'package:app/presentation/pages/screens/participants_screen.dart';
import 'package:app/presentation/pages/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventPage extends StatefulWidget {
  final int memberId;
  final int eventId;
  final AlarmDto alarmDto;
  final int activeAlarmDuration;
  final String mapSettings;

  const EventPage({
    super.key,
    required this.memberId,
    required this.eventId,
    required this.alarmDto,
    required this.activeAlarmDuration,
    required this.mapSettings,
  });

  @override
  State<StatefulWidget> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  void initState() {
    log("EVENT_ID: " + widget.eventId.toString());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => DefaultTabController(
        length: 3,
        key: const Key('home-tab-bar'),
        child: BlocProvider(
          create: (final context) =>
              PoolingCubit()..start(const Duration(seconds: 1)),
          child: BlocListener<PoolingCubit, PoolingState>(
            listener: (BuildContext context, PoolingState state) {
              if (state is PoolingFetched) {
                if (_isEarlierThan(
                  widget.alarmDto.orderSentTimestamp,
                  60 * widget.activeAlarmDuration,
                )) {
                  setState(() {});
                }
              }
            },
            child: Scaffold(
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: _getScreens(widget.alarmDto),
              ),
              appBar: CustomAppBar(
                isActive: _isEarlierThan(
                  widget.alarmDto.orderSentTimestamp,
                  60 * widget.activeAlarmDuration,
                ),
                eventDetail: widget.alarmDto,
                tabBar: CustomTabBar(
                  isActive: _isEarlierThan(
                    widget.alarmDto.orderSentTimestamp,
                    60 * widget.activeAlarmDuration,
                  ),
                  orderTime: widget.alarmDto.orderSentTimestamp,
                ),
              ),
              floatingActionButton: _isEarlierThan(
                widget.alarmDto.orderSentTimestamp,
                60 * widget.activeAlarmDuration,
              )
                  ? JayFab(
                      memberId: widget.memberId,
                      eventId: widget.eventId,
                    )
                  : null,
            ),
          ),
        ),
      );

  bool _isEarlierThan(final int orderSentTimestamp, final int seconds) =>
      orderSentTimestamp >=
      DateTime.now().millisecondsSinceEpoch - (seconds * 1000);

  List<Widget> _getScreens(
    final AlarmDto detail,
  ) =>
      [
        EventDetailsScreen(alarmDto: detail),
        ParticipantsScreen(
          detail: detail,
          isHistory: false,
        ),
        MapScreen(
          detail: detail,
          mapSettings: widget.mapSettings,
        ),
      ];
}
