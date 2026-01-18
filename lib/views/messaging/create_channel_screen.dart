import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/views/messaging/create_channel_invite_screen.dart';

class CreateChannelScreen extends StatefulWidget {
  const CreateChannelScreen({super.key});

  @override
  State<CreateChannelScreen> createState() => _CreateChannelScreenState();
}

class _CreateChannelScreenState extends State<CreateChannelScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // Image Picking
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Selections
  String selectedCategory = 'Social';
  String selectedPrivacy = 'Public';

  final List<String> categories = [
    'Social',
    'Romantic',
    'Spiritual',
    'Professional',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Channel',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Step 1 of 2',
              style: TextStyle(color: AppColors.grey, fontSize: 12.sp),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Upload
            Text('Channel Image', style: _labelStyle),
            SizedBox(height: 12.h),
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Colors.grey.shade300),
                    image: _imageFile != null
                        ? DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _imageFile == null
                      ? Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 30.sp,
                          color: AppColors.grey,
                        )
                      : null,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Channel Name
            Text('Channel Name *', style: _labelStyle),
            SizedBox(height: 8.h),
            _buildTextField(
              controller: _nameController,
              hint: '# channel-name',
            ),
            SizedBox(height: 24.h),

            // Description
            Text('Description *', style: _labelStyle),
            SizedBox(height: 8.h),
            _buildTextField(
              controller: _descController,
              hint: 'What is this channel about?',
              maxLines: 4,
            ),
            SizedBox(height: 24.h),

            // Category
            Text('Category *', style: _labelStyle),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: categories.map((cat) {
                final isSelected = selectedCategory == cat;
                return ChoiceChip(
                  label: Text(
                    cat,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF2D9CFC)
                          : AppColors.textPrimary,
                      fontSize: 14.sp,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (val) => setState(() => selectedCategory = cat),
                  selectedColor: const Color(0xFFEAF6FF),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF2D9CFC)
                          : Colors.grey.shade300,
                    ),
                  ),
                  showCheckmark: false,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 32.h),

            // Privacy
            Text('Privacy *', style: _labelStyle),
            SizedBox(height: 12.h),
            _buildPrivacyCard(
              title: 'Public',
              subtitle: 'Anyone can find and join this channel',
              icon: Icons.public,
              value: 'Public',
            ),
            SizedBox(height: 12.h),
            _buildPrivacyCard(
              title: 'Private',
              subtitle: 'Only invited members can join',
              icon: Icons.lock_outline,
              value: 'Private',
            ),
            SizedBox(height: 40.h),

            // Next Button
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  // Validate inputs if needed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateChannelInviteScreen(
                        channelName: _nameController.text,
                        category: selectedCategory,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 42.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.grey, fontSize: 14.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.w),
        ),
      ),
    );
  }

  Widget _buildPrivacyCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    final isSelected = selectedPrivacy == value;
    return GestureDetector(
      onTap: () => setState(() => selectedPrivacy = value),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEAF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF2D9CFC) : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF2D9CFC) : AppColors.grey,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _labelStyle => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
}
