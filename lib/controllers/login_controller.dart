import 'package:flutter/material.dart';
import 'package:nexacloth/core/supabase/supabase_auth.dart';
import 'package:nexacloth/core/base/base_controller.dart';

class LoginController extends BaseController {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoginMode = true;
  bool _isLoading = false;

  // Getters
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  bool get isLoginMode => _isLoginMode;
  bool get isLoading => _isLoading;

  /// Toggle between login and signup mode
  void toggleMode() {
    updateState(() {
      _isLoginMode = !_isLoginMode;
    });
    safeNotify();
  }

  /// Validate email input
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Validate password input
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Handle email authentication (login or signup)
  Future<void> handleEmailAuth({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _setLoading(true);

    try {
      if (_isLoginMode) {
        await SupabaseAuth.signInWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        onSuccess();
      } else {
        await SupabaseAuth.signUpWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        // Batch update: change mode and notify once
        batchUpdate(() {
          _isLoginMode = true;
        });
        onSuccess();
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Handle Google sign in
  Future<void> handleGoogleSignIn({
    required Function(String) onError,
    VoidCallback? onSuccess,
  }) async {
    _setLoading(true);

    try {
      await SupabaseAuth.signInWithGoogle();
      // Note: OAuth redirects will be handled by the deep link
      // If onSuccess is provided, call it after successful sign in
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      _setLoading(false);
      onError(e.toString());
    }
  }

  /// Handle forgot password
  Future<void> handleForgotPassword({
    required Function(String) onError,
    required VoidCallback onEmailEmpty,
    required VoidCallback onSuccess,
  }) async {
    if (_emailController.text.isEmpty) {
      onEmailEmpty();
      return;
    }

    try {
      await SupabaseAuth.resetPassword(_emailController.text.trim());
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }
  }

  /// Set loading state
  void _setLoading(bool value) {
    updateState(() {
      _isLoading = value;
    });
    safeNotify();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
