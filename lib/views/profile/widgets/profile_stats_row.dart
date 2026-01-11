import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/models/user_profile_model.dart';

class ProfileStatsRow extends StatelessWidget {
  final UserProfile user;

  const ProfileStatsRow({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.r16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppPadding.c20,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem(user.connections, "Connections", Icons.people_outline),
          _buildStatItem(
            user.aFoos,
            "A-Foos",
            Icons.calendar_today_outlined,
          ), // Placeholder icon
          _buildStatItem(user.checkIns, "Check-ins", Icons.notifications_none),
          _buildStatItem(
            user.rating,
            "Rating",
            Icons.star_border,
            isRating: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    num value,
    String label,
    IconData icon, {
    bool isRating = false,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 24.r),
        SizedBox(height: 8.h),
        Text(
          "$value",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
        ),
      ],
    );
  }
}
