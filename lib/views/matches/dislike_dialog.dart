import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/your_connection_model.dart';

class DislikeDialog extends StatefulWidget {
  final YourConnectionModel connection;
  final VoidCallback onSkip;
  final Function(String) onSubmit;

  const DislikeDialog({
    super.key,
    required this.connection,
    required this.onSkip,
    required this.onSubmit,
  });

  @override
  State<DislikeDialog> createState() => _DislikeDialogState();
}

class _DislikeDialogState extends State<DislikeDialog> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: AppPadding.r24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close Button
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: widget.onSkip,
                child: Icon(Icons.close, size: 20.sp, color: AppColors.grey),
              ),
            ),
            // Avatar and Name
            Row(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 24.r,
                        backgroundImage: AssetImage(widget.connection.pic),
                      ),
                    ),
                    Positioned(
                      bottom: -8,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          "100%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.w12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.connection.name,
                      style: FontManager.heading4(fontSize: 16),
                    ),
                    Text(
                      widget.connection.role,
                      style: FontManager.bodySmall(color: AppColors.grey),
                    ),
                  ],
                ),
              ],
            ),
            AppSpacing.h24,
            // Question
            Text(
              "Why did you dislike this person?",
              style: FontManager.bodyMedium().copyWith(fontWeight: FontWeight.w500),
            ),
            AppSpacing.h12,
            // Text Entry (Using basic container if widget_textfield is too specific, but let's try a simple container first to match design exactly)
            Container(
              height: 120.h,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FD),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.greyE8),
              ),
              child: TextField(
                controller: _reasonController,
                maxLines: 5,
                decoration: InputDecoration.collapsed(
                  hintText: "Write the reason here",
                  hintStyle: FontManager.bodySmall(color: AppColors.grey),
                ),
                style: FontManager.bodyMedium(fontSize: 14),
              ),
            ),
            AppSpacing.h24,
            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onSkip,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF2D9CFC)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      "Skip",
                      style: FontManager.heading4(
                        fontSize: 16,
                        color: const Color(0xFF2D9CFC),
                      ),
                    ),
                  ),
                ),
                AppSpacing.w16,
                Expanded(
                  child: FilledButton(
                    onPressed: () => widget.onSubmit(_reasonController.text),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF2D9CFC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      "Submit",
                      style: FontManager.heading4(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
