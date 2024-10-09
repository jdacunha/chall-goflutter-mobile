import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ParentBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ParentBottomNavigation({
    super.key,
    required this.navigationShell,
  });

  void _goBranch(int index) {
    final bool isInitialLocation = index == navigationShell.currentIndex;
    navigationShell.goBranch(index, initialLocation: isInitialLocation);
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _refreshData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return navigationShell;
          }
          return Container();
        },
      ),
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
        icon: Icon(Icons.person),
        label: 'Profil',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.celebration),
        label: 'Kermesses',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.supervisor_account),
        label: 'Children',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.local_activity),
        label: 'Tickets',
      ),
    ];
  }
}
