import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';

class ScheduledView extends StatelessWidget {
  const ScheduledView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppPadding.all16,
      children: [
        _buildScheduledCard(
          name: "Sarah Johnson",
          tag: "Romantic",
          tagColor: Colors.pink,
          timeText: "Today, 3:00 PM",
          timeLeft: "2h 30m",
          initials: "SJ",
          avatarColor: Colors.blue.shade100,
        ),
        AppSpacing.h16,
        _buildScheduledCard(
          name: "Mike Chen",
          tag: "Professional",
          tagColor: Colors.green,
          timeText: "Tomorrow, 10:00 AM",
          timeLeft: "1d 18h",
          initials: "MC",
          avatarColor: Colors.blue.shade100,
        ),
        AppSpacing.h16,
        _buildScheduledCard(
          name: "Emma Davis",
          tag: "Social",
          tagColor: Colors.blue,
          timeText: "Dec 11, 5:00 PM",
          timeLeft: "3d 12h",
          initials: "ED",
          avatarColor: Colors.blue.shade100,
        ),
        AppSpacing.h16,
        _buildScheduledCard(
          name: "Lisa Anderson",
          tag: "Spiritual",
          tagColor: Colors
              .purple, // Assuming Spiritual is purple based on previous context
          timeText: "Dec 13, 2:00 PM",
          timeLeft: "5d 9h",
          initials: "LA",
          avatarColor: Colors.blue.shade100,
        ),
      ],
    );
  }

  Widget _buildScheduledCard({
    required String name,
    required String tag,
    required Color tagColor,
    required String timeText,
    required String timeLeft,
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
                  style: FontManager.heading4(color: Colors.blue, fontSize: 16),
                ),
              ),
              AppSpacing.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name, style: FontManager.heading4(fontSize: 16)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            timeLeft,
                            style: FontManager.bodySmall(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.h4,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            // border: Border.all(color: tagColor.withOpacity(0.5)),
                            color: tagColor.withOpacity(0.1),
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
                        Text(
                          timeText,
                          style: FontManager.bodySmall(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.h16,
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.videocam_outlined,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Join Meeting",
                    style: FontManager.bodyMedium(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
              AppSpacing.w12,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.blue,
                    size: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 10.w,
                  ),
                  constraints:
                      const BoxConstraints(), // To remove default constraints
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
