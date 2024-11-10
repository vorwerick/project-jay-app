import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isActive;
  final int orderTime;

  const CustomTabBar(
      {super.key, required this.isActive, required this.orderTime});

  @override
  Widget build(final BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Container(

            height: 32,
            padding: EdgeInsets.symmetric(horizontal: 4),
            color: JayColors.primaryLight ,
            child: Card(
              elevation: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_fire_department_rounded,color:isActive? JayColors.primary: JayColors.darGrey,size: 20,),
                  SizedBox(width: 4,),
                  Text(isActive
                      ? "Aktivní poplach  ${(DateFormat("mm:ss").format(DateTime(0).add(Duration(milliseconds: DateTime.now().millisecondsSinceEpoch - orderTime))))}"
                      : "Poplach byl vyhlášen v ${(DateFormat("HH:mm").format(DateTime.fromMillisecondsSinceEpoch(orderTime)))}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),textAlign: TextAlign.center,),
                ],
              ),
            ),
          ) ,
          TabBar(indicatorColor: Colors.black,unselectedLabelColor: Colors.black38,labelColor: Colors.black,tabs: [
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
  Size get preferredSize => Size.fromHeight(48);
}
