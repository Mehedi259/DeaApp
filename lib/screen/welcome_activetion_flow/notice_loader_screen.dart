import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class NoticeLoaderScreen extends StatefulWidget {
  const NoticeLoaderScreen({super.key});

  @override
  State<NoticeLoaderScreen> createState() => _NoticeLoaderScreenState();
}

class _NoticeLoaderScreenState extends State<NoticeLoaderScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        context.push("/homeScreen");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF1),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 60.sp,
                height: 60.sp,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9228),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Color(0xFF011F54),
                  size: 48,
                ),
              ),
              SizedBox(height: 32.sp),

              // Title
              SizedBox(
                width: 295,
                child: Text(
                  textAlign: TextAlign.center,
                  'Noted! Thanks for \n your honesty!',
                  style: GoogleFonts.workSans(
                    color: const Color(0xFF011F54), // Text-text-default
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    height: 1.40,
                    letterSpacing: -0.50,
                  ),
                ),
              ),
              SizedBox(height: 16.sp),

              // Subtitle
              Text(
                "Fuzzy's here to make today \n a little easier.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
