import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/community_model.dart';
import 'package:wynante/views/community/widgets/report_modal.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({super.key, required this.comment});

  void _showReportModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ReportModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16.r,
            backgroundImage: AssetImage(comment.authorImage),
            backgroundColor: AppColors.greyE8,
          ),
          AppSpacing.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comment.authorName,
                      style: FontManager.heading4(fontSize: 14),
                    ),
                    InkWell(
                      onTap: () => _showReportModal(context),
                      child: Icon(
                        Icons.more_horiz,
                        color: AppColors.grey,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),
                Text(
                  comment
                      .timeAgo, // "Christian meditation loving..." (role/tagline) - Using time for now
                  style: FontManager.bodySmall(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                AppSpacing.h4,
                Text(
                  comment.content,
                  style: FontManager.bodyMedium(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),
                ),
                AppSpacing.h8,
                Row(
                  children: [
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 14.sp,
                      color: AppColors.grey,
                    ),
                    AppSpacing.w4,
                    Text(
                      comment.likeCount.toString(),
                      style: FontManager.bodySmall(color: AppColors.grey),
                    ),
                    AppSpacing.w16,
                    Text(
                      "Reply",
                      style: FontManager.bodySmall(
                        color: AppColors.grey,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
