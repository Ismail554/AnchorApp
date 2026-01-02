import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_strings.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/onboarding/onboarding_base_widget.dart';

class OnboadingScreen1 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback? onLogin;

  const OnboadingScreen1({
    super.key,
    required this.onNext,
    required this.onSkip,
    this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingBaseWidget(
      backgroundImage: ImageAssets.onboadiing1,
      title: _buildTitleWithHighlights(),
      description: AppStrings.onboardingDescription,
      buttonText: AppStrings.next,
      isLastScreen: false,
      onNext: onNext,
      onSkip: onSkip,
      onLogin: onLogin,
      currentPage: 0,
      totalPages: 3,
    );
  }

  /// Build title with green highlights for "Power" and "AI"
  Widget _buildTitleWithHighlights() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: FontManager.titleText(
            fontSize: 28.sp,
            color: AppColors.textPrimary,
          ),
          children: [
            const TextSpan(text: 'Unlock the '),
            TextSpan(
              text: 'Power',
              style: FontManager.titleText(
                fontSize: 28.sp,
                color: Colors.green, // Green highlight for "Power"
              ),
            ),
            const TextSpan(text: ' Of '),
            TextSpan(
              text: ' Future AI',
              style: FontManager.titleText(
                fontSize: 28.sp,
                color: Colors.green, // Green highlight for "AI"
              ),
            ),
          ],
        ),
      ),
    );
  }
}
