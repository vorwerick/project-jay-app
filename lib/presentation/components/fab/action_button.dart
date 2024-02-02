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
      color: backgroundColor,
      elevation: 4,
      child: IconButton(
        iconSize: 50,
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}
