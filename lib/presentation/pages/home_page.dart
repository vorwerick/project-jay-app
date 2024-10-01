import 'package:app/application/bloc/alarms/active_alarm_bloc.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/infrastructure/services/text_to_speech_service.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/fab/jay_fab.dart';
import 'package:app/presentation/components/jay_bottom_navigation_bar.dart';
import 'package:app/presentation/components/jay_bottom_navigation_bar_landscape.dart';
import 'package:app/presentation/components/jay_drawer.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/screens/event_details_screen.dart';
import 'package:app/presentation/pages/screens/event_participants_screen.dart';
import 'package:app/presentation/pages/screens/map_screen.dart';
import 'package:app/presentation/pages/screens/participants_screen.dart';
import 'package:app/presentation/pages/widgets/app_bar_alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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
  Widget build(final BuildContext context) => OrientationBuilder(
        builder: (final context, final orientation) => BlocProvider(
          create: (final context) => ActiveAlarmBloc()
            ..add(
              ActiveAlarmStarted(
                enableLiveUpdate: true,
              ),
            ),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 124,
              backgroundColor: JayColors.primary,
              actions: [
                FadeTransition(
                  opacity: _animationController,
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.warning,
                      color: JayColors.secondary,
                      size: 42,
                    ),
                  ),
                )
              ],
              title: BlocBuilder<ActiveAlarmBloc, ActiveAlarmState>(
                builder: (final context, final state) {
                  if (state is ActiveAlarmLoadSuccess) {
                    return AppBarAlarm(eventDetail: state.alarm);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            body: BlocBuilder<ActiveAlarmBloc, ActiveAlarmState>(
              builder: (final context, final state) {
                if (state is ActiveAlarmLoadSuccess) {

                  return PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _getScreens(orientation, state.alarm),
                  );
                }
                if (state is ActiveAlarmLoadInProgress) {
                  return const JayProgressIndicator();
                }
                if (state is ActiveAlarmFailure) {
                  return Center(
                    child: JayWhiteText(
                      AppLocalizations.of(context)!.checkConnection,
                      fontSize: 24,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            bottomNavigationBar: BlocBuilder<ActiveAlarmBloc, ActiveAlarmState>(
              builder: (final context, final state) {
                if (state is ActiveAlarmLoadSuccess) {
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

  Widget _getBottomNavigationBar(final Orientation orientation) =>
      orientation == Orientation.portrait
          ? JayBottomNavigationBar(
              currentPageIndex: _currentPageIndex,
              onTap: _onPageTap,
            )
          : JayBottomNavigationBarLandscape(
              currentPageIndex: _currentPageIndex > 1 ? 1 : _currentPageIndex,
              onTap: _onPageTap,
            );

  List<Widget> _getScreens(
          final Orientation orientation, final AlarmDto detail) =>
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
