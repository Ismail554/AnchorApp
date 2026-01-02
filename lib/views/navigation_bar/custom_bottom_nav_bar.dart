import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_strings.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/font_manager.dart';

/// Custom Bottom Navigation Bar matching Figma design
/// Uses SVG icons with filled (selected) and unfilled (unselected) states
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 70.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                svgPath: SvgAssets.homeNav,
                label: AppStrings.home,
                index: 0,
                isSelected: currentIndex == 0,
              ),
              _buildNavItem(
                svgPath: SvgAssets.matchesNav,
                label: AppStrings.matches,
                index: 1,
                isSelected: currentIndex == 1,
              ),
              _buildNavItem(
                svgPath: SvgAssets.messageNav,
                label: AppStrings.message,
                index: 2,
                isSelected: currentIndex == 2,
              ),
              _buildNavItem(
                svgPath: SvgAssets.communityNav,
                label: AppStrings.community,
                index: 3,
                isSelected: currentIndex == 3,
              ),
              _buildNavItem(
                svgPath: SvgAssets.profileNav,
                label: AppStrings.profile,
                index: 4,
                isSelected: currentIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String svgPath,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    // Blue for selected, grey for unselected (matching Figma)
    final color = isSelected ? AppColors.primaryColor : AppColors.grey;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // SVG Icon with color filter for filled/unfilled states
            _buildSvgIcon(
              svgPath: svgPath,
              color: color,
              isSelected: isSelected,
            ),
            SizedBox(height: 4.h),
            // Label
            Text(
              label,
              style: FontManager.labelSmall(
                fontSize: 12,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Build SVG icon with proper color filtering for filled/unfilled states
  Widget _buildSvgIcon({
    required String svgPath,
    required Color color,
    required bool isSelected,
  }) {
    return SvgPicture.asset(
      svgPath,
      width: 24.w,
      height: 24.h,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
      // For filled state, we can optionally make the stroke thicker
      // by using a custom painter, but colorFilter works well for now
    );
  }
}
