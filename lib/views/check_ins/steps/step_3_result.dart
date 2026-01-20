import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/check_ins/widgets/check_in_option_card.dart';

class Step3Value extends StatefulWidget {
  final Function(String, String) onComplete;

  const Step3Value({super.key, required this.onComplete});

  @override
  State<Step3Value> createState() => _Step3ValueState();
}

class _Step3ValueState extends State<Step3Value> {
  int _selectedIndex = -1;
  final TextEditingController _commentController = TextEditingController();

  final List<Map<String, String>> _options = [
    {'label': 'Extremely Valuable', 'subtitle': 'Life-changing impact'},
    {'label': 'Very Valuable', 'subtitle': 'Significant positive impact'},
    {'label': 'Moderately Valuable', 'subtitle': 'Some positive impact'},
    {'label': 'Slightly Valuable', 'subtitle': 'Minimal impact'},
    {'label': 'Not Valuable', 'subtitle': 'No meaningful impact'},
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            children: [
              Text(
                "How valuable is this connection?",
                textAlign: TextAlign.center,
                style: FontManager.heading2(fontSize: 22),
              ),
              AppSpacing.h8,
              Text(
                "Rate the value this connection brings to your life",
                textAlign: TextAlign.center,
                style: FontManager.bodyMedium(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _options.length,
          itemBuilder: (context, index) {
            final option = _options[index];
            return CheckInOptionCard(
              title: option['label']!,
              subtitle: option['subtitle'],
              isSelected: _selectedIndex == index,
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                // Not calling onComplete yet, user needs to click button
              },
            );
          },
        ),
        AppSpacing.h24,
        Text(
          "Additional Comments (Optional)",
          style: FontManager.bodyMedium(fontSize: 14),
        ),
        AppSpacing.h8,
        TextField(
          controller: _commentController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Share any thoughts or feedback...",
            hintStyle: FontManager.bodyMedium(color: Colors.grey.shade400),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
            contentPadding: AppPadding.all16,
          ),
        ),
        AppSpacing.h32,
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedIndex != -1
                ? () {
                    widget.onComplete(
                      _options[_selectedIndex]['label']!,
                      _commentController.text,
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              disabledBackgroundColor: AppColors.primaryColor.withOpacity(0.5),
            ),
            child: Text(
              "Complete Check-In",
              style: FontManager.bodyMedium(color: Colors.white),
            ),
          ),
        ),
        AppSpacing.h32, // Bottom spacing
      ],
    );
  }
}
