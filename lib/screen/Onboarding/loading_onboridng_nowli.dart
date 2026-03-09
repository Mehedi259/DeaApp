import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_dea/core%20/app_routes/app_routes.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';

class LoadingOnboridngNowli extends StatefulWidget {
  const LoadingOnboridngNowli({super.key});

  @override
  State<LoadingOnboridngNowli> createState() => _LoadingOnboridngNowliState();
}

class _LoadingOnboridngNowliState extends State<LoadingOnboridngNowli> {
  @override
  void initState() {
    super.initState();
    // Navigate to onboarding features after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(AppRoutespath.onbordingFetures);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFDCEEFF), // light blue background
      body: Center(child: LoadingContent()),
    );
  }
}

class LoadingContent extends StatefulWidget {
  const LoadingContent({super.key});

  @override
  State<LoadingContent> createState() => _LoadingContentState();
}

class _LoadingContentState extends State<LoadingContent> {
  int _currentDot = 0;

  @override
  void initState() {
    super.initState();
    _startDotAnimation();
  }

  void _startDotAnimation() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 250));
      if (mounted) {
        setState(() {
          _currentDot = (_currentDot + 1) % 4;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Animated dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: index == _currentDot
                    ? Colors.blueAccent
                    : Colors.blueAccent.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "Hold on a sec, Nowlii is preparing your space...",
            textAlign: TextAlign.center,
            style: AppsTextStyles.extraBold32Centered,
          ),
        ),
      ],
    );
  }
}
