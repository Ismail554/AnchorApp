import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wynante/core/app_colors.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _attendeesController = TextEditingController();

  // Image Picking
  List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(pickedFiles.map((e) => File(e.path)));
      });
    }
  }

  // Type Selection
  String selectedType = 'Social';
  final List<String> eventTypes = [
    'Social',
    'Romantic',
    'Spiritual',
    'Professional',
  ];

  // Date & Time
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Virtual Event
  bool _isVirtual = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create Event',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            Text('Event Image', style: _labelStyle),
            SizedBox(height: 12.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 30.sp,
                            color: AppColors.grey,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Add Photos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ..._selectedImages.map((file) {
                    return Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Stack(
                        children: [
                          Container(
                            width: 120.w,
                            height: 120.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              image: DecorationImage(
                                image: FileImage(file),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImages.remove(file);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Event Title
            Text('Event Title *', style: _labelStyle),
            SizedBox(height: 8.h),
            _buildTextField(
              controller: _titleController,
              hint: 'Enter event title',
            ),
            SizedBox(height: 24.h),

            // Event Type
            Text('Event Type *', style: _labelStyle),
            SizedBox(height: 12.h),
            _buildEventTypeGrid(),
            SizedBox(height: 24.h),

            // Description
            Text('Description *', style: _labelStyle),
            SizedBox(height: 8.h),
            _buildTextField(
              controller: _descController,
              hint: 'Describe your event...',
              maxLines: 4,
            ),
            SizedBox(height: 24.h),

            // Date & Time
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date *', style: _labelStyle),
                      SizedBox(height: 8.h),
                      _buildDateTimeField(
                        onTap: _pickDate,
                        icon: Icons.calendar_today_outlined,
                        value: _selectedDate != null
                            ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                            : 'dd/mm/yyyy',
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Time *', style: _labelStyle),
                      SizedBox(height: 8.h),
                      _buildDateTimeField(
                        onTap: _pickTime,
                        icon: Icons.access_time,
                        value: _selectedTime != null
                            ? _selectedTime!.format(context)
                            : '--/--/--',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Virtual Event
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Virtual Event',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'This event will be held online',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: _isVirtual,
                      onChanged: (val) => setState(() => _isVirtual = val),
                      activeColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Location
            Text('Location *', style: _labelStyle),
            SizedBox(height: 8.h),
            _buildTextField(
              controller: _locationController,
              hint: 'Enter event location',
              prefixIcon: Icons.location_on_outlined,
            ),
            SizedBox(height: 24.h),

            // Max Attendees
            Text('Maximum Attendees (Optional)', style: _labelStyle),
            SizedBox(height: 8.h),
            _buildTextField(
              controller: _attendeesController,
              hint: 'No limit',
              prefixIcon: Icons.people_outline,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 40.h),

            // Create Button
            SizedBox(
              width: double.maxFinite,

              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement Create Event Logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Event Created Successfully"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Create Event',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 36.h),
          ],
        ),
      ),
    );
  }

  Widget _buildEventTypeGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemWidth = (constraints.maxWidth - 12.w) / 2;
        return Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: eventTypes.map((type) {
            final isSelected = selectedType == type;
            return SizedBox(
              width: itemWidth,
              child: GestureDetector(
                onTap: () => setState(() => selectedType = type),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFEAF6FF) : Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey.shade200,
                    ),
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                      fontSize: 14.sp,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? prefixIcon,
    int maxLines = 1,
    TextInputType? keyboardType,
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
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColors.textSecondary.withOpacity(0.5),
            fontSize: 14.sp,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: AppColors.textSecondary, size: 20.sp)
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.w),
        ),
      ),
    );
  }

  Widget _buildDateTimeField({
    required VoidCallback onTap,
    required IconData icon,
    required String value,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 20.sp),
            SizedBox(width: 12.w),
            Text(
              value,
              style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _labelStyle => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
}
