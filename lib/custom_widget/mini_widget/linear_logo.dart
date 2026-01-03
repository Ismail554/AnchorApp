import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/app_strings.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/font_manager.dart';

class LinearLogo extends StatelessWidget {
  const LinearLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // App Logo
        Image.asset(IconAssets.appIcon, width: 32.w, height: 32.h),
        AppSpacing.w8,
        // Anchor Up text
        Text(
          AppStrings.anchorUp,
          style: FontManager.heading3(
            fontSize: 18,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
