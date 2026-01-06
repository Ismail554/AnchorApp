import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/your_connection_model.dart';
import 'package:wynante/views/matches/discover/swipeable_card_stack.dart';

class MatchHomeScreen extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  const MatchHomeScreen({super.key, this.navigatorKey});

  @override
  State<MatchHomeScreen> createState() => _MatchHomeScreenState();
}

class _MatchHomeScreenState extends State<MatchHomeScreen> {
  late final GlobalKey<NavigatorState> navigatorKey;

  @override
  void initState() {
    super.initState();
    navigatorKey = widget.navigatorKey ?? GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => const _MatchHomeContent(),
        );
      },
    );
  }
}

class _MatchHomeContent extends StatefulWidget {
  const _MatchHomeContent();

  @override
  State<_MatchHomeContent> createState() => _MatchHomeContentState();
}

class _MatchHomeContentState extends State<_MatchHomeContent> {
  // Using connection dummy data for candidates for now
  final List<YourConnectionModel> _candidates = YourConnectionModel.dummyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover", style: FontManager.heading3(fontSize: 22)),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune), // Filter icon
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Center(child: SwipeableCardStack(candidates: _candidates)),
      ),
    );
  }
}
