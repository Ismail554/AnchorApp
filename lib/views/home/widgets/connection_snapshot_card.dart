import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';

class ConnectionSnapshotCard extends StatelessWidget {
  const ConnectionSnapshotCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppPadding.p20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.insights, size: 20.sp, color: AppColors.primaryColor),
              AppSpacing.w8,
              Text(
                "Connection Snapshot",
                style: FontManager.heading3(fontSize: 16),
              ),
            ],
          ),
          AppSpacing.h16,

          _buildProgressRow(
            icon: Icons.people_outline,
            label: "Social",
            percent: 0.72,
            color: Colors.blue,
          ),
          AppSpacing.h12,
          _buildProgressRow(
            icon: Icons.favorite_border,
            label: "Romantic",
            percent: 0.85,
            color: Colors.red,
          ),
          AppSpacing.h12,
          _buildProgressRow(
            icon: Icons.spa_outlined,
            label: "Spiritual",
            percent: 0.60,
            color: Colors.purple,
          ),
          AppSpacing.h12,
          _buildProgressRow(
            icon: Icons.work_outline,
            label: "Professional",
            percent: 0.68,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRow({
    required IconData icon,
    required String label,
    required double percent,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16.sp, color: color),
            AppSpacing.w8,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: FontManager.bodyMedium(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '${(percent * 100).toInt()}%',
                    style: FontManager.bodyMedium(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        AppSpacing.h6,
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: percent,
            backgroundColor: AppColors.grey.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6.h,
          ),
        ),
      ],
    );
  }
}
