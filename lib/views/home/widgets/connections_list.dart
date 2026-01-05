import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/home/your_connections_screen.dart';

class ConnectionsList extends StatelessWidget {
  const ConnectionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppPadding.p20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Connections",
                style: FontManager.heading3(fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return const YourConnectionsScreen();
                  }));
                },

                child: Text(
                  "View All",
                  style: FontManager.bodySmall(
                    fontSize: 12,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.h16,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Row(
              children: List.generate(5, (index) {
                return Padding(
                  // Add spacing between items
                  padding: EdgeInsets.only(right: 16.w),
                  child: _buildAvatarItem(index),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarItem(int index) {
    final names = ["Sarat", "Mike", "Emma", "James", "Lily"];
    final colors = [
      Colors.green,
      Colors.green,
      Colors.orange,
      Colors.grey,
      Colors.red,
    ];
    final initials = ["SJ", "MC", "ED", "JW", "LI"];

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryLight.withOpacity(
                  0.2,
                ), // Light background for initials
              ),
              child: Center(
                child: Text(
                  initials[index],
                  style: FontManager.heading3(
                    fontSize: 18,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 2,
              bottom: 2,
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: colors[index],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        AppSpacing.h8,
        Text(names[index], style: FontManager.bodySmall(fontSize: 12)),
      ],
    );
  }
}
