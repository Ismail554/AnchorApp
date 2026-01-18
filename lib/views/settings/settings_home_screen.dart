import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/custom_widget/settings/settings_tile.dart';
import 'package:wynante/views/settings/subscription_plan_screen.dart';
import 'package:wynante/views/settings/connect_calendly_screen.dart';
import 'package:wynante/views/settings/change_password_screen.dart';
import 'package:wynante/views/settings/notification_settings_screen.dart';
import 'package:wynante/views/settings/blocked_users_screen.dart';
import 'package:wynante/views/settings/legal_screen.dart';

class SettingsHomeScreen extends StatelessWidget {
  const SettingsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Off-white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preferences Section
            _buildSectionHeader('Preferences'),
            _buildSectionContainer([
              SettingsTile(
                icon: Icons.notifications_none,
                iconColor: const Color(0xFF00C853),
                iconBgColor: const Color(0xFFE8F5E9),
                title: 'Notification Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationSettingsScreen(),
                    ),
                  );
                },
              ),
              SettingsTile(
                icon: Icons.calendar_today_outlined,
                iconColor: const Color(0xFFFF6D00),
                iconBgColor: const Color(0xFFFFF3E0),
                title: 'Connect Calendly',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConnectCalendlyScreen(),
                    ),
                  );
                },
              ),
            ]),
            SizedBox(height: 24.h),
            // Account Section
            _buildSectionHeader('Account'),
            _buildSectionContainer([
              SettingsTile(
                icon: Icons.credit_card,
                iconColor: const Color(0xFF448AFF),
                iconBgColor: const Color(0xFFE3F2FD),
                title: 'Subscription Plan',
                trailingText: 'Free',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubscriptionPlanScreen(),
                    ),
                  );
                },
              ),
              // SettingsTile(
              //   icon: Icons.email_outlined,
              //   iconColor: const Color(0xFF448AFF),
              //   iconBgColor: const Color(0xFFE3F2FD),
              //   title: 'Change Email',
              //   onTap: () {},
              // ),
              SettingsTile(
                icon: Icons.lock_outline,
                iconColor: const Color(0xFF9C27B0),
                iconBgColor: const Color(0xFFF3E5F5),
                title: 'Change Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                },
              ),
            ]),
            SizedBox(height: 24.h),

            // Privacy & Security Section
            _buildSectionHeader('Privacy & Security'),
            _buildSectionContainer([
              SettingsTile(
                icon: Icons.person_off_outlined,
                iconColor: const Color(0xFFFF5252),
                iconBgColor: const Color(0xFFFFEBEE),
                title: 'Blocked Users',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BlockedUsersScreen(),
                    ),
                  );
                },
              ),
              SettingsTile(
                icon: Icons.verified_user_outlined,
                iconColor: const Color(0xFF536DFE),
                iconBgColor: const Color(0xFFE8EAF6),
                title: 'Privacy Policy',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const LegalScreen(title: 'Privacy Policy'),
                    ),
                  );
                },
              ),
              SettingsTile(
                icon: Icons.shield_outlined,
                iconColor: const Color(0xFF536DFE),
                iconBgColor: const Color(0xFFE8EAF6),
                title: 'Terms & Conditions',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const LegalScreen(title: 'Terms & Conditions'),
                    ),
                  );
                },
              ),
            ]),
            SizedBox(height: 24.h),

            // Danger Zone Section
            _buildSectionHeader('Danger Zone', color: const Color(0xFFFF5252)),
            _buildSectionContainer([
              SettingsTile(
                icon: Icons.delete_outline,
                iconColor: const Color(0xFFFF5252),
                iconBgColor: const Color(0xFFFFEBEE),
                title: 'Delete Account',
                isDestructive: true,
                onTap: () => _showDeleteAccountDialog(context),
              ),
              SettingsTile(
                icon: Icons.folder_delete_outlined,
                iconColor: const Color(0xFFFF5252),
                iconBgColor: const Color(0xFFFFEBEE),
                title: 'Delete All data',
                isDestructive: true,
                onTap: () =>
                    _showDeleteAccountDialog(context, isDataOnly: true),
              ),
              SettingsTile(
                icon: Icons.logout,
                iconColor: const Color(0xFFFF5252),
                iconBgColor: const Color(0xFFFFEBEE),
                title: 'Log Out',
                isDestructive: true,
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ]),
            SizedBox(height: 12.h),

            // Version Info
            Center(
              child: Text(
                'AnchorUp v1.0.0',
                style: TextStyle(
                  color: AppColors.textSecondary.withOpacity(0.5),
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {Color? color}) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, bottom: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: color ?? AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildSectionContainer(List<Widget> children) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Column(children: children),
      ),
    );
  }

  void _showDeleteAccountDialog(
    BuildContext context, {
    bool isDataOnly = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isDataOnly ? 'Delete All Data' : 'Delete Account'),
          content: Text(
            isDataOnly
                ? 'Are you sure you want to delete all your data? This action cannot be undone.'
                : 'Are you sure you want to delete your account? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement actual deletion logic
                Navigator.pop(context);
                // navigate back to login or initial screen
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
