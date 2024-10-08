import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrganisateurBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const OrganisateurBottomNavigation({
    super.key,
    required this.navigationShell,
  });

  void _goBranch(int index) {
    final bool isInitialLocation = index == navigationShell.currentIndex;
    navigationShell.goBranch(index, initialLocation: isInitialLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationShell.currentIndex,
        onTap: _goBranch,
        items: _buildBottomNavigationBarItems(),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Accueil',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];
  }
}
