import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_strings.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/home/homepage_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Check authentication status after splash delay
    Timer(const Duration(seconds: 3), () {
      // _checkAuthAndNavigate();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (cotext) => const HomepageScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.topLinear, // Top Blue
              AppColors.bottomLinear, // Bottom Green
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Center(
              child: Column(
                spacing: 4.h,
                children: [
                  Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(22),
                      color: AppColors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14.w),
                      child: Image.asset(IconAssets.appIcon, fit: BoxFit.fill),
                    ),
                  ),

                  Text(
                    AppStrings.anchorUp,
                    style: FontManager.titleText(color: AppColors.white),
                  ),
                  Text(
                    AppStrings.quote,
                    style: FontManager.heading3(
                      color: AppColors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
