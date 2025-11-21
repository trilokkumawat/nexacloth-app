import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexacloth/core/route/routename.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.auth.signOut();
      context.go(RouteNames.login); // Make sure RouteNames.login exists!
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.home),
              child: const Text('Back to Home'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.profile),
              child: const Text('Go to Profile'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => _logout(context),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
