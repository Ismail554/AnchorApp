import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/views/check_ins/widgets/check_in_option_card.dart';

class Step2Desire extends StatefulWidget {
  final Function(String) onOptionSelected;

  const Step2Desire({super.key, required this.onOptionSelected});

  @override
  State<Step2Desire> createState() => _Step2DesireState();
}

class _Step2DesireState extends State<Step2Desire> {
  int _selectedIndex = -1;

  final List<Map<String, String>> _options = [
    {'label': 'Very Strongly', 'subtitle': 'Definitely want to continue'},
    {'label': 'Strongly', 'subtitle': 'Looking forward to more'},
    {'label': 'Moderately', 'subtitle': 'Open to continuing'},
    {'label': 'Slightly', 'subtitle': 'Unsure about continuing'},
    {'label': 'Not at all', 'subtitle': 'Prefer to end connection'},
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
                "How strongly would you like\nto continue?",
                textAlign: TextAlign.center,
                style: FontManager.heading2(fontSize: 22),
              ),
              AppSpacing.h8,
              Text(
                "Rate your desire to maintain this connection",
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
              subtitle: option['subtitle'],
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
