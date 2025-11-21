import 'package:flutter/material.dart';

/// A mixin that provides a safe setState method that checks if the widget is mounted
/// before calling setState. This prevents errors when setState is called after
/// the widget has been disposed.
mixin SafeSetStateMixin<T extends StatefulWidget> on State<T> {
  /// Safely calls setState only if the widget is still mounted.
  /// This prevents "setState() called after dispose()" errors.
  ///
  /// Example usage:
  /// ```dart
  /// safeSetState(() {
  ///   _counter++;
  /// });
  /// ```
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}
