import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/auth/profile_setup/steps/basics_step.dart';
import 'package:wynante/views/auth/profile_setup/steps/connection_types_step.dart';
import 'package:wynante/views/auth/profile_setup/steps/photos_step.dart';
import 'package:wynante/views/auth/profile_setup/steps/summary_step.dart';
import 'package:wynante/views/auth/profile_setup/steps/user_category_step.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  final ImagePicker _picker = ImagePicker();
  
  int _currentIndex = 0;
  final int _totalSteps = 5;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  
  String _selectedGender = '';
  final List<String> _selectedConnections = [];
  String _selectedCategory = '';
  final List<String> _photos = [];

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _birthdayController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _handleComplete();
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _handleComplete() {
    debugPrint("Profile setup completed");
  }

  Future<void> _pickImage() async {
    if (_photos.length >= 6) return;

    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null && mounted) {
        setState(() {
          _photos.add(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _photos.removeAt(index);
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && mounted) {
      setState(() {
        _birthdayController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _toggleConnection(String value) {
    setState(() {
      if (_selectedConnections.contains(value)) {
        _selectedConnections.remove(value);
      } else {
        _selectedConnections.add(value);
      }
    });
  }

  double get _progress => (_currentIndex + 1) / _totalSteps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.sp,
            color: AppColors.textPrimary,
          ),
          onPressed: _previousPage,
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(2.r),
          child: LinearProgressIndicator(
            value: _progress,
            backgroundColor: AppColors.greyE8,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.primaryColor,
            ),
            minHeight: 4.h,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Center(
              child: Text(
                '${_currentIndex + 1}/$_totalSteps',
                style: FontManager.bodySmall(color: AppColors.grey),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                BasicsStep(
                  nameController: _nameController,
                  birthdayController: _birthdayController,
                  countryController: _countryController,
                  cityController: _cityController,
                  selectedGender: _selectedGender,
                  onGenderChanged: (val) => setState(() => _selectedGender = val),
                  onSelectDate: _selectDate,
                ),
                ConnectionTypesStep(
                  selectedConnections: _selectedConnections,
                  onChanged: _toggleConnection,
                ),
                UserCategoryStep(
                  selectedCategory: _selectedCategory,
                  onChanged: (val) => setState(() => _selectedCategory = val),
                ),
                PhotosStep(
                  photos: _photos,
                  onAddPhoto: _pickImage,
                  onRemovePhoto: _removePhoto,
                ),
                SummaryStep(
                  name: _nameController.text,
                  location: "${_cityController.text}, ${_countryController.text}",
                  connectionCount: _selectedConnections.length,
                  category: _selectedCategory,
                  photoCount: _photos.length,
                  onComplete: _handleComplete,
                ),
              ],
            ),
          ),
          Padding(
            padding: AppPadding.r24,
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: FilledButton(
                onPressed: _nextPage,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  _currentIndex == _totalSteps - 1
                      ? "Complete Setup"
                      : "Continue",
                  style: FontManager.buttonText(fontSize: 16),
                ),
              ),
            ),
          ),
          AppSpacing.h16,
        ],
      ),
    );
  }
}
