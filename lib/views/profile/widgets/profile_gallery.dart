import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_padding.dart';

class ProfileGallery extends StatelessWidget {
  final List<String> images;
  final VoidCallback onEdit;

  const ProfileGallery({super.key, required this.images, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: AppPadding.h4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Gallery",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              TextButton(onPressed: onEdit, child: const Text("Edit")),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: AppPadding.c12,
                child: Image.asset(
                  images[index],
                  width: 100.h,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
