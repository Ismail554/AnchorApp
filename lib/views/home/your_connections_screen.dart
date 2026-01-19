import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/custom_widget/mini_widget/widget_textfield.dart';
import 'package:wynante/models/your_connection_model.dart';
import 'package:wynante/custom_widget/home_widget/widget_conn_tile.dart';

class YourConnectionsScreen extends StatefulWidget {
  const YourConnectionsScreen({super.key});

  @override
  State<YourConnectionsScreen> createState() => _YourConnectionsScreenState();
}

class _YourConnectionsScreenState extends State<YourConnectionsScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<YourConnectionModel> _filteredConnections = [];

  // Filter State Variables
  String _selectedConnectionType = "All";
  double _distance = 25;
  String? _selectedGender;
  RangeValues _ageRange = const RangeValues(20, 30);

  // Temporary state for the bottom sheet
  late String _tempSelectedConnectionType;
  late double _tempDistance;
  late String? _tempSelectedGender;
  late RangeValues _tempAgeRange;

  @override
  void initState() {
    super.initState();
    _filteredConnections = YourConnectionModel.dummyData;
    _searchController.addListener(_filterConnections);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterConnections() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredConnections = YourConnectionModel.dummyData.where((conn) {
        final matchesName = conn.name.toLowerCase().contains(query);
        final matchesType =
            _selectedConnectionType == "All" ||
            conn.connectionType.toLowerCase() ==
                _selectedConnectionType.toLowerCase();
        // Note: Distance is not in the model, so we skip it for logic,
        // but we'll assume it matches for now or implement if data available.
        final matchesGender =
            _selectedGender == null ||
            conn.gender.toLowerCase() == _selectedGender!.toLowerCase();
        final matchesAge =
            conn.age >= _ageRange.start && conn.age <= _ageRange.end;

        return matchesName && matchesType && matchesGender && matchesAge;
      }).toList();
    });
  }

  void _showFilterBottomSheet() {
    _tempSelectedConnectionType = _selectedConnectionType;
    _tempDistance = _distance;
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
                height: 0.7.sh,
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
                                _selectedGender = _tempSelectedGender;
                                _ageRange = _tempAgeRange;
                              });
                              _filterConnections();
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
      backgroundColor: const Color(0xFFF8F9FD), // Light grey background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FD),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.sp,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Your Connections",
          style: FontManager.heading3(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppPadding.h24,
              child: WidgetTextfield(
                hintText: "Search name",
                controller: _searchController,
                prefixIcon: Icons.search,
                suffixIcon: Icons.tune, // Filter icon
                onSuffixTap: _showFilterBottomSheet,
                elevation: 0,
              ),
            ),
            AppSpacing.h16,
            Padding(
              padding: AppPadding.h24,
              child: Text(
                "List of Connections (${_filteredConnections.length})",
                style: FontManager.bodyMedium(color: AppColors.textPrimary),
              ),
            ),
            AppSpacing.h16,
            Expanded(
              child: ListView.separated(
                padding: AppPadding.h24,
                itemCount: _filteredConnections.length,
                separatorBuilder: (context, index) => AppSpacing.h10,
                itemBuilder: (context, index) {
                  final item = _filteredConnections[index];
                  return WidgetConnTile(connection: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
