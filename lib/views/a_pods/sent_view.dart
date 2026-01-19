import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';

class SentView extends StatelessWidget {
  const SentView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppPadding.all16,
      children: [
        _buildSentCard(
          name: "Michael Scott",
          tag: "Professional",
          tagColor: Colors.green,
          time: "Yesterday, 3:00 PM",
          message: "Checking in on the project status.",
          initials: "MS",
          avatarColor: Colors.orange.shade100,
        ),
        AppSpacing.h16,
        _buildSentCard(
          name: "Pam Beesly",
          tag: "Social",
          tagColor: Colors.blue,
          time: "Dec 12, 10:00 AM",
          message: "Lunch sounds great!",
          initials: "PB",
          avatarColor: Colors.purple.shade100,
        ),
      ],
    );
  }

  Widget _buildSentCard({
    required String name,
    required String tag,
    required Color tagColor,
    required String time,
    required String message,
    required String initials,
    required Color avatarColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: AppPadding.all16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: avatarColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  initials,
                  style: FontManager.heading4(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              AppSpacing.w12,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: FontManager.heading4(fontSize: 16)),
                  AppSpacing.h4,
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: tagColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          tag,
                          style: FontManager.bodySmall(
                            color: tagColor,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      AppSpacing.w8,
                      Text(
                        "•  $time",
                        style: FontManager.bodySmall(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          AppSpacing.h16,
          Container(
            padding: AppPadding.all12,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              message,
              style: FontManager.bodyMedium(
                color: Colors.grey[700]!,
                fontSize: 14,
              ),
            ),
          ),
          AppSpacing.h16,
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    "Cancel Request",
                    style: FontManager.bodyMedium(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
