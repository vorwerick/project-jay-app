import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';

class JayFloatingActionButton extends StatelessWidget {
  final IconData iconData;
  final void Function() onPressed;
  final String hero;

  const JayFloatingActionButton(
      {super.key,
      required this.onPressed,
      required this.iconData,
      required this.hero});

  @override
  Widget build(final BuildContext context) => FloatingActionButton(
        onPressed: onPressed,
        heroTag: hero,
        shape: const CircleBorder(),
        backgroundColor: JayColors.primary,
        child: Icon(
          iconData,
          color: JayColors.secondary,
        ),
      );
}
