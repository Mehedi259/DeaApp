import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0.8,
      upperBound: 1.2,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(_controller);

    Future.delayed(Duration(seconds: 5), () {
      // Navigate to the next screen after the splash duration
      if (mounted) {
        context.go('/entryScreen');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4542EB),
      body: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(scale: _scaleAnimation.value, child: child);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50), // Rounded border radius
            child: Image.asset(
              'assets/images/Android App Icon - Squircle.png', // তোমার PNG image path
              width: 154,
              height: 154,
              fit: BoxFit.contain, // optional
            ),
          ),
        ),
      ),
    );
  }
}
