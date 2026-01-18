import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/assets_manager.dart';

class AnchorAIChatScreen extends StatefulWidget {
  const AnchorAIChatScreen({super.key});

  @override
  State<AnchorAIChatScreen> createState() => _AnchorAIChatScreenState();
}

class _AnchorAIChatScreenState extends State<AnchorAIChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages =
      []; // Empty initially to show the "Hi there" screen

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.insert(0, {
        'isMe': true,
        'message': _messageController.text,
        'time': 'Now',
      });
      // Simulate AI response for demo purposes (optional, but good for "interaction")
      // For now, I'll just clear the text.
      _messageController.clear();

      // Add a mock response after a delay to simulate AI
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _messages.insert(0, {
              'isMe': false,
              'message':
                  'Hello anchor, How can i help you? \n\n.  It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in',
              'time': 'Now',
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Image.asset(IconAssets.anchorAi, width: 24.w, height: 24.w),
            SizedBox(width: 10.w),
            Text(
              'Anchor AI',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _messages.isEmpty ? _buildEmptyState() : _buildChatList(),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Hi there',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'What can I help you?',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: 250.w,
            child: Text(
              'Chat with the smartest AI Future Experience power',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
            ),
          ),
          SizedBox(height: 100.h), // Spacing from bottom
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        final isMe = message['isMe'] as bool;

        return Row(
          mainAxisAlignment: isMe
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe) ...[
              Container(
                width: 30.w,
                height: 30.w,
                margin: EdgeInsets.only(right: 8.w, bottom: 16.h),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // Using Image.asset inside validation
                  image: DecorationImage(
                    image: AssetImage(IconAssets.anchorAi),
                  ),
                ),
              ),
            ],
            Flexible(
              child: Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isMe
                      ? const Color(0xFF00A3FF)
                      : AppColors
                            .greyF4, // 0xFF00A3FF matches the blue in image
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isMe ? 20.r : 4.r),
                    topRight: Radius.circular(isMe ? 4.r : 20.r),
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                child: Text(
                  message['message'],
                  style: TextStyle(
                    color: isMe ? AppColors.white : AppColors.textPrimary,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(color: AppColors.white),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.greyF4,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          children: [
            SizedBox(width: 10.w),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type here',
                  hintStyle: TextStyle(color: AppColors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            IconButton(
              onPressed: _sendMessage,
              icon: Icon(
                Icons.send_outlined,
                color: AppColors.grey,
                size: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
