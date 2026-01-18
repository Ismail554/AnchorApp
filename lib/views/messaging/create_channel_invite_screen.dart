import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/models/channel_member_model.dart';
import 'package:wynante/views/messaging/channel_chat_screen.dart'; // To navigate after success

class CreateChannelInviteScreen extends StatefulWidget {
  final String channelName;
  final String category;

  const CreateChannelInviteScreen({
    super.key,
    required this.channelName,
    required this.category,
  });

  @override
  State<CreateChannelInviteScreen> createState() =>
      _CreateChannelInviteScreenState();
}

class _CreateChannelInviteScreenState extends State<CreateChannelInviteScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Mock Users
  final List<ChannelMember> _allUsers = [
    ChannelMember(
      id: '1',
      name: 'Sarah Johnson',
      role: 'Ui/Ux Designer',
      image: IconAssets.profile1,
    ),
    ChannelMember(
      id: '2',
      name: 'Michael Chen',
      role: 'Product Manager',
      image: IconAssets.profile2,
    ),
    ChannelMember(
      id: '3',
      name: 'Emily Rodriguez',
      role: 'Developer',
      image: IconAssets.profile1, // Placeholder
    ),
  ];

  final Set<String> _selectedIds = {};

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // Auto-close after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pop(context); // Close dialog
            // Navigate to the new channel (Replacing the flow)
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ChannelScreen(
                  channelName: widget.channelName.isNotEmpty
                      ? widget.channelName
                      : 'New Channel', // Fallback
                  channelImage: ImageAssets.discoverImg1, // Default image
                  subscriberCount: _selectedIds.length + 1, // +1 for owner
                ),
              ),
              (route) => route.isFirst, // Keep home/bottom nav stack
            );
          }
        });

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          backgroundColor: const Color(0xFFE0F9E8), // Light green bg
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 24.sp),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Channel Created Successfully',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedMembers = _allUsers
        .where((u) => _selectedIds.contains(u.id))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Channel',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Step 2 of 2',
              style: TextStyle(color: AppColors.grey, fontSize: 12.sp),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invite Members',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Add members to your channel (you can skip this)',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                ),
                SizedBox(height: 16.h),

                // Selected pills
                if (selectedMembers.isNotEmpty) ...[
                  Text(
                    '${selectedMembers.length} selected',
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 40.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedMembers.length,
                      separatorBuilder: (_, __) => SizedBox(width: 8.w),
                      itemBuilder: (context, index) {
                        final member = selectedMembers[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF6FF),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 10.r,
                                backgroundImage: AssetImage(member.image),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                member.name,
                                style: TextStyle(
                                  color: const Color(0xFF2D9CFC),
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              GestureDetector(
                                onTap: () => _toggleSelection(member.id),
                                child: Icon(
                                  Icons.close,
                                  size: 16.sp,
                                  color: const Color(0xFF2D9CFC),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],

                Text(
                  'Suggested from your connections',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // User List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: _allUsers.length,
              itemBuilder: (context, index) {
                final user = _allUsers[index];
                final isSelected = _selectedIds.contains(user.id);

                return GestureDetector(
                  onTap: () => _toggleSelection(user.id),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFEAF6FF)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2D9CFC)
                            : Colors.transparent,
                      ),
                      boxShadow: [
                        if (!isSelected)
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
                          backgroundImage: AssetImage(user.image),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            user.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? const Color(0xFF2D9CFC)
                                : Colors.transparent,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2D9CFC)
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check,
                                  size: 14.sp,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Buttons
          Container(
            padding: EdgeInsets.all(20.w),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _showSuccessDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D9CFC),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Create Channel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _showSuccessDialog, // Same ending logic
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF27AE60,
                      ), // Green for Skip
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Skip & Create',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
