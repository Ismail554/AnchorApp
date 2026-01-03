import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

// Tomar project er imports gulo thakuk, ami just niche use korechi
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/app_strings.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/core/app_padding.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  Timer? _timer;
  int _secondsRemaining = 59;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}.${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    // 🎨 DESIGN TIP: Pinput er Theme ta ekhane define korlam jate clean thake
    // Image e dekho, field gulo sada, gol, ar halka shadow ache.

    final defaultPinTheme = PinTheme(
      width: 60.w, // Image e field gulo besh boro
      height: 60.w,
      textStyle: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary, // Tomar text color
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle, // Golla Shape 🔴
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Halka shadow
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );

    // Jokhon user click korbe (Focus obosthay)
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1.5,
        ), // Blue border
      ),
    );

    return Scaffold(
      // Image e background ta ekdom clean white/off-white mone hocche
      backgroundColor: Colors.grey[50], // Ektu soft background dilam
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          AppStrings.verification, // "Verification"
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Sobkichu majhkhane
            children: [
              AppSpacing.h40, // Top theke ektu niche namalam
              // Title: "We have sent you..."
              Text(
                AppStrings.activationCodeSent,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold, // Image e eta mota
                  color: AppColors.textPrimary,
                ),
              ),

              AppSpacing.h16,

              // Description: "A SMS has been sent..."
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  AppStrings.smsSentDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey, // Image e eta grey
                    height: 1.5, // Line height baralam porar subidhar jonno
                  ),
                ),
              ),

              AppSpacing.h40,

              // Label: "Enter verification code"
              Text(
                AppStrings.enterVerificationCode,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),

              AppSpacing.h24,

              // 🔢 PINPUT SECTION
              Pinput(
                controller: _pinController,
                focusNode: _pinFocusNode,
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme, // Eta optional, default tai kaj korbe
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => debugPrint(pin),
                mainAxisAlignment:
                    MainAxisAlignment.center, // Gap ta adjust korbe
              ),

              AppSpacing.h40,

              // "Didn't receive a code?" Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppStrings.didntReceiveCode} ",
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Resend logic here
                    },
                    child: Text(
                      AppStrings.clickHere,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // Image e Blue color
                      ),
                    ),
                  ),
                ],
              ),

              AppSpacing.h8,

              // Timer Row: "Code will expire soon. 00.59"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppStrings.codeWillExpire} ",
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  Text(
                    _formatTime(_secondsRemaining),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green, // Image e Green color 🟢
                    ),
                  ),
                ],
              ),

              AppSpacing.h48, // Button er age valo gap
              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56.h, // Standard button height
                child: FilledButton(
                  onPressed: () {
                    // Action
                  },

                  child: Text(
                    AppStrings.continueText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              AppSpacing.h24,
            ],
          ),
        ),
      ),
    );
  }
}
