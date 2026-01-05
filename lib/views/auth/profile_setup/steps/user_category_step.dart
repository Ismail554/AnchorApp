import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';

class UserCategoryStep extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onChanged;

  const UserCategoryStep({
    super.key,
    required this.selectedCategory,
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
          Text("User Category", style: FontManager.heading3(fontSize: 20)),
          AppSpacing.h8,
          Text(
            "How would you describe yourself?",
            style: FontManager.bodyMedium(color: AppColors.grey),
          ),
          AppSpacing.h32,
          _buildOption(
            "Seeker",
            "I'm looking to connect with others and build meaningful relationships across various dimensions of life.",
          ),
          AppSpacing.h24,
          _buildOption(
            "Professional Provider",
            "I'm a professional offering services (coaching, therapy, mentorship, etc.) to help others grow.",
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String title, String description) {
    bool isSelected = selectedCategory == title;
    return GestureDetector(
      onTap: () => onChanged(title),
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: AppColors.white,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: FontManager.heading4(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check, color: AppColors.primaryColor, size: 20.sp),
              ],
            ),
            AppSpacing.h12,
            Text(
              description,
              style: FontManager.bodyMedium(
                fontSize: 14,
                color: AppColors.textSecondary,
              ).copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
