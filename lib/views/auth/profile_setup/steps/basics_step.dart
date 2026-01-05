import 'package:flutter/material.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/custom_widget/mini_widget/widget_textfield.dart';

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
          _buildLabel("Full Name"),
          WidgetTextfield(
            controller: nameController,
            hintText: "Enter your name",
          ),
          AppSpacing.h24,
          _buildLabel("Date of Birth"),
          GestureDetector(
            onTap: onSelectDate,
            child: AbsorbPointer(
              child: WidgetTextfield(
                controller: birthdayController,
                hintText: "DD/MM/YYYY",
                suffixIcon: Icons.calendar_today_outlined,
              ),
            ),
          ),
          AppSpacing.h24,
          _buildLabel("Gender"),
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
          _buildLabel("Country"),
          WidgetTextfield(
            controller: countryController,
            hintText: "Enter your country",
          ),
          AppSpacing.h24,
          _buildLabel("City"),
          WidgetTextfield(
            controller: cityController,
            hintText: "Enter your city",
          ),
          AppSpacing.h32,
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: AppPadding.bottom8,
      child: Text(
        text,
        style: FontManager.bodyMedium(
          color: AppColors.textPrimary,
        ).copyWith(fontWeight: FontWeight.w600),
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
          
          color: isSelected ? AppColors.white : AppColors.white,
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
