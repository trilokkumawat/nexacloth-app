import 'package:flutter/material.dart';
import 'package:nexacloth/components/apptextstyle.dart';
import 'package:nexacloth/components/safe_set_state_mixin.dart';
import 'package:nexacloth/screens/home_screen.dart';
import 'package:nexacloth/screens/settings_screen.dart';
import 'package:nexacloth/screens/cart/cartitem.dart';

class AppState extends StatefulWidget {
  const AppState({super.key});

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> with SafeSetStateMixin {
  int _selectedIndex = 0;

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const HomeScreen();
      case 2:
        return const CardItemScreen(isHeaderVisible: false);

      case 3:
        return const SettingsScreen();
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.home, size: 100, color: Colors.deepPurple),
              const SizedBox(height: 20),
              Text('Welcome Home!', style: AppTextStyle.h3),
            ],
          ),
        );
    }
  }

  void _onItemTapped(int index) {
    safeSetState(() {
      _selectedIndex = index;
    });
    // Only content changes, no actual routing happens
    // If you want navigation, put route change logic here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
