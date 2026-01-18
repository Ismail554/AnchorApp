import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/models/channel_message_model.dart';
import 'package:wynante/core/assets_manager.dart';

class ChannelScreen extends StatefulWidget {
  final String channelName;
  final String channelImage;
  final int subscriberCount;

  const ChannelScreen({
    super.key,
    required this.channelName,
    required this.channelImage,
    required this.subscriberCount,
  });

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  final TextEditingController _messageController = TextEditingController();

  // Mock data
  final List<ChannelMessage> _messages = [
    ChannelMessage(
      id: '1',
      senderName: 'John Doe',
      senderImage: IconAssets.profile1,
      time: '10:30 PM',
      title: 'Mental health and status check',
      content:
          'How do you create compelling presentations that wow your colleagues and impress your managers?',
      image: ImageAssets.discoverImg1,
      likeCount: 520,
      isLiked: true,
      type: ChannelMessageType.post,
    ),
    ChannelMessage(
      id: '2',
      senderName: 'Jane Smith',
      senderImage: IconAssets.profile2,
      time: '10:35 PM',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      likeCount: 142,
      isLiked: false,
      type: ChannelMessageType.text,
    ),
    ChannelMessage(
      id: '3',
      senderName: 'John Doe',
      senderImage: IconAssets.profile1,
      time: '10:40 PM',
      title: 'Quick poll',
      content: 'What is your favorite way to relax after work?',
      likeCount: 89,
      isLiked: false,
      type: ChannelMessageType.post,
    ),
  ];

  void _toggleLike(int index) {
    setState(() {
      final msg = _messages[index];
      msg.isLiked = !msg.isLiked;
      msg.likeCount += msg.isLiked ? 1 : -1;
    });
  }

  void _showDeleteChannelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text('Delete Channel?'),
        content: const Text(
          'This action cannot be undone. All messages and members will be removed.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              // TODO: real delete logic (API call, etc.)
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundImage: AssetImage(widget.channelImage),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.channelName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${widget.subscriberCount} subscribers',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteChannelDialog();
              }
              // TODO: handle 'edit', 'invite', 'members'
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: _MenuItem(icon: Icons.edit, label: 'Edit'),
              ),
              PopupMenuItem(
                value: 'delete',
                child: _MenuItem(
                  icon: Icons.delete_outline,
                  label: 'Delete',
                  color: Colors.red,
                ),
              ),
              PopupMenuItem(
                value: 'invite',
                child: _MenuItem(icon: Icons.person_add, label: 'Invite'),
              ),
              PopupMenuItem(
                value: 'members',
                child: _MenuItem(icon: Icons.group, label: 'Members'),
              ),
            ],
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                itemCount: _messages.length + 1, // +1 for date separator
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildDateSeparator("Wednesday, 20 November 2025");
                  }

                  final msgIndex = index - 1;
                  return MessageBubble(
                    message: _messages[msgIndex],
                    onLikeToggle: () => _toggleLike(msgIndex),
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSeparator(String dateText) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade300.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            dateText,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              constraints: BoxConstraints(minHeight: 46.h, maxHeight: 120.h),
              decoration: BoxDecoration(
                color: AppColors.greyF4 ?? Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: TextField(
                controller: _messageController,
                minLines: 1,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(fontSize: 15.sp),
                decoration: InputDecoration(
                  hintText: 'Message...',
                  hintStyle: TextStyle(color: AppColors.grey, fontSize: 15.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {
              final text = _messageController.text.trim();
              if (text.isNotEmpty) {
                // TODO: Add real message sending logic here
                // For now just clear
                _messageController.clear();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Message sent: $text')));
              }
            },
            child: CircleAvatar(
              radius: 22.r,
              backgroundColor: AppColors.primaryColor,
              child: Icon(Icons.send_rounded, color: Colors.white, size: 22.sp),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────
// Helper menu item widget
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _MenuItem({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: color ?? AppColors.textPrimary),
        SizedBox(width: 12.w),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }
}

// ──────────────────────────────────────────────
// Message bubble widget
class MessageBubble extends StatelessWidget {
  final ChannelMessage message;
  final VoidCallback onLikeToggle;

  const MessageBubble({
    super.key,
    required this.message,
    required this.onLikeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isPost = message.type == ChannelMessageType.post;
    final primary = AppColors.primaryColor;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundImage: AssetImage(message.senderImage),
            backgroundColor: Colors.grey.shade300,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sender name + time
                Row(
                  children: [
                    Text(
                      message.senderName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      message.time,
                      style: TextStyle(fontSize: 11.sp, color: AppColors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),

                // Content container
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isPost && message.image != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            message.image!,
                            height: 180.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                      if (isPost && message.title != null) ...[
                        Text(
                          message.title!,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: 6.h),
                      ],
                      Text(
                        message.content,
                        style: TextStyle(
                          fontSize: 14.5.sp,
                          height: 1.38,
                          color: AppColors.textSecondary ?? Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 6.h),

                // Like row
                GestureDetector(
                  onTap: onLikeToggle,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        message.isLiked
                            ? Icons.thumb_up
                            : Icons.thumb_up_outlined,
                        size: 18.sp,
                        color: message.isLiked ? primary : AppColors.grey,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        message.isLiked ? 'Liked' : 'Like',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: message.isLiked ? primary : AppColors.grey,
                          fontWeight: message.isLiked ? FontWeight.w500 : null,
                        ),
                      ),
                      if (message.likeCount > 0) ...[
                        SizedBox(width: 6.w),
                        Text(
                          '${message.likeCount}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
