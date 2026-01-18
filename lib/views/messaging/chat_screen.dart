import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/models/chat_message_model.dart';
import 'package:wynante/models/disconnect_reason_model.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String image;

  const ChatScreen({super.key, required this.name, required this.image});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      isMe: true,
      message: 'can you please tell me about this?',
      time: '10:30 PM',
    ),
    ChatMessage(
      isMe: false,
      message:
          'This interaction with Anchor is representative. In fact, if you ask the anchor for the weather, for example, it will immediately generate a summary of the current weather forecast.',
      time: '10:31 PM',
    ),
    ChatMessage(
      isMe: true,
      message: 'wow amazing thanks a lot',
      time: '10:32 PM',
    ),
    ChatMessage(
      isMe: true,
      message: 'You are welcome, happy to help you',
      time: '10:32 PM',
    ),
  ].reversed.toList();

  final ImagePicker _picker = ImagePicker();

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          isMe: true,
          message: _messageController.text,
          time: TimeOfDay.now().format(context),
        ),
      );
      _messageController.clear();
    });
  }

  Future<void> _pickImage() async {
    try {
      debugPrint("Attempting to pick image...");
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        debugPrint("Image picked successfully: ${image.path}");
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              isMe: true,
              type: 'image',
              path: image.path,
              time: TimeOfDay.now().format(context),
            ),
          );
        });
      } else {
        debugPrint("Image selection cancelled");
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
      }
    }
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
            CircleAvatar(
              backgroundImage: AssetImage(widget.image),
              radius: 18.r,
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(color: AppColors.black, fontSize: 16.sp),
                ),
                Text(
                  'Online',
                  style: TextStyle(color: AppColors.green, fontSize: 12.sp),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.videocam_outlined, color: AppColors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.call_outlined, color: AppColors.black),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: AppColors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            onSelected: (value) {
              if (value == 'disconnect') {
                _showDisconnectBottomSheet(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'block',
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_circle_up_outlined,
                      color: AppColors.textPrimary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Block',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'disconnect',
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app_outlined,
                      color: AppColors.textPrimary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Disconnect',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'report',
                child: Row(
                  children: [
                    Icon(
                      Icons.report_gmailerrorred_outlined,
                      color: AppColors.textPrimary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Report',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isMe = message.isMe;
                  final isImage = message.type == 'image';
                  final time = message.time;

                  return Align(
                    alignment: isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      constraints: BoxConstraints(maxWidth: 0.75.sw),
                      decoration: BoxDecoration(
                        color: isMe ? AppColors.primaryColor : AppColors.greyF4,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.r),
                          topRight: Radius.circular(18.r),
                          bottomLeft: isMe
                              ? Radius.circular(18.r)
                              : Radius.circular(0),
                          bottomRight: isMe
                              ? Radius.circular(0)
                              : Radius.circular(12.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isImage
                              ? ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.r),
                                    topRight: Radius.circular(10.r),
                                    bottomLeft: isMe
                                        ? Radius.circular(10.r)
                                        : Radius.zero,
                                    bottomRight: isMe
                                        ? Radius.zero
                                        : Radius.circular(10.r),
                                  ),
                                  child: Image.file(
                                    File(message.path!),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                    left: 16.w,
                                    right: 16.w,
                                    top: 12.h,
                                    bottom: 4.h,
                                  ),
                                  child: Text(
                                    message.message ?? '',
                                    style: TextStyle(
                                      color: isMe
                                          ? AppColors.white
                                          : AppColors.textPrimary,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 16.w,
                              right: 16.w,
                              bottom: 8.h,
                              top: isImage ? 8.h : 0,
                            ),
                            child: Text(
                              time,
                              style: TextStyle(
                                color: isMe
                                    ? AppColors.white.withOpacity(0.7)
                                    : AppColors.grey,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Input Area
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.greyF4,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.attach_file,
                        color: AppColors.grey,
                        size: 24.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.greyF4,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: AppColors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: _sendMessage,
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.greyF4,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        color: AppColors.grey,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDisconnectBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        // Track selected options using a unique key "$category-$option"
        final Set<String> selectedOptions = {};

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSheetState) {
            Widget buildCategory(DisconnectCategory category) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    Text(
                      category.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ...category.options.map((option) {
                      final String uniqueKey = '${category.title}-$option';
                      final bool isSelected = selectedOptions.contains(
                        uniqueKey,
                      );
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: InkWell(
                          onTap: () {
                            setSheetState(() {
                              if (isSelected) {
                                selectedOptions.remove(uniqueKey);
                              } else {
                                selectedOptions.add(uniqueKey);
                              }
                            });
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: Checkbox(
                                  value: isSelected,
                                  onChanged: (val) {
                                    setSheetState(() {
                                      if (val == true) {
                                        selectedOptions.add(uniqueKey);
                                      } else {
                                        selectedOptions.remove(uniqueKey);
                                      }
                                    });
                                  },
                                  activeColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  side: BorderSide(color: AppColors.grey),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                option,
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            }

            return Container(
              height: 0.85.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  // SizedBox(height: 16.h),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 18.sp),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          'Disconnection',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w), // Balance the back button
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 8.h,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Describe the reason\nit will help us to get good connection',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...DisconnectData.categories.map(buildCategory),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                debugPrint(
                                  'Disconnecting with reasons: $selectedOptions',
                                );
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                elevation: 0,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                              ),
                              child: Text(
                                'Disconnect',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
