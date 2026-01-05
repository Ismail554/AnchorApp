import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';

class SummaryStep extends StatelessWidget {
  final String name;
  final String location;
  final int connectionCount;
  final String category;
  final int photoCount;
  final VoidCallback onComplete;

  const SummaryStep({
    super.key,
    required this.name,
    required this.location,
    required this.connectionCount,
    required this.category,
    required this.photoCount,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.h24,
      child: Column(
        children: [
          AppSpacing.h40,
          Container(
            width: 80.w,
            height: 80.w,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: AppColors.white, size: 40.sp),
          ),
          AppSpacing.h24,
          Text("You're All Set!", style: FontManager.heading3(fontSize: 24)),
          AppSpacing.h8,
          Text(
            "Your profile is ready. Start building meaningful connections today!",
            textAlign: TextAlign.center,
            style: FontManager.bodyMedium(color: AppColors.grey),
          ),
          AppSpacing.h40,
          Container(
            padding: AppPadding.r20,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile Summary",
                  style: FontManager.heading4(fontSize: 14),
                ),
                AppSpacing.h16,
                _buildRow("Name", name),
                AppSpacing.h12,
                _buildRow("Location", location),
                AppSpacing.h12,
                _buildRow("Connection Types", "$connectionCount selected"),
                AppSpacing.h12,
                _buildRow("Category", category),
                AppSpacing.h12,
                _buildRow("Photos", "$photoCount uploaded"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: FontManager.bodyMedium(color: AppColors.grey, fontSize: 12.sp),
        ),
        Text(value, style: FontManager.heading4(fontSize: 12.sp)),
      ],
    );
  }
}
