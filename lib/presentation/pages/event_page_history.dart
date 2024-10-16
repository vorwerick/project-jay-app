import 'package:app/application/bloc/alarms/alarm_detail_bloc.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/components/fab/jay_fab.dart';
import 'package:app/presentation/components/jay_bottom_navigation_bar.dart';
import 'package:app/presentation/components/jay_bottom_navigation_bar_landscape.dart';
import 'package:app/presentation/components/jay_floating_action_button.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/event_page.dart';
import 'package:app/presentation/pages/screens/event_details_screen.dart';
import 'package:app/presentation/pages/screens/event_participants_screen.dart';
import 'package:app/presentation/pages/screens/map_screen.dart';
import 'package:app/presentation/pages/screens/participants_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventPageHistory extends StatefulWidget {
  final int eventId;
  final int memberId;
  final bool isActive;
  final String title;

  const EventPageHistory(
      {super.key,
      required this.eventId,
      required this.title,
      required this.memberId, required this.isActive});

  @override
  State<EventPageHistory> createState() => _EventPageHistoryState();
}

class _EventPageHistoryState extends State<EventPageHistory>
    with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;
  late AnimationController _animationController;
  final PageController _pageController = PageController();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => AlarmDetailBloc()
          ..add(
            AlarmDetailIdPressed(widget.eventId),
          ),
        child: DefaultTabController(
          length: 3,
          key: const Key('home-tab-bar'),
          child: BlocBuilder<AlarmDetailBloc, AlarmDetailState>(
              builder: (final c, final state) {
                if (state is AlarmDetailLoadSuccess) {
                  return Scaffold(
                    backgroundColor: Colors.white,
                    appBar: const TabBar(
                      tabs: [
                        Tab(
                          text: 'Přehled',
                          icon: Icon(Icons.info),
                        ),
                        Tab(
                          text: 'Účastníci',
                          icon: Icon(Icons.people),
                        ),
                        Tab(
                          text: 'Mapa',
                          icon: Icon(Icons.pin_drop),
                        ),
                      ],
                    ),
                    floatingActionButton: widget.isActive? JayFab(
                      memberId: widget.memberId,
                      eventId: widget.eventId,
                    ) : null,
                    body: TabBarView(
                      children: _getScreens(state.alarm),
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  );
                }

                return JayProgressIndicator(text: "Stahuji detail události");
              }),
        ),
      );

  void _onPageTap(final int index) {
    // Place where we can add transition animations
    setState(() {
      _currentPageIndex = index;
      _pageController.jumpToPage(
        index,
      );
    });
  }

  List<Widget> _getScreens(
    final AlarmDto detail,
  ) =>
      [
        EventDetailsScreen(alarmDto: detail),
        ParticipantsScreen(
          detail: detail,
          isHistory: false,
        ),
        MapScreen(detail: detail),
      ];
}
