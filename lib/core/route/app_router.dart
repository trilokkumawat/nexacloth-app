import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexacloth/core/route/routename.dart';
import 'package:nexacloth/core/supabase/supabase_auth.dart';
import 'package:nexacloth/screens/appState.dart';
import 'package:nexacloth/screens/login_screen.dart';
import 'package:nexacloth/screens/profile_screen.dart';
import 'package:nexacloth/screens/settings_screen.dart';
import 'package:nexacloth/screens/splash_screen.dart';

class AppRouter {
  // Refresh notifier to trigger router refresh on auth state changes
  static final _refreshNotifier = ValueNotifier<bool>(false);

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    refreshListenable: _refreshNotifier,
    redirect: (context, state) {
      final isAuthenticated = SupabaseAuth.isAuthenticated;
      final isLoginPage = state.matchedLocation == RouteNames.login;
      final isSplashPage = state.matchedLocation == RouteNames.splash;

      // If on splash screen, let it handle navigation
      if (isSplashPage) {
        return null;
      }

      // If not authenticated and trying to access protected routes
      if (!isAuthenticated && !isLoginPage) {
        return RouteNames.login;
      }

      // If authenticated and on login page, redirect to home
      if (isAuthenticated && isLoginPage) {
        return RouteNames.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.home,
        name: 'home',
        builder: (context, state) => const AppState(),
      ),
      GoRoute(
        path: RouteNames.profile,
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RouteNames.settings,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Error: ${state.error}'))),
  );

  /// Refresh the router (call this when auth state changes)
  static void refresh() {
    _refreshNotifier.value = !_refreshNotifier.value;
  }
}
