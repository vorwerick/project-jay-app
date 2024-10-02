import 'package:app/application/bloc/alarms/alarm_detail_bloc.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/components/jay_bottom_navigation_bar.dart';
import 'package:app/presentation/components/jay_bottom_navigation_bar_landscape.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/screens/event_details_screen.dart';
import 'package:app/presentation/pages/screens/event_participants_screen.dart';
import 'package:app/presentation/pages/screens/map_screen.dart';
import 'package:app/presentation/pages/screens/participants_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDetailPage extends StatefulWidget {
  final int eventId;

  const EventDetailPage({super.key, required this.eventId});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  
  @override
  Widget build(final BuildContext context) => OrientationBuilder(
    builder: (final context, final orientation)=> BlocProvider(
        create: (final context) => AlarmDetailBloc()..add(AlarmDetailIdPressed(widget.eventId)),
        child: Scaffold(
          appBar: AppBar(title: JayWhiteText(AppLocalizations.of(context)!.eventDetail)),
          body: SizedBox.expand(
            child: BlocBuilder<AlarmDetailBloc, AlarmDetailState>(
              builder: (final context, final state) {
                if (state is AlarmDetailLoadSuccess) {
                  return PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _getScreens(orientation, state.alarm),
                  );
                }
                return const JayProgressIndicator();
              },
            ),
          ),
          bottomNavigationBar: _getBottomNavigationBar(orientation),
        ),
      )
  );

  List<Widget> _getScreens(
      final Orientation orientation, final AlarmDto detail) =>
      orientation == Orientation.portrait
          ? [
        EventDetailsScreen(detail: detail),
        ParticipantsScreen(detail: detail, isHistory: true,),
         MapScreen(detail: detail),
      ]
          : [
        EventParticipantScreen(detail: detail, isHistory: true,),
        MapScreen(detail: detail),
      ];

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

  void _onPageTap(final int index) {
    // Place where we can add transition animations
    setState(() {
      _currentPageIndex = index;
      _pageController.jumpToPage(
        index,
      );
    });
  }
}
