import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/app_strings.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/custom_widget/mini_widget/linear_logo.dart';
import 'package:wynante/custom_widget/mini_widget/widget_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSpacing.h24,
              // Logo
              Align(alignment: Alignment.centerLeft, child: LinearLogo()),
              AppSpacing.h24,
              // Top Image
              Image.asset(IconAssets.loginIcon),
              AppSpacing.h24,
              // Title: "Login to your account"
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: FontManager.normalText(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                  ),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: FontManager.normalText(
                        color: Colors.green,
                        fontSize: 24,
                      ),
                    ),
                    const TextSpan(text: ' to your account'),
                  ],
                ),
              ),
              AppSpacing.h32,
              // Email Field
              WidgetTextfield(
                hintText: AppStrings.emailHint,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              AppSpacing.h16,
              // Password Field
              WidgetTextfield(
                hintText: AppStrings.passwordHint,
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                controller: _passwordController,
              ),
              AppSpacing.h12,
              // Remember me & Forgot Password Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Remember Me Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      Text(
                        AppStrings.rememberMe,
                        style: FontManager.bodyMedium(
                          fontSize: 14,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  // Forgot Password Link
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to forgot password screen
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      AppStrings.forgotPassword,
                      style: FontManager.bodyMedium(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.h24,
              // Login Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    // TODO: Implement login logic
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: AppPadding.c12),
                  ),
                  child: Text(
                    AppStrings.login,
                    style: FontManager.buttonText(
                      fontSize: 16,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              AppSpacing.h24,
              // Don't have account? Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.dontHaveAccount,
                    style: FontManager.bodyMedium(
                      fontSize: 14,
                      color: AppColors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to register screen
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.only(left: 4.w),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      AppStrings.register,
                      style: FontManager.bodyMedium(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.h32,
              // Or login with separator
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.grey.withOpacity(0.3),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      child: CustomPaint(painter: DottedLinePainter()),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      AppStrings.orLoginWith,
                      style: FontManager.bodySmall(
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.grey.withOpacity(0.3),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      child: CustomPaint(painter: DottedLinePainter()),
                    ),
                  ),
                ],
              ),
              AppSpacing.h24,
              // Social Login Buttons
              Row(
                children: [
                  // Google Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Implement Google login
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.textPrimary,
                        side: BorderSide(
                          color: AppColors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppPadding.c12,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Google Logo (G icon) - Simplified
                          Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF4285F4), // Blue
                                  const Color(0xFF34A853), // Green
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                'G',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
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
                      onPressed: () {
                        // TODO: Implement Apple login
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.textPrimary,
                        side: BorderSide(
                          color: AppColors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppPadding.c12,
                        ),
                      ),
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
              ),
              AppSpacing.h32,
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom painter for dotted line
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 3.0;
    const dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
