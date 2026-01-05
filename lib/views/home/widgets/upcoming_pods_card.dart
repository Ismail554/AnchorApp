import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';

class UpcomingPodsCard extends StatelessWidget {
  const UpcomingPodsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppPadding.p20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 20.sp,
                    color: AppColors.textPrimary,
                  ),
                  AppSpacing.w8,
                  Text(
                    "Upcoming A-Pods",
                    style: FontManager.heading3(fontSize: 16),
                  ),
                ],
              ),
              Text(
                "View All",
                style: FontManager.bodySmall(
                  fontSize: 12,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          AppSpacing.h16,

          _buildPodItem(
            initials: "SJ",
            name: "Sarah Johnson",
            time: "Today, 3:00 PM",
            timeTag: "2h 30m",
            bgColor: AppColors.primaryLight.withOpacity(0.2),
            tagColor: AppColors.primaryColor.withOpacity(0.1),
            tagTextColor: AppColors.primaryColor,
          ),
          AppSpacing.h12,
          _buildPodItem(
            initials: "MC",
            name: "Mike Chen",
            time: "Tomorrow, 10:00 AM",
            timeTag: "1d 18h",
            bgColor: Colors.blue.withOpacity(0.1),
            tagColor: Colors.blue.withOpacity(0.1),
            tagTextColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildPodItem({
    required String initials,
    required String name,
    required String time,
    required String timeTag,
    required Color bgColor,
    required Color tagColor,
    required Color tagTextColor,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.bgColor, // Very light grey background for items
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Center(
              child: Text(
                initials,
                style: FontManager.heading4(color: AppColors.textPrimary),
              ),
            ),
          ),
          AppSpacing.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: FontManager.heading4(fontSize: 15)),
                Text(time, style: FontManager.bodySmall(fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: tagColor,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              timeTag,
              style: FontManager.labelSmall(color: tagTextColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
