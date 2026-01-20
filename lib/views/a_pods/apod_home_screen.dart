import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/a_pods/received_view.dart';
import 'package:wynante/views/a_pods/schedule_a_pod.dart';
import 'package:wynante/views/a_pods/sent_view.dart';
import 'package:wynante/views/a_pods/scheduled_view.dart';
import 'package:wynante/views/a_pods/connections_view.dart';

class ApodHomeScreen extends StatefulWidget {
  const ApodHomeScreen({super.key});

  @override
  State<ApodHomeScreen> createState() => _ApodHomeScreenState();
}

class _ApodHomeScreenState extends State<ApodHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("A-Pods", style: FontManager.heading2()),
                    AppSpacing.h4,
                    Text(
                      "Manage your meetings",
                      style: FontManager.bodyMedium(color: Colors.grey),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScheduleAPodScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 18, color: Colors.white),
                  label: Text(
                    "Schedule",
                    style: FontManager.bodyMedium(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.h16,
          Container(
            height: 40.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              indicatorWeight: 2,
              labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
              tabs: [
                _buildTab(text: "Received", count: 3),
                _buildTab(text: "Sent", count: 2),
                _buildTab(text: "Scheduled", count: 4),
                // Connection tab without count based on the image, or assuming 0/hidden
                const Tab(text: "Connections"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ReceivedView(),
                SentView(),
                ScheduledView(),
                ConnectionsView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({required String text, int? count}) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          if (count != null && count > 0) ...[
            AppSpacing.w8,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
