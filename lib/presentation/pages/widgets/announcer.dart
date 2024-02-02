import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:flutter/material.dart';

class Announcer extends StatelessWidget {
  final String title;
  final String name;

  final String number;

  final void Function(String phoneNumber)? onTap;

  const Announcer({
    super.key,
    required this.name,
    required this.number,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: JayColors.blue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                JayWhiteText(
                  '$title:',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                Column(
                  children: [
                    JayWhiteText(name),
                    JayWhiteText(number),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: JayColors.red, shape: const CircleBorder()),
                  onPressed: () => onTap?.call(number),
                  child: const Icon(
                    Icons.phone,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
