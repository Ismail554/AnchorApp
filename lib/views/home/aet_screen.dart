import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/your_connection_model.dart';

class EvaluationTracker extends StatefulWidget {
  final YourConnectionModel connection;
  const EvaluationTracker({super.key, required this.connection});

  @override
  State<EvaluationTracker> createState() => _EvaluationTrackerState();
}

class _EvaluationTrackerState extends State<EvaluationTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFC),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.sp, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Anchor Evaluation Tracker",
          style: FontManager.heading3(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppPadding.r24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connected Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Connected from",
                  style: FontManager.bodyMedium(color: AppColors.grey),
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14.sp, color: AppColors.grey),
                    AppSpacing.w4,
                    Text(
                      "29 July, 2025",
                      style: FontManager.bodySmall(color: AppColors.grey),
                    ),
                  ],
                ),
              ],
            ),
            AppSpacing.h12,
            // Overall Connection Card
            Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Overall Connection",
                        style: FontManager.bodyMedium(color: AppColors.grey),
                      ),
                      AppSpacing.h8,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          widget.connection.activity,
                          style: FontManager.bodySmall(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "AET",
                        style: FontManager.heading4(
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                      AppSpacing.w12,
                      SizedBox(
                        width: 50.r,
                        height: 50.r,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: 0.44,
                              backgroundColor: AppColors.greyE8,
                              color: Colors.green,
                              strokeWidth: 4,
                            ),
                            Center(
                              child: Text(
                                "44%",
                                style: FontManager.heading4(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.h24,
            Text(
              "Check- ins History",
              style: FontManager.bodyMedium(color: AppColors.grey),
            ),
            AppSpacing.h12,
            // Relationship improvements Graph
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.map, color: Colors.deepOrange, size: 20.sp),
                      AppSpacing.w8,
                      Text(
                        "Relationship  improvements Graph",
                        style: FontManager.heading4(
                          fontSize: 14,
                          color: const Color(0xFF535763),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.h16,
                  Text(
                    "Status out of 100",
                    style: FontManager.bodySmall(
                      color: AppColors.grey,
                      fontSize: 10,
                    ),
                  ),
                  AppSpacing.h16,
                  SizedBox(
                    height: 150.h,
                    width: double.infinity,
                    child: CustomPaint(painter: _GraphPainter()),
                  ),
                  AppSpacing.h8,
                  Center(
                    child: Text(
                      "Date ----------->",
                      style: FontManager.bodySmall(
                        color: AppColors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.h24,
            // Today's report
            Row(
              children: [
                Icon(Icons.map, color: Colors.deepOrange, size: 20.sp),
                AppSpacing.w8,
                Text(
                  "Today’s report",
                  style: FontManager.heading4(
                    fontSize: 14,
                    color: const Color(0xFF535763),
                  ),
                ),
              ],
            ),
            AppSpacing.h8,
            Text(
              "Explore program aims to build a holistic child through exposure to activities across these 6 skills",
              style: FontManager.bodySmall(color: AppColors.grey),
            ),
            AppSpacing.h16,
            _buildReportItem(
              "Number of A-pods",
              "5/10",
              0.5,
              Icons.videocam,
              const Color(0xFFE5F8E8),
              Color(0xFFA2C785),
            ),
            AppSpacing.h12,
            _buildReportItem(
              "Check-ins",
              "3/10",
              0.3,
              Icons.check_circle_outline,
              const Color(0xFFFDECEC),
              const Color(0xFFA2C785),
            ),
            AppSpacing.h12,
            _buildReportItem(
              "Chat frequency",
              "3/10",
              0.3,
              Icons.people_outline,
              const Color(0xFFFEF5E5),
              const Color(0xFFA2C785),
            ),
            AppSpacing.h24,
            // Special Recognitions
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Special Recognitions",
                            style: FontManager.heading4(fontSize: 16),
                          ),
                          Text(
                            "Advise by Anchor Up",
                            style: FontManager.bodySmall(color: AppColors.grey),
                          ),
                        ],
                      ),
                      Icon(Icons.stars, color: Colors.amber, size: 40.sp),
                    ],
                  ),
                  AppSpacing.h16,
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF6EB),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "She was interacting with all the children and she was giving clay to everyone",
                                style: FontManager.bodyMedium(
                                  color: const Color(0xFF535763),
                                  fontSize: 13,
                                ),
                              ),
                              AppSpacing.h12,
                              Text(
                                "Chat interatcions",
                                style: FontManager.bodySmall(
                                  fontSize: 12,
                                  color: const Color(0xFF535763),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: Color(0xFFA2C785),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.palette,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.h32,
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem(
    String title,
    String value,
    double progress,
    IconData icon,
    Color iconBgColor,
    Color iconColor,
  ) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2), // Using provided color logic
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          AppSpacing.w16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: FontManager.bodyMedium(
                        color: const Color(0xFF535763),
                      ),
                    ),
                    Text(
                      value,
                      style: FontManager.bodyMedium(
                        color: const Color(0xFF535763),
                      ),
                    ),
                  ],
                ),
                AppSpacing.h8,
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.greyE8,
                    color: Color(0xFFF06A6A), // Reddish color from image
                    minHeight: 8.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Gradient Background
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blue.withOpacity(0.2), Colors.blue.withOpacity(0.0)],
    );
    final paintFill = Paint()..shader = gradient.createShader(rect);

    // Line Path
    final path = Path();
    // Move to start point
    path.moveTo(0, size.height * 0.2);
    // Draw smooth curve (simulated points)
    path.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.1,
      size.width * 0.2,
      size.height * 0.05,
    ); // Peak
    path.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.1,
      size.width * 0.5,
      size.height * 0.15,
    ); // Dip
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.2,
      size.width * 0.8,
      size.height * 0.05,
    ); // High
    path.lineTo(size.width, size.height * 0.02); // End high

    // Draw the line
    final paintLine = Paint()
      ..color = Colors.lightBlue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paintLine);

    // Close path for fill
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paintFill);

    // Draw Points
    final paintDot = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.fill;
    final paintDotInner = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final points = [
      Offset(0, size.height * 0.2),
      Offset(size.width * 0.2, size.height * 0.05),
      Offset(size.width * 0.5, size.height * 0.15),
      Offset(size.width * 0.8, size.height * 0.05),
      Offset(size.width, size.height * 0.02),
    ];

    for (var point in points) {
      canvas.drawCircle(point, 5, paintDot);
      canvas.drawCircle(point, 3, paintDotInner);
    }

    // Draw Axis Labels (Simplified)
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Y Axis Labels
    final yLabels = ['100', '80', '60', '40', '20'];
    for (int i = 0; i < yLabels.length; i++) {
      textPainter.text = TextSpan(
        text: yLabels[i],
        style: TextStyle(color: Colors.grey, fontSize: 10.sp),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(-25, (size.height / 5) * i));
    }

    // X Axis Labels
    final xLabels = ['15', '16', '17', '18', '19', '20'];
    final xSpacing = size.width / (xLabels.length - 1);
    for (int i = 0; i < xLabels.length; i++) {
      textPainter.text = TextSpan(
        text: xLabels[i],
        style: TextStyle(color: Colors.grey, fontSize: 10.sp),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(xSpacing * i - 5, size.height + 10));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
