import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';

class CheckInOptionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? emoji; // For Step 1
  final bool isSelected;
  final VoidCallback onTap;

  const CheckInOptionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: AppPadding.all16,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : Colors.grey.shade200,
              width: 1.5,
            ),
            boxShadow: [
              if (!isSelected)
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            children: [
              if (emoji != null) ...[
                Text(emoji!, style: TextStyle(fontSize: 24.sp)),
                AppSpacing.w16,
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: FontManager.heading4(
                        fontSize: 14,
                        color:
                            Colors.black, // Always black text based on design
                      ),
                    ),
                    if (subtitle != null) ...[
                      AppSpacing.h4,
                      Text(
                        subtitle!,
                        style: FontManager.bodySmall(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: AppColors.primaryColor,
                  size: 24.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
