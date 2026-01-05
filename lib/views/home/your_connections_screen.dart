import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/custom_widget/mini_widget/widget_textfield.dart';

class YourConnectionsScreen extends StatefulWidget {
  const YourConnectionsScreen({super.key});

  @override
  State<YourConnectionsScreen> createState() => _YourConnectionsScreenState();
}

class _YourConnectionsScreenState extends State<YourConnectionsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Mock Data
  final List<Map<String, dynamic>> _allConnections = [
    {
      "name": "Sarat",
      "initials": "SJ",
      "statusColor": Colors.green,
      "status": "Online",
    },
    {
      "name": "Mike",
      "initials": "MC",
      "statusColor": Colors.green,
      "status": "Online",
    },
    {
      "name": "Emma",
      "initials": "ED",
      "statusColor": Colors.orange,
      "status": "Away",
    },
    {
      "name": "James",
      "initials": "JW",
      "statusColor": Colors.grey,
      "status": "Offline",
    },
    {
      "name": "Lily",
      "initials": "LI",
      "statusColor": Colors.red,
      "status": "Busy",
    },
    {
      "name": "David",
      "initials": "DB",
      "statusColor": Colors.green,
      "status": "Online",
    },
    {
      "name": "Sarah",
      "initials": "SW",
      "statusColor": Colors.grey,
      "status": "Offline",
    },
    {
      "name": "John",
      "initials": "JD",
      "statusColor": Colors.green,
      "status": "Online",
    },
  ];

  List<Map<String, dynamic>> _filteredConnections = [];

  @override
  void initState() {
    super.initState();
    _filteredConnections = _allConnections;
    _searchController.addListener(_filterConnections);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterConnections() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredConnections = _allConnections;
      } else {
        _filteredConnections = _allConnections.where((conn) {
          final name = conn["name"].toString().toLowerCase();
          return name.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.sp,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Your Connections",
          style: FontManager.heading3(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: AppPadding.h24,
            child: WidgetTextfield(
              hintText: "Search connections...",
              controller: _searchController,
              prefixIcon: Icons.search,
              elevation: 2,
            ),
          ),
          AppSpacing.h16,
          Expanded(
            child: ListView.separated(
              padding: AppPadding.h24,
              itemCount: _filteredConnections.length,
              separatorBuilder: (context, index) =>
                  Divider(color: AppColors.grey.withOpacity(0.1), height: 1),
              itemBuilder: (context, index) {
                final item = _filteredConnections[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    children: [
                      // Avatar
                      Stack(
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryLight.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                item["initials"],
                                style: FontManager.heading3(
                                  fontSize: 16,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 14.w,
                              height: 14.w,
                              decoration: BoxDecoration(
                                color: item["statusColor"],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.w16,
                      // Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["name"],
                              style: FontManager.heading4(fontSize: 16),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              item["status"],
                              style: FontManager.bodySmall(
                                color: AppColors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Action Button
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: AppColors.primaryColor,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
