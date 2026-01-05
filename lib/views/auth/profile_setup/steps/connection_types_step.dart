import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';

class ConnectionTypesStep extends StatelessWidget {
  final List<String> selectedConnections;
  final ValueChanged<String> onChanged;

  const ConnectionTypesStep({
    super.key,
    required this.selectedConnections,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.h24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.h16,
          Text("Connection Types", style: FontManager.heading3(fontSize: 20)),
          AppSpacing.h8,
          Text(
            "What kind of connections are you looking for? (Select all that apply)",
            style: FontManager.bodyMedium(color: AppColors.grey),
          ),
          AppSpacing.h32,
          _buildOption(
            "Social",
            "Build friendships and social connections",
            Icons.people_outline,
            Colors.blue,
          ),
          AppSpacing.h16,
          _buildOption(
            "Romantic",
            "Find meaningful romantic relationships",
            Icons.favorite_border,
            Colors.pink, // Or AppColors.error/red
          ),
          AppSpacing.h16,
          _buildOption(
            "Spiritual",
            "Connect on a deeper spiritual level",
            Icons.spa_outlined,
            Colors.purple,
          ),
          AppSpacing.h16,
          _buildOption(
            "Professional",
            "Grow your professional network",
            Icons.work_outline,
            Colors.orange, // Or relevant color
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
  ) {
    bool isSelected = selectedConnections.contains(title);
    return GestureDetector(
      onTap: () => onChanged(title),
      child: Container(
        padding: AppPadding.r16,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.grey.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor
                    : iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.white : iconColor,
                size: 24.sp,
              ),
            ),
            AppSpacing.w16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FontManager.heading4(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
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
            ),
            if (isSelected)
              Icon(Icons.check, color: AppColors.primaryColor, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
