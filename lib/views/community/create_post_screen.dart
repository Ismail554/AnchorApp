import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/community/widgets/category_filter_list.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _contentController = TextEditingController();
  String _selectedCategory = "Social"; // Default
  final List<String> _categories = [
    "All",
    "Social",
    "Romantic",
    "Spiritual",
    "Professional",
  ];

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Create Post", style: FontManager.heading3(fontSize: 18)),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: ElevatedButton(
              onPressed: () {
                // Post logic
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
              ),
              child: const Text("Post"),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: AppPadding.h20v16,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: const AssetImage(
                    "assets/images/human.png",
                  ), // Current user placeholder
                ),
                AppSpacing.w12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("You", style: FontManager.heading4(fontSize: 16)),
                    Text(
                      "Share with your community",
                      style: FontManager.bodySmall(
                        color: AppColors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: AppPadding.h20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pick Category (Optional)",
                  style: FontManager.bodyMedium(color: AppColors.grey),
                ),
                AppSpacing.h8,
                CategoryFilterList(
                  categories: _categories
                      .where((c) => c != "All")
                      .toList(), // Exclude All
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (cat) {
                    setState(() {
                      _selectedCategory = cat;
                    });
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: AppPadding.r20,
              child: TextField(
                controller: _contentController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  hintStyle: FontManager.heading3(
                    fontSize: 20,
                    color: AppColors.grey.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
                style: FontManager.bodyMedium(fontSize: 16),
              ),
            ),
          ),

          // Bottom Toolbar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.greyE8)),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.image_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.emoji_emotions_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),
                const Spacer(),
                Text(
                  "0/2000",
                  style: FontManager.bodySmall(color: AppColors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
