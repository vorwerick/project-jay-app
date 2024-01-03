import 'package:flutter/material.dart';

class JayBottomNavigationBar extends StatelessWidget {
  final int currentPageIndex;
  final void Function(int index)? onTap;

  const JayBottomNavigationBar({super.key, this.onTap, this.currentPageIndex = 0});

  @override
  Widget build(final BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      currentIndex: currentPageIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Event',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Participants',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
      ],
    );
  }
}
