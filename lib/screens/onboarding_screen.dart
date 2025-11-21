import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexacloth/core/route/routename.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              size: 100,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to NexaCloth',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.login),
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}

