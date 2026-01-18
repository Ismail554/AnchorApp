import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';

class LegalScreen extends StatelessWidget {
  final String title;

  // Content could be passed or hardcoded based on type
  // For simplicity, using a static long text if not provided
  final String? content;

  const LegalScreen({super.key, required this.title, this.content});

  @override
  Widget build(BuildContext context) {
    // Dummy content based on the provided image text
    final String displayContent =
        content ??
        """
1. Welcome to Ai. By using our services, you agree to abide by the terms and conditions outlined below. These terms govern your access to and
2. use of Ai tools and services, so please review them carefully before proceeding.
3. Ai provides innovative tools designed to enhance how you capture and manage voice recordings. Our services include voice-to-text transcription and AI-driven summarization, which are intended
4. for lawful, ethical purposes only. You must ensure compliance with applicable laws, including obtaining consent from all participants when recording conversations. CleverTalk disclaims liability for any misuse of its tools.
""";

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors
                .textSecondary, // Design has greyish title in body, but AppBar standard here
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Text(
          displayContent,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
            height: 1.8,
          ),
        ),
      ),
    );
  }
}
