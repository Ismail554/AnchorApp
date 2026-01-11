import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_padding.dart';

class ProfileCompletenessCard extends StatelessWidget {
  final int percentage;

  const ProfileCompletenessCard({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPadding.r20,
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
      child: Column(
        children: [
          Text(
            "Profile Completeness",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 16.h),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80.r,
                height: 80.r,
                child: CircularProgressIndicator(
                  value: percentage / 100,
                  strokeWidth: 6.r,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              Text(
                "$percentage%",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            "Complete your profile to get better matches",
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
