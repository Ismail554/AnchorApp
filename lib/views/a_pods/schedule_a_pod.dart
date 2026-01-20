import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/custom_widget/home_widget/widget_conn_tile.dart';
import 'package:wynante/models/your_connection_model.dart';
import 'package:wynante/core/assets_manager.dart';

class ScheduleAPodScreen extends StatefulWidget {
  const ScheduleAPodScreen({super.key});

  @override
  State<ScheduleAPodScreen> createState() => _ScheduleAPodScreenState();
}

class _ScheduleAPodScreenState extends State<ScheduleAPodScreen> {
  // Mock data to match the design image
  final List<YourConnectionModel> _connections = [
    YourConnectionModel(
      name: "Miles Esther",
      pic: ImageAssets.men2, // Assuming this asset exists or using placeholder
      date: "Since 12 Jan 2025",
      status: "online",
      connectionType: "low",
      activity: "Social",
      interests: ["Social"],
    ),
    YourConnectionModel(
      name: "Miles Esther",
      pic: ImageAssets.men2,
      date: "Since 12 Jan 2025",
      status: "online",
      connectionType: "high",
      activity: "Romantic",
      interests: ["Romantic"],
    ),
    YourConnectionModel(
      name: "Miles Esther",
      pic: ImageAssets.men3,
      date: "Since 12 Jan 2025",
      status: "online",
      connectionType: "medium",
      activity: "Romantic",
      interests: ["Romantic"],
    ),
    YourConnectionModel(
      name: "Miles Esther",
      pic: ImageAssets.men1, // Assuming men1 exists
      date: "Since 12 Jan 2025",
      status: "online",
      connectionType: "high",
      activity: "Professional",
      interests: ["Professional"],
    ),
    YourConnectionModel(
      name: "Miles Esther",
      pic: ImageAssets.men2, // Assuming men4 exists or reuse
      date: "Since 12 Jan 2025",
      status: "online",
      connectionType: "low",
      activity: "Professional",
      interests: ["Professional"],
    ),
    YourConnectionModel(
      name: "Miles Esther",
      pic: ImageAssets.men1,
      date: "Since 12 Jan 2025",
      status: "online",
      connectionType: "medium",
      activity: "Romantic",
      interests: ["Romantic"],
    ),
    YourConnectionModel(
      name: "Miles Esther",
      pic: ImageAssets.men2,
      date: "Since 12 Jan 2025",
      status: "online",
      connectionType: "low",
      activity: "Romantic",
      interests: ["Romantic"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text("Schedule A Pods", style: FontManager.heading3()),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey, size: 24.sp),
                  AppSpacing.w12,
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search name",
                        hintStyle: FontManager.bodyMedium(color: Colors.grey),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.tune,
                    color: Colors.grey,
                    size: 24.sp,
                  ), // Filter icon
                ],
              ),
            ),
          ),
          AppSpacing.h16,
          // List Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "List of Connections (50)",
                style: FontManager.bodyLarge(fontSize: 16),
              ),
            ),
          ),
          AppSpacing.h16,
          // List
          Expanded(
            child: ListView.separated(
              padding: AppPadding.all16,
              itemCount: _connections.length,
              separatorBuilder: (context, index) => AppSpacing.h16,
              itemBuilder: (context, index) {
                return WidgetConnTile(
                  connection: _connections[index],
                  topRightWidget: _buildInviteButton(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInviteButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D9CFC),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.videocam_outlined, color: Colors.white, size: 16.sp),
          AppSpacing.w4,
          Text(
            "Invite",
            style: FontManager.bodySmall(
              color: Colors.white,
              fontSize: 12,
              // fontWeight: FontWeight.bold,
            ),
          ),
          AppSpacing.w4,
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 10.sp),
        ],
      ),
    );
  }
}
