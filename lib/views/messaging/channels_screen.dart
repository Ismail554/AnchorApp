import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/custom_widget/home_widget/widget_conn_tile.dart';
import 'package:wynante/custom_widget/mini_widget/widget_textfield.dart';
import 'package:wynante/models/your_connection_model.dart';

import 'package:wynante/views/messaging/channel_chat_screen.dart';

class ChannelsScreen extends StatefulWidget {
  const ChannelsScreen({super.key});

  @override
  State<ChannelsScreen> createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<YourConnectionModel> _channels = [
    YourConnectionModel(
      name: "Name of the channel",
      pic:
          "assets/images/frame1.png", // Using frame images as they look like logos in assets
      date: "",
      status: "",
      connectionType: "",
      activity: "Spiritual",
      subscriberCount: 1000,
    ),
    YourConnectionModel(
      name: "Name of the channel",
      pic: "assets/images/frame2.png",
      date: "",
      status: "",
      connectionType: "",
      activity: "Professional",
      subscriberCount: 1000,
    ),
    YourConnectionModel(
      name: "Name of the channel",
      pic: "assets/images/frame3.png",
      date: "",
      status: "",
      connectionType: "",
      activity: "Social",
      subscriberCount: 1000,
    ),
    YourConnectionModel(
      name: "Name of the channel",
      pic: "assets/images/frame4.png",
      date: "",
      status: "",
      connectionType: "",
      activity: "Romantic",
      subscriberCount: 1000,
    ),
    YourConnectionModel(
      name: "Name of the channel",
      pic: "assets/images/frame1.png",
      date: "",
      status: "",
      connectionType: "",
      activity: "Spiritual",
      subscriberCount: 1000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              IconAssets.channel,
              width: 46.w,
              height: 46.w,
            ), // Assuming IconAssets.channel exists from messaging home screen code
            SizedBox(width: 8.w),
            Text(
              'Channels',
              style: TextStyle(color: AppColors.black, fontSize: 18.sp),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            WidgetTextfield(
              hintText: 'Search name',
              controller: _searchController,
              prefixIcon: Icons.search,
              elevation: 0,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'List of channels',
                  style: FontManager.heading4(fontSize: 16),
                ),
                Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.add,
                    color: const Color(0xFF2D9CFC),
                    size: 24.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.separated(
                itemCount: _channels.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  return WidgetConnTile(
                    connection: _channels[index],
                    isChannel: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChannelScreen(
                            channelName: _channels[index].name,
                            channelImage: _channels[index].pic,
                            subscriberCount:
                                _channels[index].subscriberCount ?? 0,
                          ),
                        ),
                      );
                    },
                    topRightWidget: PopupMenuButton<String>(
                      icon: Icon(Icons.more_horiz, color: AppColors.grey),
                      onSelected: (value) {
                        if (value == 'leave') {
                          // Handle leave group
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'leave',
                          child: Row(
                            children: [
                              Icon(
                                Icons.exit_to_app,
                                color: Colors.red,
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Leave Group',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
