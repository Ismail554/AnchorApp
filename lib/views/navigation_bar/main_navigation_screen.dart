import 'package:flutter/material.dart';
import 'package:wynante/views/navigation_bar/custom_bottom_nav_bar.dart';

/// Main Navigation Screen with Bottom Navigation Bar
/// Manages navigation between Home, Matches, Message, Community, and Profile screens
class MainNavigationScreen extends StatefulWidget {
  final int? initialIndex;

  const MainNavigationScreen({
    super.key,
    this.initialIndex,
  });

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

  // List of screens - Add your screen widgets here as they're implemented
  final List<Widget> _screens = [
    // TODO: Implement these screens
    // const HomeScreen(),
    // const MatchesScreen(),
    // const MessageScreen(),
    // const CommunityScreen(),
    // const ProfileScreen(),
    
    // Placeholder screens for now
    const _PlaceholderScreen(title: 'Home'),
    const _PlaceholderScreen(title: 'Matches'),
    const _PlaceholderScreen(title: 'Message'),
    const _PlaceholderScreen(title: 'Community'),
    const _PlaceholderScreen(title: 'Profile'),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
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
          Icon(
            Icons.construction,
            size: 64,
            color: Colors.grey,
          ),
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
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
