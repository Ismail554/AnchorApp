import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/app_strings.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/font_manager.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;

  const SocialLoginButtons({
    super.key,
    this.onGooglePressed,
    this.onApplePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Google Button
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.textPrimary,
              side: BorderSide(
                color: AppColors.grey.withOpacity(0.3),
                width: 1,
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(borderRadius: AppPadding.c12),
            ),
            onPressed: onGooglePressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(SvgAssets.googleIcon),
                AppSpacing.w8,
                Text(
                  AppStrings.google,
                  style: FontManager.bodyMedium(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
        AppSpacing.w12,
        // Apple Button
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.textPrimary,
              side: BorderSide(
                color: AppColors.grey.withOpacity(0.3),
                width: 1,
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(borderRadius: AppPadding.c12),
            ),
            onPressed: onApplePressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.apple, size: 20.sp, color: AppColors.grey),
                AppSpacing.w8,
                Text(
                  AppStrings.apple,
                  style: FontManager.bodyMedium(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
