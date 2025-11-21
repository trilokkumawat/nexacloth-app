import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nexacloth/model/user_info_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Global service for accessing user info from user_info table
/// Accessible from anywhere in the app: UserInfoService().name, email, userId
class UserInfoService {
  static final UserInfoService _instance = UserInfoService._internal();
  factory UserInfoService() => _instance;
  UserInfoService._internal();

  UserInfoModel? _userInfo;
  StreamSubscription<List<Map<String, dynamic>>>? _subscription;
  bool _isInitialized = false;

  /// Get current user info
  UserInfoModel? get userInfo => _userInfo;

  /// Get user name (globally accessible)
  String? get name => _userInfo?.name;

  /// Get user email (globally accessible)
  String? get email => _userInfo?.email;

  /// Get user id (globally accessible)
  String? get userId => _userInfo?.id;

  /// Check if user info is loaded
  bool get isLoaded => _userInfo != null;

  /// Initialize and fetch user info
  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      _userInfo = null;
      return;
    }
    print('userId: $userId');
    await fetchUserInfo();
    await subscribeToRealtime();

    // Listen to auth state changes
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        fetchUserInfo();
        subscribeToRealtime();
      } else if (event == AuthChangeEvent.signedOut) {
        _userInfo = null;
        _subscription?.cancel();
      } else if (event == AuthChangeEvent.userUpdated) {
        fetchUserInfo();
      }
    });
  }

  /// Fetch user info from Supabase based on current user id
  Future<void> fetchUserInfo() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        _userInfo = null;
        return;
      }

      final response = await Supabase.instance.client
          .from('user_info')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response != null) {
        _userInfo = UserInfoModel.fromMap(response);
        debugPrint(
          'User info fetched: ${_userInfo?.name}, ${_userInfo?.email}',
        );
      } else {
        _userInfo = null;
        debugPrint('No user info found for user: $userId');
      }
    } catch (e) {
      debugPrint('Error fetching user info: $e');
      _userInfo = null;
    }
  }

  /// Subscribe to realtime updates for user info
  Future<void> subscribeToRealtime() async {
    // Cancel existing subscription if any
    await _subscription?.cancel();

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      return;
    }

    try {
      _subscription = Supabase.instance.client
          .from('user_info')
          .stream(primaryKey: ['id'])
          .eq('id', userId)
          .map((data) => List<Map<String, dynamic>>.from(data))
          .listen(
            (data) {
              if (data.isNotEmpty) {
                _userInfo = UserInfoModel.fromMap(data.first);
                debugPrint(
                  'User info updated via realtime: ${_userInfo?.name}',
                );
              } else {
                _userInfo = null;
              }
            },
            onError: (error) {
              debugPrint('Realtime subscription error: $error');
            },
          );
    } catch (e) {
      debugPrint('Error subscribing to realtime: $e');
    }
  }

  /// Refresh user info manually
  Future<void> refresh() async {
    await fetchUserInfo();
  }

  /// Dispose resources
  void dispose() {
    _subscription?.cancel();
    _isInitialized = false;
  }
}
