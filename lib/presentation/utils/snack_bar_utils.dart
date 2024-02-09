import 'package:app/presentation/components/jay_white_text.dart';
import 'package:flutter/material.dart';

final class SnackBarUtils {
  // Just utility class, so no need to instantiate it
  SnackBarUtils._();

  static void show(final BuildContext context, final String message, final Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: JayWhiteText(message),
        backgroundColor: backgroundColor,
        showCloseIcon: true,
        elevation: 5,
      ),
    );
  }

  static void showWarning(final BuildContext context, final String message) {
    show(context, message, Colors.orange);
  }

  static void showError(final BuildContext context, final String message) {
    show(context, message, Colors.red);
  }

  static void showSuccess(final BuildContext context, final String message) {
    show(context, message, Colors.green);
  }
}
