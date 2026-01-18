import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // Format date: "Dec 10, 2024"
    final dateFormatted = DateFormat('MMM d, yyyy').format(event.date);
    // Format time: "7:00 AM - 8:00 AM"
    final startTimeFormatted = event.startTime.format(context);
    final endTimeFormatted = event.endTime.format(context);
    final timeFormatted = "$startTimeFormatted - $endTimeFormatted";

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppPadding.p20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppPadding.p20),
                ),
                child: Image.network(
                  event.imageUrl,
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150.h,
                      color: AppColors.greyE8,
                      child: Center(
                        child: Icon(Icons.image, color: AppColors.grey),
                      ),
                    );
                  },
                ),
              ),
              if (event.isNew)
                Positioned(
                  top: AppPadding.p12,
                  right: AppPadding.p12,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p8,
                      vertical: AppPadding.p4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'New',
                      style: FontManager.labelSmall(
                        color: AppColors.primaryColor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Pill
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p8,
                    vertical: AppPadding.p4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.greyEFF,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    event.category,
                    style: FontManager.labelSmall(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ),
                AppSpacing.h8,
                // Title
                Text(
                  event.title,
                  style: FontManager.heading3(fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.h8,
                // Description
                Text(
                  event.description,
                  style: FontManager.bodySmall(color: AppColors.textSecondary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.h12,

                // Info Rows
                _buildInfoRow(Icons.calendar_today_outlined, dateFormatted),
                AppSpacing.h4,
                _buildInfoRow(Icons.access_time, timeFormatted),
                AppSpacing.h4,
                _buildInfoRow(Icons.location_on_outlined, event.location),
                AppSpacing.h4,
                _buildInfoRow(
                  Icons.people_outline,
                  "${event.currentAttendees}/${event.maxAttendees} attending",
                ),
                AppSpacing.h8,

                // Host
                Text(
                  "Hosted by ${event.hostName}",
                  style: FontManager.bodySmall(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
                AppSpacing.h16,

                // Join Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print("Join Event ${event.title}");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppPadding.p12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
                    ),
                    child: Text(
                      "Join Event",
                      style: FontManager.labelLarge(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: AppColors.textSecondary),
        AppSpacing.w8,
        Expanded(
          child: Text(
            text,
            style: FontManager.bodySmall(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
