import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';

class CheckInsCard extends StatelessWidget {
  const CheckInsCard({super.key});

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
                    Icons.check_circle_outline,
                    size: 20.sp,
                    color: Colors.green,
                  ),
                  AppSpacing.w8,
                  Text(
                    "Check-ins Due",
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

          _buildCheckInItem(
            initials: "ED",
            name: "Emma Davis",
            details: "Social • 2 days overdue",
            bgColor: Colors.blue.withOpacity(0.1),
            textColor: Colors.blue,
          ),
          AppSpacing.h12,
          _buildCheckInItem(
            initials: "JW",
            name: "James Wilson",
            details: "Spiritual • 5 days overdue",
            bgColor: Colors.blue.withOpacity(0.1),
            textColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInItem({
    required String initials,
    required String name,
    required String details,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(
          0xFFFFF8EC,
        ), // Light Orange/Cream for check-in items specific to design
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFFFE0B2),
          width: 1,
        ), // Light orange border
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
                style: FontManager.heading4(color: textColor),
              ),
            ),
          ),
          AppSpacing.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: FontManager.heading4(fontSize: 15)),
                Text(details, style: FontManager.bodySmall(fontSize: 12)),
              ],
            ),
          ),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue, // As per image
              minimumSize: Size(80.w, 36.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              "Check In",
              style: FontManager.buttonText(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
