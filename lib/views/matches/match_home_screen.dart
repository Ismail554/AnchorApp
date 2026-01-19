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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: StatefulBuilder(
            builder: (context, setSheetState) {
              return Container(
                padding: EdgeInsets.all(24.r),
                height: 0.85.sh, // Slightly taller to fit all fields
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              label: Text(type),
                              selected: isSelected,
                              onSelected: (selected) {
                                if (selected) {
                                  setSheetState(() {
                                    _tempSelectedConnectionType = type;
                                  });
                                }
                              },
                              selectedColor: AppColors.primaryColor,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.grey,
                              ),
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
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
                    Text(
                      "Distance: ${_tempDistance.round()} miles",
                      style: FontManager.heading4(fontSize: 16),
                    ),
                    Slider(
                      value: _tempDistance,
                      min: 0,
                      max: 100,
                      activeColor: AppColors.primaryColor,
                      inactiveColor: Colors.grey[300],
                      onChanged: (value) {
                        setSheetState(() {
                          _tempDistance = value;
                        });
                      },
                    ),
                    AppSpacing.h16,
                    Text(
                      "Activity Level",
                      style: FontManager.heading4(fontSize: 16),
                    ),
                    AppSpacing.h12,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _tempSelectedActivityLevel,
                          hint: const Text("Select"),
                          isExpanded: true,
                          items: ["Low", "Moderate", "High", "Very High"].map((
                            level,
                          ) {
                            return DropdownMenuItem(
                              value: level,
                              child: Text(level),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setSheetState(() {
                              _tempSelectedActivityLevel = value;
                            });
                          },
                        ),
                      ),
                    ),
                    AppSpacing.h16,
                    Text("Gender", style: FontManager.heading4(fontSize: 16)),
                    AppSpacing.h12,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _tempSelectedGender,
                          hint: const Text("Select"),
                          isExpanded: true,
                          items: ["Man", "Woman", "Non-binary"].map((gender) {
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
                        Text("Age", style: FontManager.heading4(fontSize: 16)),
                        Text(
                          "${_tempAgeRange.start.round()}y - ${_tempAgeRange.end.round()}y",
                          style: FontManager.bodyMedium(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    RangeSlider(
                      values: _tempAgeRange,
                      min: 18,
                      max: 100,
                      activeColor: AppColors.primaryColor,
                      inactiveColor: Colors.grey[300],
                      onChanged: (values) {
                        setSheetState(() {
                          _tempAgeRange = values;
                        });
                      },
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setSheetState(() {
                                _tempSelectedConnectionType = "All";
                                _tempDistance = 25;
                                _tempSelectedActivityLevel = null;
                                _tempSelectedGender = null;
                                _tempAgeRange = const RangeValues(20, 30);
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              side: BorderSide(color: AppColors.primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              "Reset",
                              style: TextStyle(color: AppColors.primaryColor),
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
                                _selectedActivityLevel =
                                    _tempSelectedActivityLevel;
                                _selectedGender = _tempSelectedGender;
                                _ageRange = _tempAgeRange;
                              });
                              // Implement filtering logic here if/when actual data is used
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: const Text(
                              "Apply Filters",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
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
