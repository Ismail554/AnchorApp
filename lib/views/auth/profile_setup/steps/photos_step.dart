import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';

class PhotosStep extends StatefulWidget {
  final List<String> photos;
  final VoidCallback onAddPhoto;
  final Function(int) onRemovePhoto;

  const PhotosStep({
    super.key,
    required this.photos,
    required this.onAddPhoto,
    required this.onRemovePhoto,
  });

  @override
  State<PhotosStep> createState() => _PhotosStepState();
}

class _PhotosStepState extends State<PhotosStep> {
  String? get _profilePhoto =>
      widget.photos.isNotEmpty ? widget.photos[0] : null;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.h24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.h16,
          Text("Add Photos", style: FontManager.heading3(fontSize: 20)),
          AppSpacing.h8,
          Text(
            "Upload at least one photo to help others connect with you",
            style: FontManager.bodyMedium(color: AppColors.grey),
          ),
          AppSpacing.h48,
          _buildProfilePhotoSection(),
          _buildPhotosGrid(),
          AppSpacing.h32,
          Center(
            child: Text(
              "${widget.photos.length}/6 photos added",
              style: FontManager.bodySmall(color: AppColors.grey),
            ),
          ),
          AppSpacing.h24,
        ],
      ),
    );
  }

  Widget _buildProfilePhotoSection() {
    return Center(
      child: GestureDetector(
        onTap: widget.onAddPhoto,
        child: Container(
          width: 100.w,
          height: 100.w,
          margin: EdgeInsets.only(bottom: 24.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.greyD4, width: 1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: AppColors.grey, size: 30.sp),
              AppSpacing.h4,
              Text(
                "Profile",
                style: FontManager.bodySmall(
                  color: AppColors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotosGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        final isFilled = index < widget.photos.length;

        return GestureDetector(
          onTap: () {
            if (!isFilled) {
              widget.onAddPhoto();
            }
          },
          onDoubleTap: () {
            if (isFilled) {
              widget.onRemovePhoto(index);
            }
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: isFilled ? null : AppColors.surfaceVariant,
              gradient: isFilled
                  ? const LinearGradient(
                      colors: [Color(0xFF2D9CFC), Color(0xFF27AD65)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              borderRadius: BorderRadius.circular(16.r),
              border: isFilled ? null : Border.all(color: AppColors.greyD4),
            ),
            child: isFilled
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(File(widget.photos[index]), fit: BoxFit.cover),
                      Container(
                        color: Colors.black.withOpacity(0.2),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: AppColors.white,
                            size: 28.sp,
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Icon(
                      Icons.file_upload_outlined,
                      color: AppColors.grey,
                      size: 24.sp,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
