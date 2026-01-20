import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/settings/subscription_plan_screen.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

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
          // Row with Avatar, Info, and Upgrade Button
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(ImageAssets.men1),
              ),
              AppSpacing.w12,

              // Name and Plan
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MD Ismail",
                      style: FontManager.titleText(fontSize: 18),
                    ),
                    Text(
                      "Free Plan",
                      style: FontManager.heading4(color: AppColors.grey),
                    ),
                  ],
                ),
              ),

              // Upgrade Button
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubscriptionPlanScreen(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "Upgrade",
                        style: FontManager.buttonText(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          AppSpacing.h16,

          // Profile Completeness
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Profile Completeness",
                style: FontManager.bodySmall(fontSize: 12),
              ),
              Text(
                "75%",
                style: FontManager.bodySmall(
                  fontSize: 12,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          AppSpacing.h8,
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: 0.75,
              backgroundColor: AppColors.grey.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primaryColor,
              ),
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }
}
