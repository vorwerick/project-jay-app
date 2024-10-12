import 'package:app/application/bloc/alarms/active_alarm_bloc.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/components/fab/jay_fab.dart';
import 'package:app/presentation/components/jay_bottom_navigation_bar.dart';
import 'package:app/presentation/pages/screens/event_details_screen.dart';
import 'package:app/presentation/pages/screens/map_screen.dart';
import 'package:app/presentation/pages/screens/participants_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventPage extends StatefulWidget {
  final int memberId;
  final int eventId;
  final AlarmDto alarmDto;

  const EventPage(
      {super.key,
      required this.memberId,
      required this.eventId,
      required this.alarmDto});

  @override
  State<StatefulWidget> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
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
  Widget build(final BuildContext context) => DefaultTabController(
        length: 3,
        key: const Key('home-tab-bar'),
        child: Scaffold(
          body: TabBarView(
            children: _getScreens(widget.alarmDto),
            physics: const NeverScrollableScrollPhysics(),
          ),
          appBar: const TabBar(tabs: [
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
            )
          ]),
          floatingActionButton: JayFab(
            memberId: widget.memberId,
            eventId: widget.eventId,
          ),
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
