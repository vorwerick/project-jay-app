import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JayBottomNavigationBar extends StatelessWidget {
  final int currentPageIndex;
  final void Function(int index)? onTap;

  const JayBottomNavigationBar(
      {super.key, this.onTap, this.currentPageIndex = 0});

  @override
  Widget build(final BuildContext context) => BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.info_outline, color: JayColors.lightGrey),
            activeIcon: const Icon(
              Icons.info_outline,
              color: JayColors.primary,
              size: 32,
            ),
            label: AppLocalizations.of(context)!.event,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people, color: JayColors.lightGrey),
            activeIcon: const Icon(
              Icons.people,
              color: JayColors.primary,
              size: 32,
            ),
            label: AppLocalizations.of(context)!.participants,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.pin_drop,
              color: JayColors.lightGrey,
            ),
            activeIcon: const Icon(
              Icons.pin_drop,
              color: JayColors.primary,
              size: 32,
            ),
            label: AppLocalizations.of(context)!.map,
          ),
        ],
      );
}
