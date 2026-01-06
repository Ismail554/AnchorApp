import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/your_connection_model.dart';
import 'package:wynante/views/home/profile_view_screen.dart';

class WidgetConnTile extends StatelessWidget {
  final YourConnectionModel connection;

  const WidgetConnTile({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileViewScreen(connection: connection),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: AppPadding.r12,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Pic with Status
            Stack(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: connection.pic.isNotEmpty
                          ? AssetImage(connection.pic)
                          : const AssetImage("assets/images/human.png")
                                as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                    color: AppColors.greyE8,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: _getStatusColor(connection.status),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.w12,
            // Connection Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    connection.name,
                    style: FontManager.heading4(fontSize: 14),
                  ),
                  Text(
                    connection.date,
                    style: FontManager.bodySmall(
                      color: AppColors.grey,
                      fontSize: 10,
                    ),
                  ),
                  AppSpacing.h8,
                  Row(
                    children: [
                      Image.asset(
                        _getConnectionTypeIcon(connection.connectionType),
                        width: 16.w,
                        height: 16.w,
                      ),
                      AppSpacing.w8,
                      Icon(
                        _getActivityIcon(connection.activity),
                        size: 14.sp,
                        color: _getActivityColor(connection.activity),
                      ),
                      AppSpacing.w4,
                      Text(
                        connection.activity,
                        style: FontManager.bodySmall(
                          color: AppColors.textPrimary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Actions
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Invite Button
                  SvgPicture.asset(SvgAssets.invite, height: 20.h),

                  AppSpacing.h26,
                  // Message Button
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        SvgAssets.chat,
                        width: 16.w,
                        height: 16.h,
                        color: const Color(0xFF2D9CFC),
                      ),
                      AppSpacing.w4,

                      Text(
                        "Message",
                        style: FontManager.bodySmall(
                          color: const Color(0xFF2D9CFC),
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
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'online':
        return Colors.green;
      case 'away':
        return Colors.orange;
      case 'busy':
        return Colors.red;
      case 'offline':
      default:
        return Colors.grey;
    }
  }

  String _getConnectionTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'high':
        return IconAssets.high;
      case 'medium':
        return IconAssets.medium;
      case 'low':
      default:
        return IconAssets.low;
    }
  }

  IconData _getActivityIcon(String activity) {
    switch (activity.toLowerCase()) {
      case 'romantic':
        return Icons.favorite_border;
      case 'social':
        return Icons.people_outline;
      case 'professional':
        return Icons.work_outline;
      case 'spiritual':
        return Icons.spa_outlined;
      default:
        return Icons.circle_outlined;
    }
  }

  Color _getActivityColor(String activity) {
    switch (activity.toLowerCase()) {
      case 'romantic':
        return Colors.pink;
      case 'social':
        return Colors.blue;
      case 'professional':
        return Colors.green;
      case 'spiritual':
        return Colors.purple;
      default:
        return AppColors.grey;
    }
  }
}
