import 'package:flutter/material.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/font_manager.dart';

class ProfileDropdownField extends StatelessWidget {
  final String title;
  final String? value;
  final VoidCallback onTap;
  final String? hintText;

  const ProfileDropdownField({
    super.key,
    required this.title,
    this.value,
    required this.onTap,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppPadding.bottom8,
          child: Text(
            title,
            style: FontManager.bodyMedium(
              color: AppColors.textPrimary,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.greyD4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    (value != null && value!.isNotEmpty)
                        ? value!
                        : (hintText ?? "Select"),
                    style: FontManager.bodyMedium(
                      color: (value != null && value!.isNotEmpty)
                          ? AppColors.textPrimary
                          : AppColors.grey4B,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.grey,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
