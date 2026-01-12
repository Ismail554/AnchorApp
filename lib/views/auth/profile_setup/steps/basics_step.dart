import 'package:flutter/material.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/custom_widget/mini_widget/widget_infofield.dart';
import 'package:wynante/views/auth/profile_setup/widgets/custom_csc_picker/custom_csc_picker.dart';

class BasicsStep extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController birthdayController;
  final TextEditingController countryController;
  final TextEditingController cityController;
  final String selectedGender;
  final ValueChanged<String> onGenderChanged;
  final VoidCallback onSelectDate;

  const BasicsStep({
    super.key,
    required this.nameController,
    required this.birthdayController,
    required this.countryController,
    required this.cityController,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.h24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.h16,
          Text("Basic Information", style: FontManager.heading3(fontSize: 20)),
          AppSpacing.h8,
          Text(
            "Let's start with some basic details about you",
            style: FontManager.bodyMedium(color: AppColors.grey),
          ),
          AppSpacing.h32,
          WidgetInfoField(
            labelText: "Full Name",
            hintText: "Enter your name",
            controller: nameController,
          ),
          AppSpacing.h24,
          WidgetInfoField(
            labelText: "Date of Birth",
            hintText: "DD/MM/YYYY",
            controller: birthdayController,
            readOnly: true,
            onTap: onSelectDate,
            suffixIcon: const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.grey,
            ),
          ),
          AppSpacing.h24,
          Padding(
            padding: AppPadding.bottom8,
            child: Text(
              "Gender",
              style: FontManager.bodyMedium(
                color: AppColors.textPrimary,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            children: [
              Expanded(child: _genderChip("Male")),
              AppSpacing.w12,
              Expanded(child: _genderChip("Female")),
              AppSpacing.w12,
              Expanded(child: _genderChip("Other")),
            ],
          ),
          AppSpacing.h24,
          Padding(
            padding: AppPadding.bottom8,
            child: Text(
              "Country & City",
              style: FontManager.bodyMedium(
                color: AppColors.textPrimary,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ),

          CustomCSCPicker(
            showStates: false,
            showCities: true,
            layout: Layout.vertical,
            flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
            onCountryChanged: (value) {
              countryController.text = value;
            },
            onStateChanged: (value) {
              // optional
            },
            onCityChanged: (value) {
              cityController.text = value ?? "";
            },
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
              border: Border.all(color: AppColors.greyD4, width: 1),
            ),
            disabledDropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.greyF0,
              border: Border.all(color: AppColors.greyD4, width: 1),
            ),
            selectedItemStyle: FontManager.bodyMedium(
              color: AppColors.textPrimary,
            ),
            dropdownHeadingStyle: FontManager.heading4(
              color: AppColors.textPrimary,
            ),
            dropdownItemStyle: FontManager.bodyMedium(
              color: AppColors.textPrimary,
            ),
            searchBarRadius: 12,
          ),
          AppSpacing.h32,
        ],
      ),
    );
  }

  Widget _genderChip(String label) {
    bool isSelected = selectedGender == label;
    return GestureDetector(
      onTap: () => onGenderChanged(label),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.greyD4,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style:
              FontManager.bodyMedium(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.textSecondary,
              ).copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
        ),
      ),
    );
  }
}
