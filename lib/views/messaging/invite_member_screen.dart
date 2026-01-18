import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/custom_widget/messaging_widget/widget_channel_member_tile.dart';
import 'package:wynante/custom_widget/mini_widget/widget_textfield.dart';
import 'package:wynante/models/channel_member_model.dart';

class InviteMemberScreen extends StatefulWidget {
  const InviteMemberScreen({super.key});

  @override
  State<InviteMemberScreen> createState() => _InviteMemberScreenState();
}

class _InviteMemberScreenState extends State<InviteMemberScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Mock Data
  final List<ChannelMember> _users = [
    ChannelMember(
      id: '1',
      name: 'Miles Esther',
      role: 'Ui/Ux Designer',
      image: IconAssets.profile1, // Using available asset
    ),
    ChannelMember(
      id: '2',
      name: 'Kelemen Krisztina',
      role: 'Assistant manager',
      image: IconAssets.profile2,
    ),
    ChannelMember(
      id: '3',
      name: 'Gáspár Gréta',
      role: 'Marketing director',
      image: IconAssets.profile1,
    ),
    ChannelMember(
      id: '4',
      name: 'Veres Panna',
      role: 'Production manager',
      image: IconAssets.profile2,
    ),
    ChannelMember(
      id: '5',
      name: 'Somogyi Adél',
      role: 'Vice-president',
      image: IconAssets.profile1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Invite a person',
          style: FontManager.heading3(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            WidgetTextfield(
              controller: _searchController,
              hintText: 'Search name',
              prefixIcon: Icons.search,
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return WidgetChannelMemberTile(
                    member: _users[index],
                    trailing: TextButton(
                      onPressed: () {
                        // Handle Add
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: const Color(0xFF2D9CFC),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
