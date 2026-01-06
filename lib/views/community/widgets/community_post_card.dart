import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/community_model.dart';
import 'package:wynante/views/community/post_detail_screen.dart';

class CommunityPostCard extends StatelessWidget {
  final CommunityPost post;

  const CommunityPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostDetailScreen(post: post)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
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
            // Author Row
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: AssetImage(
                    post.authorImage.isNotEmpty
                        ? post.authorImage
                        : 'assets/images/placeholder.png',
                  ),
                  backgroundColor: AppColors.greyE8,
                ),
                AppSpacing.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: FontManager.heading4(fontSize: 14),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(
                                post.category,
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              post.category,
                              style: FontManager.bodySmall(
                                color: _getCategoryColor(post.category),
                                fontSize: 10,
                              ).copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          AppSpacing.w8,
                          Text(
                            "• ${post.timeAgo}",
                            style: FontManager.bodySmall(color: AppColors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.more_vert, color: AppColors.grey, size: 20.sp),
              ],
            ),
            AppSpacing.h12,

            // Content
            if (post.imageAsset != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  post.imageAsset!,
                  width: double.infinity,
                  height: 180.h,
                  fit: BoxFit.cover,
                ),
              ),
              AppSpacing.h12,
            ],

            Text(
              post.title,
              style: FontManager.heading4(fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            AppSpacing.h8,
            Text(
              post.content,
              style: FontManager.bodyMedium(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            AppSpacing.h8,
            Text(
              "Read more",
              style: FontManager.bodySmall(
                color: AppColors.primaryColor,
                fontSize: 12,
              ),
            ),
            AppSpacing.h16,

            // Actions
            Row(
              children: [
                _buildAction(
                  icon: post.isLiked
                      ? Icons.thumb_up_alt
                      : Icons.thumb_up_alt_outlined,
                  color: post.isLiked
                      ? AppColors.primaryColor
                      : AppColors.cardBbg,
                  count: post.likeCount,
                  onTap: () {},
                ),
                AppSpacing.w24,
                _buildAction(
                  icon: Icons.chat_bubble_outline,
                  color: AppColors.cardBbg,
                  count: post.commentCount,
                  onTap: () {},
                ),
                const Spacer(),
                Icon(Icons.share_outlined, color: AppColors.grey, size: 20.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction({
    required IconData icon,
    required Color color,
    required int count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: color),
          AppSpacing.w6,
          Text(
            count.toString(),
            style: FontManager.bodyMedium(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'spiritual':
        return Colors.purple;
      case 'career':
      case 'professional':
        return Colors.green;
      case 'romantic':
        return Colors.pink;
      case 'social':
        return Colors.blue;
      default:
        return AppColors.primaryColor;
    }
  }
}
