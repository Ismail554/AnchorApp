import 'package:flutter/material.dart';
import 'package:wynante/custom_widget/home_widget/widget_conn_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';

import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/your_connection_model.dart';

class MySavedScreen extends StatefulWidget {
  const MySavedScreen({super.key});

  @override
  State<MySavedScreen> createState() => _MySavedScreenState();
}

class _MySavedScreenState extends State<MySavedScreen> {
  final List<YourConnectionModel> savedMatches =
      YourConnectionModel.dummyData; // Using dummy data for now

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: Text("Saved Matches", style: FontManager.heading3(fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.r20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "All previous matches",
              style: FontManager.heading4(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
            AppSpacing.h4,
            Text(
              "All Matches found in match finder",
              style: FontManager.bodySmall(color: AppColors.grey),
            ),
            AppSpacing.h20,

            ListView.separated(
              itemCount:
                  savedMatches.length + 3, // Dummy multiply to check scrolling
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => AppSpacing.h12,
              itemBuilder: (context, index) {
                // Repeating dummy data for list effect
                final connection = savedMatches[index % savedMatches.length];
                return WidgetConnTile(
                  connection: connection,
                  topRightWidget: Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 20.sp,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
