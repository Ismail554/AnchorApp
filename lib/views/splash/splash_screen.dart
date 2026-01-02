import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:wynante/core/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
      ),
    );
  }
}
