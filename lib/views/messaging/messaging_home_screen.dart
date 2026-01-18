import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/custom_widget/mini_widget/widget_textfield.dart';
import 'package:wynante/views/messaging/chat_screen.dart';
import 'package:wynante/views/messaging/anchor_ai_chat_screen.dart';
import 'package:wynante/views/messaging/channels_screen.dart';

class MessagingHomeScreen extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  const MessagingHomeScreen({super.key, this.navigatorKey});

  @override
  State<MessagingHomeScreen> createState() => _MessagingHomeScreenState();
}

class _MessagingHomeScreenState extends State<MessagingHomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _topItems = [
    {
      'name': 'Miles',
      'icon': IconAssets.profile1,
      'isAsset': true,
      'isOnline': true,
    },
    {
      'name': 'Jobs',
      'icon': IconAssets.profile2,
      'isAsset': true,
      'isOnline': false,
    },
    {
      'name': 'Likes',
      'icon': IconAssets.profile1,
      'isAsset': true,
      'isOnline': true,
    },
    {
      'name': 'Miles',
      'icon': IconAssets.profile2,
      'isAsset': true,
      'isOnline': false,
    },
  ];

  final List<Map<String, dynamic>> _chats = [
    {
      'name': 'Miles Esther',
      'message': 'Can I call you back later? I\'m in a meeting right now.',
      'time': '10:30 PM',
      'unread': 2,
      'image': IconAssets.profile1,
    },
    {
      'name': 'Thomas Shel',
      'message': 'Call m',
      'time': '10:30 PM',
      'unread': 1,
      'image': IconAssets.profile2,
    },
    {
      'name': 'Miles Esther',
      'message': 'Call m',
      'time': '10:30 PM',
      'unread': 0,
      'image': IconAssets.profile1,
    },
    {
      'name': 'Thomas Shel',
      'message': 'Call m',
      'time': '10:30 PM',
      'unread': 0,
      'image': IconAssets.profile2,
    },
    {
      'name': 'Miles Esther',
      'message': 'Call m',
      'time': '10:30 PM',
      'unread': 0,
      'image': IconAssets.profile1,
    },
    {
      'name': 'Thomas Shel',
      'message': 'Call m',
      'time': '10:30 PM',
      'unread': 0,
      'image': IconAssets.profile2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Messages', style: FontManager.titleText()),
        leading: const SizedBox(), // Removed back button
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.more_vert, color: AppColors.black),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              // Search Bar
              WidgetTextfield(
                hintText: 'Search here...',
                controller: _searchController,
                prefixIcon: Icons.search,
                elevation: 0,
              ),
              SizedBox(height: 20.h),
              // Top Horizontal List
              SizedBox(
                height: 90.h,
                child: Row(
                  children: [
                    // Fixed Items (Anchor AI & Channels)
                    _buildTopItem(
                      context,
                      item: {
                        'name': 'Anchor AI',
                        'icon': IconAssets.anchorAi,
                        'isAsset': true,
                      },
                      onTap: () {
                        if (widget.navigatorKey?.currentState != null) {
                          widget.navigatorKey!.currentState!.push(
                            MaterialPageRoute(
                              builder: (context) => const AnchorAIChatScreen(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AnchorAIChatScreen(),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(width: 16.w),
                    _buildTopItem(
                      context,
                      item: {
                        'name': 'Channels',
                        'icon': IconAssets.channel,
                        'isAsset': true,
                      },
                      onTap: () {
                        if (widget.navigatorKey?.currentState != null) {
                          widget.navigatorKey!.currentState!.push(
                            MaterialPageRoute(
                              builder: (context) => const ChannelsScreen(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChannelsScreen(),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(width: 16.w),

                    // Scrollable List
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // Filter out Anchor AI and Channels from _topItems if they are still there,
                          // OR just use a filtered list.
                          // Assuming _topItems still contains them, we should adjust.
                          // But better practice: I will update _topItems to REMOVE them and just list the users.
                          final item = _topItems[index];
                          return _buildTopItem(context, item: item);
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 16.w),
                        itemCount: _topItems.length,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h),
              Text(
                'Chats',
                style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
              ),
              SizedBox(height: 10.h),

              // Chat List
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,

                itemBuilder: (context, index) {
                  final chat = _chats[index];
                  return InkWell(
                    onTap: () {
                      if (widget.navigatorKey?.currentState != null) {
                        widget.navigatorKey!.currentState!.push(
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              name: chat['name'],
                              image: chat['image'],
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              name: chat['name'],
                              image: chat['image'],
                            ),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25.r,
                            backgroundImage: AssetImage(chat['image']),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      chat['name'],
                                      style: TextStyle(
                                        fontSize: 16.sp,

                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      chat['time'],
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        chat['message'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: chat['unread'] > 0
                                              ? AppColors.textPrimary
                                              : AppColors.textTertiary,
                                          fontWeight: chat['unread'] > 0
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (chat['unread'] > 0)
                                      Container(
                                        padding: EdgeInsets.all(6.r),
                                        decoration: const BoxDecoration(
                                          color: AppColors.primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '${chat['unread']}',
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                },
                separatorBuilder: (context, index) =>
                    Divider(color: AppColors.greyF0, thickness: 1),
                itemCount: _chats.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopItem(
    BuildContext context, {
    required Map<String, dynamic> item,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      item['name'] == 'Anchor AI' || item['name'] == 'Channels'
                      ? null
                      : Border.all(color: AppColors.primaryColor, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Image.asset(item['icon'], fit: BoxFit.cover),
                ),
              ),
              if (item.containsKey('isOnline') && item['isOnline'])
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            item['name'],
            style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
