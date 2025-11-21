import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexacloth/core/route/routename.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            const Text(
              'User Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.home),
              child: const Text('Back to Home'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.settings),
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

