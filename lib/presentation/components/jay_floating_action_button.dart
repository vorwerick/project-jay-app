import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';

class JayFloatingActionButton extends StatelessWidget {
  final IconData iconData;
  final void Function() onPressed;

  const JayFloatingActionButton({super.key, required this.onPressed, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      backgroundColor: JayColors.primary,
      child: Icon(iconData, color: JayColors.secondary,),
    );
  }
}
