import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({super.key});

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  final List<Map<String, dynamic>> _plans = [
    {
      'title': 'Free Plan',
      'price': '0',
      'period': '/month',
      'isCurrent': true,
      'isBestValue': false,
      'features': [
        '5 A-Pods per month',
        'Basic matching',
        'Community access',
        'Basic check-ins',
      ],
      'themeColor': const Color(0xFF2D9CFC), // Blue
      'bgColor': Colors.white,
    },
    {
      'title': 'Premium Plan',
      'price': '5.99',
      'period': '/month',
      'isCurrent': false,
      'isBestValue': true,
      'features': [
        'Unlimited A-Pods',
        'Advanced AI matching',
        'Priority support',
        'Advanced analytics',
        'Exclusive events',
        'Ad-free experience',
      ],
      'themeColor': const Color(0xFFFF9100), // Orange
      'bgColor': const Color(0xFFFFFBF3), // Light cream/orange tint
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Subscription Plans',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        itemCount: _plans.length,
        itemBuilder: (context, index) {
          final plan = _plans[index];
          return _buildSubscriptionCard(plan);
        },
      ),
    );
  }

  Widget _buildSubscriptionCard(Map<String, dynamic> plan) {
    final bool isPremium = plan['title'] == 'Premium Plan';
    final Color themeColor = plan['themeColor'];
    final Color bgColor = plan['bgColor'];

    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: isPremium
              ? themeColor.withOpacity(0.3)
              : const Color(0xFF2D9CFC),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isPremium ? themeColor : Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.auto_awesome,
              color: isPremium ? Colors.white : Colors.black54,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 16.h),

          // Title
          Text(
            plan['title'],
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),

          // Price
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '\$${plan['price']}',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                plan['period'],
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Badge
          if (plan['isCurrent'])
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: const Color(0xFF2D9CFC)),
              ),
              child: Text(
                'Current Plan',
                style: TextStyle(
                  color: const Color(0xFF2D9CFC),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          if (plan['isBestValue'])
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Best Value',
                style: TextStyle(
                  color: const Color(0xFF2E7D32),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SizedBox(height: 24.h),

          // Features
          ...List.generate(plan['features'].length, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: themeColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    plan['features'][index],
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF4A4A4A),
                    ),
                  ),
                ],
              ),
            );
          }),

          // Upgrade Button (Only for Premium)
          if (isPremium) ...[
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D9CFC),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Upgrade Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
