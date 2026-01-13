import 'package:flutter/material.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/profile/widgets/editable_tags_section.dart';
import 'package:wynante/views/profile/widgets/profile_dropdown_field.dart';

class EditProfileScreen extends StatefulWidget {
  final List<String> initialInterests;
  final List<String> initialLanguages;
  final List<String> initialLookingFor;

  const EditProfileScreen({
    super.key,
    this.initialInterests = const [],
    this.initialLanguages = const [],
    this.initialLookingFor = const [],
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // State variables for dropdown values
  String? _selectedEducation;
  String? _selectedSmoking;
  String? _selectedDrinking;
  String? _selectedFamilyType;
  String? _selectedFamilyOrigin;
  String? _selectedReligion;
  String? _selectedEthnicity;
  String? _selectedExperience;
  String? _selectedServiceType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Profile Completion',
          style: FontManager.heading3(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.r24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "My information ",
                style: FontManager.heading3(fontSize: 18),
                children: [
                  TextSpan(
                    text: "(28 y/o)",
                    style: FontManager.bodyMedium(
                      color: AppColors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.h24,

            // Dropdown Fields
            ProfileDropdownField(
              title: "Educational Level",
              value: _selectedEducation,
              onTap: () => _showSelectionSheet(
                context,
                "Educational Level",
                ["High School", "Undergraduate Degree", "Postgraduate", "PhD"],
                (val) => setState(() => _selectedEducation = val),
              ),
            ),
            ProfileDropdownField(
              title: "Do You Smoke?",
              value: _selectedSmoking,
              onTap: () => _showSelectionSheet(
                context,
                "Do You Smoke?",
                ["Yes", "No", "Occasionally"],
                (val) => setState(() => _selectedSmoking = val),
              ),
            ),
            ProfileDropdownField(
              title: "Do You Drink?",
              value: _selectedDrinking,
              onTap: () => _showSelectionSheet(
                context,
                "Do You Drink?",
                ["Yes", "No", "Occasionally"],
                (val) => setState(() => _selectedDrinking = val),
              ),
            ),
            ProfileDropdownField(
              title: "Family Type",
              value: _selectedFamilyType,
              onTap: () => _showSelectionSheet(
                context,
                "Family Type",
                ["Nuclear", "Joint", "Extended"],
                (val) => setState(() => _selectedFamilyType = val),
              ),
            ),
            ProfileDropdownField(
              title: "Family Origin",
              value: _selectedFamilyOrigin,
              onTap: () => _showSelectionSheet(
                context,
                "Family Origin",
                ["BD and IND", "Pakistan", "Middle East", "Other"],
                (val) => setState(() => _selectedFamilyOrigin = val),
              ),
            ),
            ProfileDropdownField(
              title: "Religion",
              value: _selectedReligion,
              onTap: () => _showSelectionSheet(context, "Religion", [
                "Muslim",
                "Hindu",
                "Christian",
                "Buddhist",
                "Other",
              ], (val) => setState(() => _selectedReligion = val)),
            ),
            ProfileDropdownField(
              title: "Ethnicity",
              value: _selectedEthnicity,
              onTap: () => _showSelectionSheet(
                context,
                "Ethnicity",
                ["Black", "White", "Asian", "Hispanic", "Other"],
                (val) => setState(() => _selectedEthnicity = val),
              ),
            ),
            ProfileDropdownField(
              title: "Experience",
              value: _selectedExperience,
              onTap: () => _showSelectionSheet(
                context,
                "Experience",
                [
                  "Entry Level",
                  "1-3 years",
                  "3-5 years",
                  "10 years",
                  "12 years",
                  "15+ years",
                ],
                (val) => setState(() => _selectedExperience = val),
              ),
            ),
            ProfileDropdownField(
              title: "Service Type",
              value: _selectedServiceType,
              onTap: () => _showSelectionSheet(
                context,
                "Service Type",
                ["In person", "Hybrid", "Online"],
                (val) => setState(() => _selectedServiceType = val),
              ),
            ),

            // Dropdown fields above...
            AppSpacing.h16,
            EditableTagsSection(
              title: "My Interest",
              initialTags: widget.initialInterests,
            ),
            AppSpacing.h24,
            EditableTagsSection(
              title: "Languages",
              initialTags: widget.initialLanguages,
            ),
            AppSpacing.h24,
            EditableTagsSection(
              title: "Looking for",
              initialTags: widget.initialLookingFor,
            ),

            AppSpacing.h48,
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Save logic
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            AppSpacing.h24,
          ],
        ),
      ),
    );
  }

  void _showSelectionSheet(
    BuildContext context,
    String title,
    List<String> options,
    ValueChanged<String> onSelected,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: AppPadding.r24,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: FontManager.heading3(fontSize: 18)),
              AppSpacing.h16,
              Expanded(
                child: ListView.separated(
                  itemCount: options.length,
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(options[index]),
                      onTap: () {
                        onSelected(options[index]);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
