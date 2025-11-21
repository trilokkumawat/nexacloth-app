import 'package:flutter/material.dart';
import 'package:nexacloth/components/safe_set_state_mixin.dart';
import 'package:nexacloth/screens/home_screen.dart';
import 'package:nexacloth/screens/search/searchscreen.dart';
import 'package:nexacloth/screens/settings_screen.dart';
import 'package:nexacloth/screens/cart/cartitem.dart';

class AppState extends StatefulWidget {
  const AppState({super.key});

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> with SafeSetStateMixin {
  int _selectedIndex = 0;

  // List of all screens - IndexedStack will keep them all alive
  final List<Widget> _screens = [
    const HomeScreen(),
    const Searchscreen(),
    const CardItemScreen(isHeaderVisible: false),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    safeSetState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
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
