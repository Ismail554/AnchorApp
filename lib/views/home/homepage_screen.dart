import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/views/home/widgets/check_ins_card.dart';
import 'package:wynante/views/home/widgets/connection_snapshot_card.dart';
import 'package:wynante/views/home/widgets/connections_list.dart';
import 'package:wynante/views/home/widgets/discover_grid.dart';
import 'package:wynante/views/home/widgets/home_app_bar.dart';
import 'package:wynante/views/home/widgets/profile_header_card.dart';
import 'package:wynante/views/home/widgets/upcoming_pods_card.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor, // Greyish background
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            const ProfileHeaderCard(),
            SizedBox(height: 16.h),
            const ConnectionSnapshotCard(),
            SizedBox(height: 16.h),
            const ConnectionsList(),
            SizedBox(height: 16.h),
            const UpcomingPodsCard(),
            SizedBox(height: 16.h),
            const CheckInsCard(),
            SizedBox(height: 16.h),
            const DiscoverGrid(),
            SizedBox(height: 24.h), // Bottom padding
          ],
        ),
      ),
    );
  }
}
