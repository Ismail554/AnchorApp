import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/channel_member_model.dart';

class WidgetChannelMemberTile extends StatelessWidget {
  final ChannelMember member;
  final Widget? trailing; // Button for Invite, Menu for Members
  final VoidCallback? onTap;

  const WidgetChannelMemberTile({
    super.key,
    required this.member,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(member.image),
            backgroundColor: Colors.grey.shade200,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.name, style: FontManager.heading4(fontSize: 14)),
                SizedBox(height: 4.h),
                Text(
                  member.role,
                  style: FontManager.bodySmall(
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
