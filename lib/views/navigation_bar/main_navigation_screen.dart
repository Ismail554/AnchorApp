import 'package:flutter/material.dart';
import 'package:wynante/views/community/community_main_screen.dart';
import 'package:wynante/views/home/homepage_screen.dart';
import 'package:wynante/views/matches/match_home_screen.dart';
import 'package:wynante/views/navigation_bar/custom_bottom_nav_bar.dart';

/// Main Navigation Screen with Bottom Navigation Bar
/// Manages navigation between Home, Matches, Message, Community, and Profile screens
class MainNavigationScreen extends StatefulWidget {
  final int? initialIndex;

  const MainNavigationScreen({super.key, this.initialIndex});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
  }

  DateTime? currentBackPressTime;
  final GlobalKey<NavigatorState> matchNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            // Home
            const HomepageScreen(),
            // Matches
            MatchHomeScreen(navigatorKey: matchNavigatorKey),
            // Message
            const _PlaceholderScreen(title: 'Message'),
            // Community
            const CommunityMainScreen(),
            // Profile
            const _PlaceholderScreen(title: 'Profile'),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    // If on Matches tab (index 1), try to pop nested navigator first
    if (_currentIndex == 1) {
      final isPopped = await matchNavigatorKey.currentState?.maybePop();
      if (isPopped == true) {
        return false; // Handled by nested navigator
      }
    }

    // Double back to exit logic
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true; // Exit app
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

/// Placeholder screen widget for unimplemented screens
class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            '$title Screen',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Coming soon...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
