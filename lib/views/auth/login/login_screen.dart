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
import 'package:wynante/views/auth/forgot_pass_screen.dart';
import 'package:wynante/views/auth/sign_up/signup_screen.dart';
import 'package:wynante/views/auth/profile_setup/profile_setup_screen.dart';
import 'package:wynante/custom_widget/mini_widget/social_login_buttons.dart';

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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Forgot Password Link
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassScreen(),
                        ),
                      );
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
                    // Navigate to Profile Setup for now
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileSetupScreen(),
                      ),
                    );
                  },
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
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
              // Social Login Buttons
              SocialLoginButtons(
                onGooglePressed: () {
                  // TODO: Implement Google login
                },
                onApplePressed: () {
                  // TODO: Implement Apple login
                },
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
