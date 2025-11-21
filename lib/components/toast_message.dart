import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';

/// Toast message types
enum ToastType { success, error, warning, info }

/// A utility class for showing toast messages throughout the app
class ToastMessage {
  /// Shows a toast message with the specified type and message
  ///
  /// [context] - The BuildContext to show the toast
  /// [message] - The message to display
  /// [type] - The type of toast (success, error, warning, info)
  /// [duration] - How long the toast should be displayed (default: 3 seconds)
  static void show(
    BuildContext context,
    String message, {
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 2),
  }) {
    if (!context.mounted) return;

    final backgroundColor = _getBackgroundColor(type);
    final icon = _getIcon(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                message,
                style: AppTextStyle.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Shows a success toast message
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(context, message, type: ToastType.success, duration: duration);
  }

  /// Shows an error toast message
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(context, message, type: ToastType.error, duration: duration);
  }

  /// Shows a warning toast message
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(context, message, type: ToastType.warning, duration: duration);
  }

  /// Shows an info toast message
  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(context, message, type: ToastType.info, duration: duration);
  }

  /// Gets the background color based on toast type
  static Color _getBackgroundColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return CustomAppColor.success;
      case ToastType.error:
        return CustomAppColor.error;
      case ToastType.warning:
        return CustomAppColor.warning;
      case ToastType.info:
        return CustomAppColor.primary;
    }
  }

  /// Gets the icon based on toast type
  static IconData? _getIcon(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle_outline;
      case ToastType.error:
        return Icons.error_outline;
      case ToastType.warning:
        return Icons.warning_amber_outlined;
      case ToastType.info:
        return Icons.info_outline;
    }
  }
}
