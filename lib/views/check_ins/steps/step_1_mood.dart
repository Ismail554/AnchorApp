import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/check_ins/widgets/check_in_option_card.dart';

class Step1Quality extends StatefulWidget {
  final Function(String) onOptionSelected;

  const Step1Quality({super.key, required this.onOptionSelected});

  @override
  State<Step1Quality> createState() => _Step1QualityState();
}

class _Step1QualityState extends State<Step1Quality> {
  int _selectedIndex = -1;

  final List<Map<String, String>> _options = [
    {'emoji': '😊', 'label': 'Excellent'},
    {'emoji': '🙂', 'label': 'Good'},
    {'emoji': '😐', 'label': 'Okay'},
    {'emoji': '😕', 'label': 'Not Great'},
    {'emoji': '😞', 'label': 'Poor'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            children: [
              Text(
                "How well is this\nconnection going?",
                textAlign: TextAlign.center,
                style: FontManager.heading2(fontSize: 22),
              ),
              AppSpacing.h8,
              Text(
                "Rate the overall quality of your connection",
                textAlign: TextAlign.center,
                style: FontManager.bodyMedium(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _options.length,
          itemBuilder: (context, index) {
            final option = _options[index];
            return CheckInOptionCard(
              title: option['label']!,
              emoji: option['emoji'],
              isSelected: _selectedIndex == index,
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onOptionSelected(option['label']!);
              },
            );
          },
        ),
      ],
    );
  }
}
