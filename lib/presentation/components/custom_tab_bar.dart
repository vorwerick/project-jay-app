import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        //  Container(height: 18, color: JayColors.green),
          TabBar(tabs: [
            Tab(
              icon: Icon(Icons.info),
            ),
            Tab(
              icon: Icon(Icons.people),
            ),
            Tab(
              icon: Icon(Icons.pin_drop),
            )
          ])
        ],
      );

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(48);
}
