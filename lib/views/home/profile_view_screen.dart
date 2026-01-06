import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart'; // Assuming this exists
import 'package:wynante/core/app_padding.dart'; // Assuming this exists
import 'package:wynante/core/app_spacing.dart'; // Assuming this exists
import 'package:wynante/core/font_manager.dart'; // Assuming this exists
import 'package:wynante/models/your_connection_model.dart';
import 'package:wynante/views/home/aet_screen.dart';

class ProfileViewScreen extends StatefulWidget {
  final YourConnectionModel connection;

  const ProfileViewScreen({super.key, required this.connection});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          icon: Icon(Icons.arrow_back_ios, size: 20.sp, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Profile", style: FontManager.heading3(fontSize: 18)),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            onSelected: (value) {
              // TODO: Implement actions
              switch (value) {
                case 'Block':
                  break;
                case 'Disconnect':
                  break;
                case 'Report':
                  break;
              }
            },
            itemBuilder: (context) => [
              _buildPopupMenuItem('Block', Icons.remove_circle_outline),
              _buildPopupMenuItem('Disconnect', Icons.exit_to_app),
              _buildPopupMenuItem(
                'Report',
                Icons.report_gmailerrorred_outlined,
              ),
            ],
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: AppPadding.h24,
                child: Column(
                  children: [
                    AppSpacing.h16,
                    _buildProfileHeader(),
                    AppSpacing.h24,
                    _buildTrackerCard(),
                    AppSpacing.h24,
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor: AppColors.grey,
                  indicatorColor: AppColors.primaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: FontManager.heading4(fontSize: 16),
                  unselectedLabelStyle: FontManager.bodyMedium(fontSize: 16),
                  tabs: const [
                    Tab(text: "Basic Info"),
                    Tab(text: "Posts"),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [_buildBasicInfoTab(), _buildPostsTab()],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Pic with Ring and Badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 3),
              ),
              child: CircleAvatar(
                radius: 40.r,
                backgroundColor: AppColors.greyE8,
                backgroundImage: widget.connection.pic.isNotEmpty
                    ? AssetImage(widget.connection.pic)
                    : null,
                child: widget.connection.pic.isEmpty
                    ? Icon(Icons.person, size: 40.sp, color: Colors.grey)
                    : null,
              ),
            ),
            Positioned(
              bottom: -5,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  "100%",
                  textAlign: TextAlign.center,
                  style: FontManager.bodySmall(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        AppSpacing.w16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.connection.name,
                    style: FontManager.heading3(fontSize: 20),
                  ),
                  if (widget.connection.age > 0) ...[
                    AppSpacing.w4,
                    Text(
                      "(${widget.connection.age}y)",
                      style: FontManager.bodyMedium(
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
              AppSpacing.h4,
              Row(
                children: [
                  Text(
                    widget.connection.role.isNotEmpty
                        ? widget.connection.role
                        : "Member",
                    style: FontManager.bodyMedium(color: AppColors.grey),
                  ),
                  AppSpacing.w8,
                  Icon(
                    Icons.signal_cellular_alt,
                    color: Colors.green,
                    size: 16,
                  ),
                ],
              ),
              AppSpacing.h12,
              Row(
                children: [
                  // A Pod Button
                  FilledButton.icon(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF2D9CFC),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      minimumSize: Size(0, 32.h),
                    ),
                    icon: Icon(Icons.video_call, size: 16.sp),
                    label: Text("A Pod", style: TextStyle(fontSize: 12.sp)),
                  ),
                  AppSpacing.w8,
                  // Chat Button
                  OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2D9CFC),
                      side: const BorderSide(color: Color(0xFF2D9CFC)),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      minimumSize: Size(0, 32.h),
                    ),
                    icon: Icon(Icons.chat_bubble_outline, size: 16.sp),
                    label: Text("Chat", style: TextStyle(fontSize: 12.sp)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrackerCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Anchor Evaluation Tracker",
                    style: FontManager.heading4(
                      fontSize: 14,
                      color: AppColors.grey,
                    ),
                  ),
                  AppSpacing.w8,
                  Icon(Icons.show_chart, color: Colors.green, size: 18),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EvaluationTracker(connection: widget.connection),
                    ),
                  );
                },
                child: Text(
                  "View",
                  style: FontManager.bodySmall(
                    color: AppColors.primaryColor,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          AppSpacing.h12,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              widget.connection.activity, // Use activity as level for now
              style: FontManager.bodySmall(color: Colors.green),
            ),
          ),
          AppSpacing.h12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your progress with this person",
                style: FontManager.bodySmall(
                  color: AppColors.grey,
                  fontSize: 10,
                ),
              ),
              Text(
                "From 🕑 29 July, 2025",
                style: FontManager.bodySmall(
                  color: AppColors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          AppSpacing.h8,
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: 0.3, // Static value for now
              backgroundColor: AppColors.greyE8,
              color: Colors.green,
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoTab() {
    return SingleChildScrollView(
      padding: AppPadding.h24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.h24,
          // About Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("About", style: FontManager.heading4(fontSize: 16)),
              Row(
                children: [
                  Text(
                    "BD, Chittagong",
                    style: FontManager.bodySmall(color: AppColors.grey),
                  ),
                  Icon(Icons.location_on, size: 14.sp, color: AppColors.grey),
                ],
              ),
            ],
          ),
          AppSpacing.h12,
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FD),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              widget.connection.about,
              style: FontManager.bodyMedium(
                color: AppColors.grey,
                fontSize: 13,
              ).copyWith(height: 1.5),
            ),
          ),
          AppSpacing.h24,
          // Gallery
          Text("Gallery", style: FontManager.heading4(fontSize: 16)),
          AppSpacing.h12,
          SizedBox(
            height: 80.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.connection.galleryImages.length,
              separatorBuilder: (_, __) => AppSpacing.w12,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    widget.connection.galleryImages[index],
                    width: 80.h,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          AppSpacing.h24,
          // Basic Informations
          Text(
            "Basic informations (28y)",
            style: FontManager.heading4(fontSize: 16),
          ),
          AppSpacing.h12,
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              if (widget.connection.gender.isNotEmpty)
                _buildChip(widget.connection.gender, icon: Icons.male),
              if (widget.connection.smoking == "No")
                _buildChip("No Smoking", icon: Icons.smoke_free),
              if (widget.connection.drinking == "No")
                _buildChip("No Drinking", icon: Icons.wine_bar),
              if (widget.connection.education.isNotEmpty)
                _buildChip(
                  widget.connection.education,
                  icon: Icons.school_outlined,
                ),
              if (widget.connection.religion.isNotEmpty)
                _buildChip(widget.connection.religion),
              if (widget.connection.familyType.isNotEmpty)
                _buildChip(widget.connection.familyType),
              if (widget.connection.origin.isNotEmpty)
                _buildChip("Origin: ${widget.connection.origin}"),
            ],
          ),
          AppSpacing.h24,
          // My Interest
          Text("My Interest", style: FontManager.heading4(fontSize: 16)),
          AppSpacing.h12,
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: widget.connection.interests
                .map((e) => _buildChip(e))
                .toList(),
          ),
          AppSpacing.h24,
          // Languages
          Text("Languages", style: FontManager.heading4(fontSize: 16)),
          AppSpacing.h12,
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: widget.connection.languages
                .map((e) => _buildChip(e))
                .toList(),
          ),
          AppSpacing.h32,
        ],
      ),
    );
  }

  Widget _buildChip(String label, {IconData? icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FD),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16.sp, color: AppColors.grey),
            AppSpacing.w4,
          ],
          Text(
            label,
            style: FontManager.bodyMedium(color: AppColors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String value, IconData icon) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: AppColors.grey),
          AppSpacing.w12,
          Text(
            value,
            style: FontManager.bodyMedium(
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    if (widget.connection.posts.isEmpty) {
      return Center(
        child: Text(
          "No posts yet",
          style: FontManager.bodyMedium(color: AppColors.grey),
        ),
      );
    }
    return ListView.separated(
      padding: AppPadding.r24,
      itemCount: widget.connection.posts.length,
      separatorBuilder: (_, __) => AppSpacing.h16,
      itemBuilder: (context, index) {
        return PostItemWidget(post: widget.connection.posts[index]);
      },
    );
  }
}

class PostItemWidget extends StatefulWidget {
  final PostModel post;

  const PostItemWidget({super.key, required this.post});

  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.post.isLiked;
    likeCount = widget.post.likeCount;
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(widget.post.authorPic),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AppSpacing.w12,
              Expanded(
                child: Text(
                  widget.post.title,
                  style: FontManager.heading4(fontSize: 16),
                ),
              ),
            ],
          ),
          AppSpacing.h12,
          Row(
            children: [
              InkWell(
                onTap: _toggleLike,
                child: Row(
                  children: [
                    Icon(
                      isLiked
                          ? Icons.thumb_up_alt
                          : Icons.thumb_up_alt_outlined,
                      size: 16.sp,
                      color: isLiked ? Colors.blue : AppColors.grey,
                    ),
                    AppSpacing.w4,
                    Text(
                      "Like",
                      style: FontManager.bodySmall(
                        color: isLiked ? Colors.blue : AppColors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.w16,
              Row(
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 16.sp,
                    color: AppColors.grey,
                  ),
                  AppSpacing.w4,
                  Text(
                    "${widget.post.commentCount} Comments",
                    style: FontManager.bodySmall(
                      color: AppColors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.all(2.r),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.thumb_up, size: 10.sp, color: Colors.white),
              ),
              AppSpacing.w4,
              Text(
                "$likeCount",
                style: FontManager.bodySmall(
                  color: AppColors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          AppSpacing.h12,
          Text(
            widget.post.content,
            style: FontManager.bodyMedium(
              color: AppColors.grey,
              fontSize: 13,
            ).copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
