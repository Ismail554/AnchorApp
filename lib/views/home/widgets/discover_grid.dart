import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/events/event_home_screen.dart';

class DiscoverGrid extends StatelessWidget {
  const DiscoverGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildDiscoverCard(
            icon: Icons.favorite_border,
            title: "Find Matches",
            subtitle: "Discover new connections",
            iconColor: Colors.blue,
          ),
        ),
        AppSpacing.w16,
        Expanded(
          child: _buildDiscoverCard(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventHomeScreen(),
                ),
              );
            },
            icon: Icons.trending_up,
            title: "Events",
            subtitle: "Join community events",
            iconColor: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildDiscoverCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140.h,
        padding: EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppPadding.p20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 28.sp, color: iconColor),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: FontManager.heading3(fontSize: 16)),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: FontManager.bodySmall(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
