import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/models/user_profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfile user;
  final VoidCallback onEdit;

  const ProfileHeader({super.key, required this.user, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPadding.r20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Badge
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                user.userType,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Main Content
          Column(
            children: [
              SizedBox(
                height: 10.h,
              ), // Spacing for badge if needed, or just center
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: AssetImage(user.avatarUrl),
                  ),
                  Container(
                    padding: AppPadding.r4,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.edit, color: Colors.white, size: 16.r),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              RichText(
                text: TextSpan(
                  text: user.name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: " (${user.age}y)",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                user.jobTitle,
                style: TextStyle(color: Colors.grey, fontSize: 14.sp),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14.r,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    user.location,
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ElevatedButton.icon(
                onPressed: onEdit,
                icon: Icon(Icons.edit_note_rounded, size: 18.r),
                label: const Text("Edit Profile"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Temporary color constant if not found globally, usually should import
const Color marginBottom = Colors.black;
