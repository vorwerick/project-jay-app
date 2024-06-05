import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';

@immutable
class ActionButton extends StatelessWidget {
  final Color backgroundColor;

  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.backgroundColor,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 16,
      color: JayColors.secondary,
      child: IconButton(
        iconSize: 64,
        onPressed: onPressed,
        icon: icon,
        color: JayColors.secondary
      ),
    );
  }
}
