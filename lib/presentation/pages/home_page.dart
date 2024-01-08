import 'package:app/presentation/components/jay_bottom_navigation_bar.dart';
import 'package:app/presentation/components/jay_bottom_navigation_bar_landscape.dart';
import 'package:app/presentation/components/jay_drawer.dart';
import 'package:app/presentation/pages/screens/event_details_screen.dart';
import 'package:app/presentation/pages/screens/event_participants_screen.dart';
import 'package:app/presentation/pages/screens/map_screen.dart';
import 'package:app/presentation/pages/screens/participants_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(final BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        appBar: AppBar(),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _getScreens(orientation),
        ),
        bottomNavigationBar: _getBottomNavigationBar(orientation),
        drawer: const JayDrawer(),
      );
    });
  }

  void _onPageTap(final int index) {
    // Place where we can add transition animations
    setState(() {
      _currentPageIndex = index;
      _pageController.jumpToPage(
        index,
      );
    });
  }

  Widget _getBottomNavigationBar(final Orientation orientation) {
    return orientation == Orientation.portrait
        ? JayBottomNavigationBar(
            currentPageIndex: _currentPageIndex,
            onTap: _onPageTap,
          )
        : JayBottomNavigationBarLandscape(
            currentPageIndex: _currentPageIndex > 1 ? 1 : _currentPageIndex,
            onTap: _onPageTap,
          );
  }

  List<Widget> _getScreens(final Orientation orientation) {
    return orientation == Orientation.portrait
        ? [
            EventDetailsScreen(),
            ParticipantsScreen(),
            const MapScreen(),
          ]
        : [
            const EventParticipantScreen(),
            const MapScreen(),
          ];
  }
}
