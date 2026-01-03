import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/app_strings.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/custom_widget/mini_widget/linear_logo.dart';
import 'package:wynante/views/auth/login/login_screen.dart';

/// Base widget for onboarding screens
/// Provides common layout and styling matching Figma design
class OnboardingBaseWidget extends StatelessWidget {
  final String backgroundImage;
  final Widget
  title; // Changed to Widget to support RichText with green highlights
  final String description;
  final String buttonText;
  final bool isLastScreen;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final int currentPage;
  final int totalPages;
  final VoidCallback? onLogin; // Callback for Login button

  const OnboardingBaseWidget({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.isLastScreen,
    required this.onNext,
    required this.onSkip,
    required this.currentPage,
    required this.totalPages,
    this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Logo + Anchor Up text and Skip button
            _buildHeader(context),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    // Main Image Card
                    _buildImageCard(),
                    AppSpacing.h12,

                    // Pagination Dots
                    _buildPaginationDots(),
                    AppSpacing.h12,

                    // Title with green highlights
                    _buildTitle(),

                    // Description
                    _buildDescription(),
                    AppSpacing.h12,
                    // Navigation Buttons
                    _buildNavigationButtons(context),
                    AppSpacing.h24,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Header with Logo + Anchor Up on left, Skip on right
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo + Anchor Up text
          LinearLogo(),
          // Skip Button - Navigate to Login Screen
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: Text(
              'Skip',
              style: FontManager.bodyMedium(
                fontSize: 16,
                color: AppColors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Large rounded image card
  Widget _buildImageCard() {
    return Container(
      width: double.maxFinite,
      height: 351.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.asset(
          backgroundImage,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.bgColor,
              child: Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 64.sp,
                  color: AppColors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Title with green highlights for "Power" and "AI"
  Widget _buildTitle() {
    return title;
  }

  /// Description text
  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: FontManager.bodyMedium(fontSize: 14, color: AppColors.grey),
      ),
    );
  }

  /// Pagination dots
  Widget _buildPaginationDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => _buildDot(index == currentPage),
      ),
    );
  }

  /// Individual pagination dot
  Widget _buildDot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: isActive ? 24.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primaryColor
            : AppColors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  /// Navigation buttons: Get Started (blue) and Login (white with blue border)
  Widget _buildNavigationButtons(BuildContext context) {
    return Column(
      children: [
        // Get Started Button (Blue filled)
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: onNext,
            child: Text(
              buttonText,
              style: FontManager.buttonText(color: AppColors.white),
            ),
          ),
        ),
        AppSpacing.h12,
        // Login Button (White with blue border)
        SizedBox(
          width: double.maxFinite,
          child: OutlinedButton(
            onPressed:
                onLogin ??
                () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
            child: Text(
              AppStrings.login,
              style: FontManager.buttonText(color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
