import 'package:flutter/material.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/custom_widget/mini_widget/linear_logo.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: .center,
            children: [
              LinearLogo(),
              AppSpacing.h2,
              Image.asset(IconAssets.sighupIcon)
            ],
          ),
        ),
      ),
    );
  }
}