import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/app_strings.dart';
import 'package:wynante/core/font_manager.dart';

import 'package:wynante/custom_widget/mini_widget/linear_logo.dart';
import 'package:wynante/custom_widget/mini_widget/widget_textfield.dart';
import 'package:wynante/views/auth/login/login_screen.dart';
import 'package:wynante/views/auth/sign_up/verification_screen.dart';
import 'package:wynante/custom_widget/mini_widget/social_login_buttons.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              // Logo
              Align(alignment: Alignment.centerLeft, child: LinearLogo()),

              // Top Image
              Image.asset(
                IconAssets.sighupIcon,
                width: double.maxFinite,
                height: 160.h,
              ),
              AppSpacing.h24,
              // Title: "Create your new account"
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: FontManager.normalText(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                  ),
                  children: [
                    const TextSpan(text: 'Create your '),
                    TextSpan(
                      text: 'new account',
                      style: FontManager.normalText(
                        color: Colors.green,
                        fontSize: 24,
                      ),
                    ),
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
              AppSpacing.h16,
              // Confirm Password Field
              WidgetTextfield(
                hintText: AppStrings.confirmPasswordHint,
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                controller: _confirmPasswordController,
              ),
              AppSpacing.h28,

              // Register Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    // Navigate to verification screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerificationScreen(
                          source: VerificationSource.signup,
                        ),
                      ),
                    );
                  },

                  child: Text(
                    AppStrings.register,
                    style: FontManager.buttonText(
                      fontSize: 16,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              AppSpacing.h20,
              // Already have account? Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.alreadyHaveAccount,
                    style: FontManager.bodyMedium(
                      fontSize: 14,
                      color: AppColors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.only(left: 4.w),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      AppStrings.login,
                      style: FontManager.bodyMedium(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.h20,
              // Or sign up with separator
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
                      AppStrings.orSignUpWith,
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
              // Social Sign Up Buttons
              SocialLoginButtons(
                onGooglePressed: () {
                  // TODO: Implement Google sign up
                },
                onApplePressed: () {
                  // TODO: Implement Apple sign up
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
