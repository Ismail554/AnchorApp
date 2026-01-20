import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/check_ins/steps/step_1_mood.dart'; // Mapped to Quality
import 'package:wynante/views/check_ins/steps/step_2_details.dart'; // Mapped to Desire
import 'package:wynante/views/check_ins/steps/step_3_result.dart'; // Mapped to Value

class CheckInHomeScreen extends StatefulWidget {
  const CheckInHomeScreen({super.key});

  @override
  State<CheckInHomeScreen> createState() => _CheckInHomeScreenState();
}

class _CheckInHomeScreenState extends State<CheckInHomeScreen> {
  int _currentStep = 0; // 0, 1, 2

  // Data State
  String _quality = "";
  String _desire = "";
  String _value = "";
  String _comments = "";

  final int _totalSteps = 3;

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  // Back handling: if step > 0, go back. Else pop screen.
  Future<bool> _onWillPop() async {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      return false; // Don't pop route
    }
    return true; // Pop route
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep--;
                });
              } else {
                Navigator.pop(context);
              }
            },
          ),
          centerTitle: true,
          title: Text(
            "Check-In with Sarah Johnson",
            style: FontManager.heading4(fontSize: 16),
          ),
        ),
        body: Column(
          children: [
            _buildBarStepper(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    _buildStepContent(),
                    // Render "Continue" button for Step 1 and 2 here centrally or inside widgets?
                    // Design has "Continue" button at the bottom of the list.
                    // For Step 3, button is "Complete Check-In".
                    // To keep it simple, I'll pass callbacks to steps and let them trigger next,
                    // OR render button here if a value is selected?
                    // The screenshots show the button at the bottom.
                    // Step 3 has it inside the scrollable area.
                    // Let's implement generic "Continue" here for Step 1 & 2 only if data selected.
                    if (_currentStep < 2) _buildContinueButton(),
                    AppSpacing.h60,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarStepper() {
    return Container(
      color: AppColors.bgColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        children: [
          Row(
            children: List.generate(_totalSteps, (index) {
              return Expanded(
                child: Container(
                  height: 4.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: index <= _currentStep
                        ? AppColors.primaryColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              );
            }),
          ),
          AppSpacing.h12,
          Text(
            "Step ${_currentStep + 1} of $_totalSteps",
            style: FontManager.bodySmall(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return Step1Quality(
          onOptionSelected: (val) {
            setState(() {
              _quality = val;
            });
          },
        );
      case 1:
        return Step2Desire(
          onOptionSelected: (val) {
            setState(() {
              _desire = val;
            });
          },
        );
      case 2:
        return Step3Value(
          onComplete: (val, comment) {
            _value = val;
            _comments = comment;
            // Finish logic
            Navigator.pop(context); // Or show success dialog
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildContinueButton() {
    bool isEnabled = false;
    if (_currentStep == 0 && _quality.isNotEmpty) isEnabled = true;
    if (_currentStep == 1 && _desire.isNotEmpty) isEnabled = true;

    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: isEnabled ? _nextStep : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          disabledBackgroundColor: AppColors.primaryColor.withOpacity(0.5),
        ),
        child: Text(
          "Continue",
          style: FontManager.bodyMedium(color: Colors.white),
        ),
      ),
    );
  }
}
