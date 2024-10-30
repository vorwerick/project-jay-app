import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';

class JayBottomNavigationBar extends StatelessWidget {
  final int currentPageIndex;
  final void Function(int index)? onTap;
  final List<AlarmDto> alarms;

  const JayBottomNavigationBar({
    super.key,
    this.onTap,
    this.currentPageIndex = 0,
    required this.alarms,
  });

  @override
  Widget build(final BuildContext context) => alarms.length == 1
      ? SizedBox.shrink()
      : BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentPageIndex,
          selectedFontSize: 15,
          onTap: onTap,
          items: [
            ...alarms
                .map((a) {
                  final index = alarms.indexOf(a);

                  return BottomNavigationBarItem(
                    label: '${a.event}\njednotka ${a.unit}',
                    icon: Icon(Icons.notifications_sharp),
                  );
                })
                .toList()
          ],
        );
}
