import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:flutter/material.dart';

class ListPairAction extends StatelessWidget {
  final String title;
  final String name;

  final String number;

  final Color background;
  final Icon icon;

  final void Function(String phoneNumber)? onTap;

  const ListPairAction({
    super.key,
    required this.name,
    required this.number,
    this.onTap,
    required this.title,
    required this.background,
    required this.icon
  });

  @override
  Widget build(final BuildContext context) => Container(
    color: background,
    padding: EdgeInsets.all(6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
        ),
        Column(
          children: [
            Text(name ?? '',    style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
            Text(number ?? '',    style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
          ],
        ),
        ElevatedButton(

          onPressed: () => onTap?.call(number),
            style: ElevatedButton.styleFrom(backgroundColor: JayColors.secondary, shape: const CircleBorder()),

            child: icon
        ),
      ],
    ),
  );
}
