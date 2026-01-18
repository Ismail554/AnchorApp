import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/custom_widget/messaging_widget/widget_channel_member_tile.dart';
import 'package:wynante/custom_widget/mini_widget/widget_textfield.dart';
import 'package:wynante/models/channel_member_model.dart';

class ChannelMembersScreen extends StatefulWidget {
  const ChannelMembersScreen({super.key});

  @override
  State<ChannelMembersScreen> createState() => _ChannelMembersScreenState();
}

class _ChannelMembersScreenState extends State<ChannelMembersScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Mock Data
  final List<ChannelMember> _members = [
    ChannelMember(
      id: '1',
      name: 'Miles Esther',
      role: 'Ui/Ux Designer',
      image: IconAssets.profile1,
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
    ChannelMember(
      id: '6',
      name: 'Török Melinda',
      role: 'Marketing manager',
      image: IconAssets.profile2,
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
        title: Text('Member list', style: FontManager.heading3(fontSize: 18)),
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
                itemCount: _members.length,
                itemBuilder: (context, index) {
                  return WidgetChannelMemberTile(
                    member: _members[index],
                    trailing: PopupMenuButton<String>(
                      icon: Icon(Icons.more_horiz, color: AppColors.grey),
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      onSelected: (value) {
                        // Handle actions
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'remove',
                          child: _MemberMenuItem(
                            icon: Icons.remove_circle_outline,
                            label: 'Remove from group',
                          ),
                        ),
                        PopupMenuItem(
                          value: 'block',
                          child: _MemberMenuItem(
                            icon: Icons.block,
                            label: 'Block the person',
                          ),
                        ),
                        PopupMenuItem(
                          value: 'disconnect',
                          child: _MemberMenuItem(
                            icon: Icons.link_off,
                            label: 'Disconnect',
                          ),
                        ),
                        PopupMenuItem(
                          value: 'view',
                          child: _MemberMenuItem(
                            icon: Icons.remove_red_eye_outlined,
                            label: 'View profile',
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

class _MemberMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MemberMenuItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: AppColors.textPrimary),
        SizedBox(width: 12.w),
        Text(label, style: TextStyle(fontSize: 14.sp)),
      ],
    );
  }
}
