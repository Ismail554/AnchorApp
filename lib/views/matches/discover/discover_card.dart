import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/your_connection_model.dart';
import 'package:wynante/views/matches/discover/my_saved_screen.dart';

class DiscoverCard extends StatefulWidget {
  final YourConnectionModel connection;
  final VoidCallback? onExpandChange; // Callback to notify parent
  final bool isTopCard;

  const DiscoverCard({
    super.key,
    required this.connection,
    this.onExpandChange,
    this.isTopCard = false,
  });

  @override
  State<DiscoverCard> createState() => _DiscoverCardState();
}

class _DiscoverCardState extends State<DiscoverCard> {
  bool isExpanded = false;
  bool isSaved = false; // State for bookmark

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
    if (widget.onExpandChange != null) {
      widget.onExpandChange!();
    }
  }

  void _toggleSaved() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isExpanded ? 1.0.sw : 0.9.sw,
      height: isExpanded ? 1.0.sh : 0.75.sh,
      margin: isExpanded ? EdgeInsets.zero : const EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isExpanded ? 0 : 24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isExpanded ? 0 : 24.r),
        child: SingleChildScrollView(
          physics: isExpanded
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: GestureDetector(
            onTap: _toggleExpanded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Header
                Stack(
                  children: [
                    Image.asset(
                      ImageAssets.discoverImg1, // Updated Image Asset
                      width: double.infinity,
                      height: isExpanded ? 0.4.sh : 0.55.sh,
                      fit: BoxFit.cover,
                    ),
                    if (isExpanded)
                      Positioned(
                        top: 40.h,
                        left: 16.w,
                        child: InkWell(
                          onTap: _toggleExpanded,
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.keyboard_arrow_down, size: 24.sp),
                          ),
                        ),
                      ),
                    Positioned(
                      top: isExpanded ? 40.h : 16.h,
                      right: 16.w,
                      child: InkWell(
                        onTap: _toggleSaved, // Functional toggle
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            size: 24.sp,
                            color: isSaved
                                ? AppColors.primaryColor
                                : AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Content Section
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Saved/Action Tag - Only show when NOT expanded or maybe always?
                      // Reference image has it.
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MySavedScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: const Color(0xFF2D9CFC)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.favorite,
                                size: 14.sp,
                                color: const Color(0xFF2D9CFC),
                              ),
                              AppSpacing.w4,
                              Text(
                                "Saved",
                                style: FontManager.bodySmall(
                                  color: const Color(0xFF2D9CFC),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 16.sp,
                                color: const Color(0xFF2D9CFC),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppSpacing.h16,

                      Text(
                        "${widget.connection.name}, ${widget.connection.age}",
                        style: FontManager.heading3(fontSize: 24),
                      ),
                      AppSpacing.h4,
                      Text(
                        widget.connection.role,
                        style: FontManager.bodyMedium(
                          color: AppColors.grey,
                          fontSize: 16,
                        ),
                      ),
                      AppSpacing.h16,
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 18.sp,
                            color: AppColors.grey,
                          ),
                          AppSpacing.w4,
                          Text(
                            "San Francisco, CA • 5 miles away",
                            style: FontManager.bodySmall(
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      // Show more details only if expanded
                      if (isExpanded) ...[
                        AppSpacing.h24,
                        Text(
                          "About",
                          style: FontManager.heading4(fontSize: 16),
                        ),
                        AppSpacing.h8,
                        Text(
                          widget.connection.about,
                          style: FontManager.bodyMedium(
                            color: AppColors.grey,
                            fontSize: 14,
                          ).copyWith(height: 1.5),
                        ),

                        AppSpacing.h24,

                        Text(
                          "Interests",
                          style: FontManager.heading4(fontSize: 16),
                        ),
                        AppSpacing.h8,
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: widget.connection.interests
                              .take(5)
                              .map((e) => _buildChip(e))
                              .toList(),
                        ),

                        AppSpacing.h24,

                        Text(
                          "How You Match",
                          style: FontManager.heading4(fontSize: 16),
                        ),
                        AppSpacing.h16,
                        _buildProgressRow(
                          Icons.people_outline,
                          "Social",
                          0.85,
                          Colors.blue,
                        ),
                        AppSpacing.h12,
                        _buildProgressRow(
                          Icons.favorite_border,
                          "Romantic",
                          0.92,
                          Colors.red,
                        ),
                        AppSpacing.h12,
                        _buildProgressRow(
                          Icons.spa_outlined,
                          "Spiritual",
                          0.78,
                          Colors.purple,
                        ),
                        AppSpacing.h12,
                        _buildProgressRow(
                          Icons.work_outline,
                          "Professional",
                          0.65,
                          Colors.green,
                        ),

                        AppSpacing.h16,
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: FontManager.bodyMedium(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                              children: [
                                const TextSpan(
                                  text: "Best Match: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(text: "Romantic (92%)"),
                              ],
                            ),
                          ),
                        ),

                        AppSpacing.h24,

                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.refresh, size: 20.sp),
                                label: const Text("Search"),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  side: const BorderSide(
                                    color: Color(0xFF2D9CFC),
                                  ),
                                  foregroundColor: const Color(0xFF2D9CFC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                              ),
                            ),
                            AppSpacing.w16,
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.send, size: 20.sp),
                                label: const Text("Send A-Pod"),
                                style: FilledButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  backgroundColor: const Color(0xFF2D9CFC),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.h32,
                      ] else ...[
                        // Hint text to tap to view more
                        AppSpacing.h24,
                        Center(
                          child: Text(
                            "Tap to view details",
                            style: FontManager.bodySmall(color: AppColors.grey),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F8),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: FontManager.bodyMedium(color: AppColors.grey, fontSize: 13),
      ),
    );
  }

  Widget _buildProgressRow(
    IconData icon,
    String label,
    double percent,
    Color color,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 18.sp, color: color),
                AppSpacing.w8,
                Text(label, style: FontManager.bodyMedium(fontSize: 14)),
              ],
            ),
            Text(
              "${(percent * 100).toInt()}%",
              style: FontManager.bodyMedium(fontSize: 14),
            ),
          ],
        ),
        AppSpacing.h8,
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: percent,
            backgroundColor: AppColors.greyE8,
            color: color,
            minHeight: 8.h,
          ),
        ),
      ],
    );
  }
}
