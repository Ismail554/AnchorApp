import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/font_manager.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 48.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w),
        // Use a placeholder logo or asset if available
        child: Container(
          // Placeholder for Logo
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.anchor,
            color: AppColors.primaryColor,
            size: 28,
          ),
        ),
      ),
      titleSpacing: 8.w,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("AnchorUp", style: FontManager.heading2(fontSize: 20)),
          Text("Welcome back!", style: FontManager.bodySmall(fontSize: 12)),
        ],
      ),
      actions: [
        // Notification Bell with Badge
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                color: AppColors.textSecondary,
                size: 26.sp,
              ),
            ),
            Positioned(
              right: 12.w,
              top: 12.h,
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        // Settings Icon
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings_outlined,
            color: AppColors.textSecondary,
            size: 26.sp,
          ),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
