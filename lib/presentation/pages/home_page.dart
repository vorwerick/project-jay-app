import 'package:app/application/bloc/alarms/alarm_detail_bloc.dart';
import 'package:app/presentation/components/jay_bottom_navigation_bar.dart';
import 'package:app/presentation/components/jay_bottom_navigation_bar_landscape.dart';
import 'package:app/presentation/components/jay_drawer.dart';
import 'package:app/presentation/components/jay_fab.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/pages/screens/event_details_screen.dart';
import 'package:app/presentation/pages/screens/event_participants_screen.dart';
import 'package:app/presentation/pages/screens/map_screen.dart';
import 'package:app/presentation/pages/screens/participants_screen.dart';
import 'package:app/presentation/pages/widgets/app_bar_alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(final BuildContext context) => OrientationBuilder(
        builder: (final context, final orientation) => BlocProvider(
          create: (final context) => AlarmDetailBloc()..add(AlarmDetailActiveRequested()),
          child: Scaffold(
            appBar: AppBar(
              title: BlocBuilder<AlarmDetailBloc, AlarmDetailState>(
                builder: (final context, final state) {
                  if (state is AlarmDetailLoadSuccess) {
                    return AppBarAlarm(eventDetail: state);
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            body: BlocBuilder<AlarmDetailBloc, AlarmDetailState>(
              builder: (final context, final state) {
                if (state is AlarmDetailLoadSuccess) {
                  return PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _getScreens(orientation, state),
                  );
                }
                return const JayProgressIndicator();
              },
            ),
            bottomNavigationBar: BlocBuilder<AlarmDetailBloc, AlarmDetailState>(
              builder: (final context, final state) {
                if (state is AlarmDetailLoadSuccess) {
                  return _getBottomNavigationBar(orientation);
                }
                return const SizedBox.shrink();
              },
            ),
            drawer: const JayDrawer(),
            floatingActionButton: const JayFab(),
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

  Widget _getBottomNavigationBar(final Orientation orientation) => orientation == Orientation.portrait
      ? JayBottomNavigationBar(
          currentPageIndex: _currentPageIndex,
          onTap: _onPageTap,
        )
      : JayBottomNavigationBarLandscape(
          currentPageIndex: _currentPageIndex > 1 ? 1 : _currentPageIndex,
          onTap: _onPageTap,
        );

  List<Widget> _getScreens(final Orientation orientation, final AlarmDetailLoadSuccess detail) =>
      orientation == Orientation.portrait
          ? [
              EventDetailsScreen(detail: detail),
              ParticipantsScreen(),
              const MapScreen(),
            ]
          : [
              EventParticipantScreen(detail: detail),
              const MapScreen(),
            ];
}
