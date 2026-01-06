import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';

class ReportModal extends StatefulWidget {
  const ReportModal({super.key});

  @override
  State<ReportModal> createState() => _ReportModalState();
}

class _ReportModalState extends State<ReportModal> {
  String? _selectedReason;
  bool _isSubmitted = false;

  final List<String> _reasons = [
    "Spam or misleading",
    "Harassment or bullying",
    "Hate speech or symbols",
    "Violence or dangerous organizations",
    "Nudity or sexual activity",
    "False information",
    "Scam or fraud",
    "Intellectual property violation",
    "Something else",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.all(20.r),
      height: 0.7.sh,
      child: _isSubmitted
          ? _buildSubmittedView()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Report Comment",
                      style: FontManager.heading3(fontSize: 18),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                AppSpacing.h16,
                Text(
                  "Please select a reason for reporting this comment:",
                  style: FontManager.bodyMedium(color: AppColors.grey),
                ),
                AppSpacing.h16,
                Expanded(
                  child: ListView.separated(
                    itemCount: _reasons.length,
                    separatorBuilder: (context, index) => AppSpacing.h8,
                    itemBuilder: (context, index) {
                      final reason = _reasons[index];
                      final isSelected = _selectedReason == reason;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedReason = reason;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor.withOpacity(0.1)
                                : AppColors.greyF4,
                            borderRadius: BorderRadius.circular(30.r),
                            border: isSelected
                                ? Border.all(color: AppColors.primaryColor)
                                : null,
                          ),
                          child: Text(
                            reason,
                            style:
                                FontManager.bodyMedium(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.textPrimary,
                                ).copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AppSpacing.h16,
                // Additional info input
                TextField(
                  decoration: InputDecoration(
                    hintText: "Provide more details...",
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.grey,
                    ),
                    filled: true,
                    fillColor: AppColors.greyF4,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(12.r),
                  ),
                  maxLines: 3,
                ),
                AppSpacing.h16,
                // Action Buttons
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _selectedReason != null
                            ? () {
                                setState(() {
                                  _isSubmitted = true;
                                });
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          elevation: 0,
                        ),
                        child: const Text("Submit Report"),
                      ),
                    ),
                    AppSpacing.h12,
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green,
                          side: const BorderSide(color: Colors.green),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: const Text("Cancel"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildSubmittedView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Report Comment", style: FontManager.heading3(fontSize: 18)),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, size: 40.sp, color: AppColors.primaryColor),
        ),
        AppSpacing.h24,
        Text("Report Submitted", style: FontManager.heading3(fontSize: 20)),
        AppSpacing.h8,
        Text(
          "Thank you for helping keep AnchorUp safe.",
          textAlign: TextAlign.center,
          style: FontManager.bodyMedium(color: AppColors.grey),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
              elevation: 0,
            ),
            child: const Text("Close"),
          ),
        ),
      ],
    );
  }
}
