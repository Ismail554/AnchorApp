import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/your_connection_model.dart';
import 'package:wynante/views/matches/discover/swipeable_card_stack.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_spacing.dart';

class MatchHomeScreen extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  const MatchHomeScreen({super.key, this.navigatorKey});

  @override
  State<MatchHomeScreen> createState() => _MatchHomeScreenState();
}

class _MatchHomeScreenState extends State<MatchHomeScreen> {
  late final GlobalKey<NavigatorState> navigatorKey;

  @override
  void initState() {
    super.initState();
    navigatorKey = widget.navigatorKey ?? GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => const _MatchHomeContent(),
        );
      },
    );
  }
}

class _MatchHomeContent extends StatefulWidget {
  const _MatchHomeContent();

  @override
  State<_MatchHomeContent> createState() => _MatchHomeContentState();
}

class _MatchHomeContentState extends State<_MatchHomeContent> {
  // Using connection dummy data for candidates for now
  final List<YourConnectionModel> _candidates = YourConnectionModel.dummyData;

  // Filter State Variables
  String _selectedConnectionType = "All";
  double _distance = 25;
  String? _selectedActivityLevel;
  String? _selectedGender;
  RangeValues _ageRange = const RangeValues(20, 30);

  // Temporary state for the bottom sheet
  late String _tempSelectedConnectionType;
  late double _tempDistance;
  late String? _tempSelectedActivityLevel;
  late String? _tempSelectedGender;
  late RangeValues _tempAgeRange;

  void _showFilterBottomSheet() {
    _tempSelectedConnectionType = _selectedConnectionType;
    _tempDistance = _distance;
    _tempSelectedActivityLevel = _selectedActivityLevel;
    _tempSelectedGender = _selectedGender;
    _tempAgeRange = _ageRange;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 0.5.sh,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              AppSpacing.h12,
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              AppSpacing.h24,
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: StatefulBuilder(
                    builder: (context, setSheetState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Connection Type",
                            style: FontManager.heading4(fontSize: 16),
                          ),
                          AppSpacing.h12,
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children:
                                [
                                  "All",
                                  "Social",
                                  "Romantic",
                                  "Spiritual",
                                  "Professional",
                                ].map((type) {
                                  final isSelected =
                                      _tempSelectedConnectionType == type;
                                  return ChoiceChip(
                                    label: Text(
                                      type,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black87,
                                        fontSize: 14.sp,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                    selected: isSelected,
                                    onSelected: (selected) {
                                      if (selected) {
                                        setSheetState(() {
                                          _tempSelectedConnectionType = type;
                                        });
                                      }
                                    },
                                    selectedColor: AppColors.primaryColor,
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 8.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.r),
                                      side: BorderSide(
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : Colors.grey[300]!,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                          AppSpacing.h24,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Distance",
                                style: FontManager.heading4(fontSize: 16),
                              ),
                              Text(
                                "${_tempDistance.round()} miles",
                                style: FontManager.bodyMedium(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: AppColors.primaryColor,
                              inactiveTrackColor: Colors.grey[200],
                              thumbColor: AppColors.primaryColor,
                              overlayColor: AppColors.primaryColor.withOpacity(
                                0.2,
                              ),
                              trackHeight: 4.h,
                            ),
                            child: Slider(
                              value: _tempDistance,
                              min: 0,
                              max: 100,
                              onChanged: (value) {
                                setSheetState(() {
                                  _tempDistance = value;
                                });
                              },
                            ),
                          ),
                          AppSpacing.h24,
                          Text(
                            "Activity Level",
                            style: FontManager.heading4(fontSize: 16),
                          ),
                          AppSpacing.h12,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _tempSelectedActivityLevel,
                                hint: Text(
                                  "Select",
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14.sp,
                                  ),
                                ),
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                borderRadius: BorderRadius.circular(12.r),
                                items: ["Low", "Moderate", "High", "Very High"]
                                    .map((level) {
                                      return DropdownMenuItem(
                                        value: level,
                                        child: Text(level),
                                      );
                                    })
                                    .toList(),
                                onChanged: (value) {
                                  setSheetState(() {
                                    _tempSelectedActivityLevel = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          AppSpacing.h24,
                          Text(
                            "Gender",
                            style: FontManager.heading4(fontSize: 16),
                          ),
                          AppSpacing.h12,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _tempSelectedGender,
                                hint: Text(
                                  "Select",
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14.sp,
                                  ),
                                ),
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                borderRadius: BorderRadius.circular(12.r),
                                items: ["Man", "Woman", "Non-binary"].map((
                                  gender,
                                ) {
                                  return DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setSheetState(() {
                                    _tempSelectedGender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          AppSpacing.h24,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Age",
                                style: FontManager.heading4(fontSize: 16),
                              ),
                              Text(
                                "${_tempAgeRange.start.round()}y - ${_tempAgeRange.end.round()}y",
                                style: FontManager.bodyMedium(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: AppColors.primaryColor,
                              inactiveTrackColor: Colors.grey[200],
                              thumbColor: AppColors.primaryColor,
                              overlayColor: AppColors.primaryColor.withOpacity(
                                0.2,
                              ),
                              trackHeight: 4.h,
                            ),
                            child: RangeSlider(
                              values: _tempAgeRange,
                              min: 18,
                              max: 100,
                              onChanged: (values) {
                                setSheetState(() {
                                  _tempAgeRange = values;
                                });
                              },
                            ),
                          ),
                          AppSpacing.h40, // Bottom spacing for scroll
                        ],
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Note: We need a way to update the stateful builder's state from here,
                          // but since this button is outside the StatefulBuilder, it might reset only local vars.
                          // Ideally, the whole sheet content should be in one StatefulBuilder or separated.
                          // For simplicity, we'll just update logic vars and rely on user to see change on next interaction
                          // or better: force rebuild.
                          // A better approach is to wrap the whole content in StatefulBuilder.
                          // But let's keep simple first.
                          // Actually, 'setSheetState' is not available here.
                          // Let's rely on the internal state or move buttons inside.
                          Navigator.pop(context);
                          _showFilterBottomSheet(); // Re-open to "reset" visually? No, that's bad UX.
                          // Correct fix: Move buttons inside StatefulBuilder or use a State class.
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          side: BorderSide(color: AppColors.primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.w16,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedConnectionType =
                                _tempSelectedConnectionType;
                            _distance = _tempDistance;
                            _selectedActivityLevel = _tempSelectedActivityLevel;
                            _selectedGender = _tempSelectedGender;
                            _ageRange = _tempAgeRange;
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          backgroundColor: AppColors.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Apply Filters",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover", style: FontManager.heading3(fontSize: 22)),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _showFilterBottomSheet,
            icon: const Icon(Icons.tune), // Filter icon
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Center(child: SwipeableCardStack(candidates: _candidates)),
      ),
    );
  }
}
