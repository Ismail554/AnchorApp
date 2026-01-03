import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/app_strings.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/custom_widget/mini_widget/widget_textfield.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: Text(AppStrings.forgotPassword, style: FontManager.heading3()),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(" Email", style: FontManager.normalText()),
              SizedBox(height: 12.h),
              WidgetTextfield(
                hintText: "yourmail@mail.com",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.mail,
              ),
              AppSpacing.h40,
              Text(
                "We will send an email to verify....",
                style: FontManager.generalText(color: Colors.black),
              ),
              AppSpacing.h12,
              SizedBox(
                width: double.infinity,
                height: 42.h,
                child: FilledButton(
                  onPressed: () {},
                  child: Text("Send", style: FontManager.buttonText()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
