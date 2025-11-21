import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexacloth/core/route/routename.dart';
import 'package:nexacloth/components/apptextstyle.dart';
import 'package:nexacloth/core/supabase/supabase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() async {
    // Wait for splash screen to show for at least 1 second
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // Check authentication state
    final isAuthenticated = SupabaseAuth.isAuthenticated;

    if (mounted) {
      if (isAuthenticated) {
        // User is logged in, navigate to home
        context.go(RouteNames.home);
      } else {
        // User is not logged in, navigate to login
        context.go(RouteNames.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),
            Text('NexaCloth', style: AppTextStyle.h1),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
