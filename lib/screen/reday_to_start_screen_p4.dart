import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/utlis/color_palette/color_palette.dart';

class ReadyToStartScreen extends StatefulWidget {
  const ReadyToStartScreen({super.key});

  @override
  State<ReadyToStartScreen> createState() => _ReadyToStartScreenState();
}

class _ReadyToStartScreenState extends State<ReadyToStartScreen> {
  bool _isWelcomeBack = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsApps.lightBlueBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 57,
                  height: 55,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.black87,
                        size: 34,
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Illustration - tap to toggle
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isWelcomeBack = !_isWelcomeBack;
                  });
                },
                child: Center(
                  child: _isWelcomeBack
                      ? Assets.svgImages.welcomeBack.svg(height: 180)
                      : Assets.svgImages.readyToStart.svg(height: 180),
                ),
              ),
              const Spacer(),

              // Google Button
              SizedBox(
                width: double.infinity,
                height: 74,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A46FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  icon: Assets.svgIcons.googleIcon.svg(height: 24, width: 24),
                  label: Text(
                    'Continue with Google',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                      color: const Color(0xFFFFFDF7), // Text-light
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      height: 0.80,
                    ),
                  ),
                  onPressed: () {
                    context.push('/signInScreen');
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Apple Button
              SizedBox(
                width: double.infinity,
                height: 74,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A46FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  icon: Assets.svgIcons.appleIcon.svg(height: 24, width: 24),
                  label: Text(
                    'Continue with Apple',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                      color: const Color(0xFFFFFDF7), // Text-light
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      height: 0.80,
                    ),
                  ),
                  onPressed: () {
                    context.push('/signInScreen');
                  },
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: Text.rich(
                  TextSpan(
                    style: GoogleFonts.workSans(
                      fontSize: 12,
                      height: 1.60,
                      color: const Color(0xFF4C586E),
                    ),
                    children: [
                      const TextSpan(
                        text: 'By signing up, you agree to Nowlii’s ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy ',
                        style: GoogleFonts.workSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4542EB),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: '  & '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: GoogleFonts.workSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4542EB),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
