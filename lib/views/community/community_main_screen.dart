import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/community_model.dart';
import 'package:wynante/views/community/create_post_screen.dart';
import 'package:wynante/views/community/widgets/category_filter_list.dart';
import 'package:wynante/views/community/widgets/community_post_card.dart';

class CommunityMainScreen extends StatefulWidget {
  const CommunityMainScreen({super.key});

  @override
  State<CommunityMainScreen> createState() => _CommunityMainScreenState();
}

class _CommunityMainScreenState extends State<CommunityMainScreen> {
  String _selectedCategory = "All";
  final List<String> _categories = [
    "All",
    "Social",
    "Romantic",
    "Spiritual",
    "Professional",
  ];
  final List<CommunityPost> _allPosts = CommunityPost.dummyPosts;

  List<CommunityPost> get _filteredPosts {
    if (_selectedCategory == "All") return _allPosts;
    return _allPosts
        .where((post) => post.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: Text("Community", style: FontManager.heading3(fontSize: 22)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatePostScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text("Post"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            child: CategoryFilterList(
              categories: _categories,
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
          ),

          // Feed
          Expanded(
            child: ListView.separated(
              padding: AppPadding.r12,
              itemCount: _filteredPosts.length,
              separatorBuilder: (context, index) => AppSpacing.h4,
              itemBuilder: (context, index) {
                return CommunityPostCard(post: _filteredPosts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
