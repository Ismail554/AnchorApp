import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/models/user_profile_model.dart';
import 'package:wynante/services/profile_service.dart';
import 'package:wynante/views/profile/edit_profile_screen.dart';
import 'package:wynante/views/profile/widgets/profile_completeness_card.dart';
import 'package:wynante/views/profile/widgets/profile_gallery.dart';
import 'package:wynante/views/profile/widgets/profile_header.dart';
import 'package:wynante/views/profile/widgets/profile_info_section.dart';
import 'package:wynante/views/profile/widgets/profile_stats_row.dart';
import 'package:wynante/views/settings/settings_home_screen.dart';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({super.key});

  @override
  State<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  final ProfileService _profileService = ProfileService();
  late Future<UserProfile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _profileService.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light background
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Container(
          margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            title: const Text(
              "Profile",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.grey),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsHomeScreen(),
                    ),
                  );
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
      body: FutureBuilder<UserProfile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No profile data found"));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            padding: AppPadding.r20,
            child: Column(
              children: [
                ProfileHeader(
                  user: user,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                          initialInterests: user.interests,
                          initialLanguages: user.languages,
                          initialLookingFor: [user.lookingFor],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 24.h),
                ProfileCompletenessCard(percentage: user.completionPercentage),
                SizedBox(height: 24.h),
                ProfileStatsRow(user: user),
                SizedBox(height: 24.h),
                ProfileGallery(images: user.galleryImages, onEdit: () {}),
                SizedBox(height: 24.h),
                ProfileInfoSection(
                  title: "Connection Types",
                  onEdit: () {},
                  content: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: user.connectionTypes.map((type) {
                      return _buildTagChip(type, _getColorForType(type));
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.h),
                ProfileInfoSection(
                  title: "About Me",
                  onEdit: () {},
                  content: Text(
                    user.aboutMe,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                ProfileInfoSection(
                  title: "Interests",
                  onEdit: () {},
                  content: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: user.interests.map((interest) {
                      return _buildTagChip(interest, Colors.grey[200]!);
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.h),
                ProfileInfoSection(
                  title: "Languages",
                  onEdit: () {},
                  content: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: user.languages.map((language) {
                      return _buildTagChip(
                        language,
                        Colors.blue[50]!,
                        textColor: Colors.blue,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.h),
                ProfileInfoSection(
                  title: "Basic Information",
                  onEdit: () {},
                  content: Column(
                    children: [
                      _buildInfoRow("Gender", user.gender),
                      _buildInfoRow("Height", user.height),
                      _buildInfoRow("Education", user.education),
                      _buildInfoRow("Occupation", user.occupation),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                ProfileInfoSection(
                  title: "Looking For",
                  onEdit: () {},
                  content: Text(
                    user.lookingFor,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 40.h), // Bottom padding
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTagChip(
    String label,
    Color color, {
    Color textColor = Colors.black87,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Color _getColorForType(String type) {
    switch (type) {
      case "Social":
        return Colors.blue[50]!;
      case "Romantic":
        return Colors.red[50]!;
      case "Spiritual":
        return Colors.purple[50]!;
      case "Professional":
        return Colors.green[50]!;
      default:
        return Colors.grey[200]!;
    }
  }
}
