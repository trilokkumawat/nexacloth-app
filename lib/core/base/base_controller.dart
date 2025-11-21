import 'package:flutter/foundation.dart';

/// Base controller that provides controlled state management
/// without automatically calling notifyListeners on every change
abstract class BaseController extends ChangeNotifier {
  bool _isDisposed = false;
  bool _hasPendingUpdate = false;

  /// Check if controller is disposed
  bool get isDisposed => _isDisposed;

  /// Update state without notifying listeners immediately
  /// Use this for internal state changes that don't need immediate UI updates
  T updateState<T>(T Function() updater) {
    if (_isDisposed) {
      throw StateError('Cannot update state on disposed controller');
    }
    return updater();
  }

  /// Update state and mark for notification (batched updates)
  /// Call notify() separately to actually notify listeners
  T updateStateWithPendingNotification<T>(T Function() updater) {
    if (_isDisposed) {
      throw StateError('Cannot update state on disposed controller');
    }
    _hasPendingUpdate = true;
    return updater();
  }

  /// Manually notify listeners when needed
  /// This gives you control over when UI updates happen
  @override
  void notifyListeners() {
    if (!_isDisposed) {
      _hasPendingUpdate = false;
      super.notifyListeners();
    }
  }

  /// Notify listeners only if there are pending updates
  void notifyIfPending() {
    if (_hasPendingUpdate && !_isDisposed) {
      notifyListeners();
    }
  }

  /// Batch multiple updates and notify once at the end
  /// Usage: batchUpdate(() { ... multiple state changes ... })
  void batchUpdate(void Function() updater) {
    if (_isDisposed) {
      throw StateError('Cannot update state on disposed controller');
    }
    updater();
    notifyListeners();
  }

  /// Safe notify that checks if disposed
  void safeNotify() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _hasPendingUpdate = false;
    super.dispose();
  }
}

