import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_padding.dart';

class ProfileInfoSection extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback onEdit;

  const ProfileInfoSection({
    super.key,
    required this.title,
    required this.content,
    required this.onEdit,
  });

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: onEdit,
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500, // Medium weight
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          content,
        ],
      ),
    );
  }
}
