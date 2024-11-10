import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/components/custom_tab_bar.dart';
import 'package:app/presentation/pages/widgets/app_bar_alarm.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AlarmDto eventDetail;
  final CustomTabBar tabBar;
  final bool isActive;

  const CustomAppBar({
    super.key,
    required this.eventDetail,
    required this.tabBar, required this.isActive,
  });

  @override
  Widget build(final BuildContext context) => AppBarAlarm(
        eventDetail: eventDetail,
    tabBar: tabBar,isActive: isActive
      );

  @override
  Size get preferredSize => Size.fromHeight(132);
}
