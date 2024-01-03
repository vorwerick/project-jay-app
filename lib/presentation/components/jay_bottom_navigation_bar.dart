import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JayBottomNavigationBar extends StatelessWidget {
  final int currentPageIndex;
  final void Function(int index)? onTap;

  const JayBottomNavigationBar({super.key, this.onTap, this.currentPageIndex = 0});

  @override
  Widget build(final BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      currentIndex: currentPageIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.event),
          label: AppLocalizations.of(context)!.event,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.people),
          label: AppLocalizations.of(context)!.participants,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.map),
          label: AppLocalizations.of(context)!.map,
        ),
      ],
    );
  }
}
