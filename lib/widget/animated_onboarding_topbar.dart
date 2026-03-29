import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';

class AnimatedOnboardingTopbar extends StatefulWidget {
  final int currentStep;
  final int totalSteps;
  final String backRoute;
  final String skipRoute;
  final bool isSmallDevice;
  final bool isMediumDevice;
  final double screenWidth;

  const AnimatedOnboardingTopbar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.backRoute,
    required this.skipRoute,
    this.isSmallDevice = false,
    this.isMediumDevice = false,
    required this.screenWidth,
  });

  @override
  State<AnimatedOnboardingTopbar> createState() =>
      _AnimatedOnboardingTopbarState();
}

class _AnimatedOnboardingTopbarState extends State<AnimatedOnboardingTopbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    final targetProgress = widget.currentStep / widget.totalSteps;
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: targetProgress,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => context.push(widget.backRoute),
          child: SizedBox(
            width: widget.isSmallDevice
                ? 44
                : (widget.isMediumDevice ? 50 : 56),
            height: widget.isSmallDevice
                ? 44
                : (widget.isMediumDevice ? 50 : 56),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                Assets.svgIcons.backIconSvg.path,
                width: widget.isSmallDevice
                    ? 44
                    : (widget.isMediumDevice ? 50 : 56),
                height: widget.isSmallDevice
                    ? 44
                    : (widget.isMediumDevice ? 50 : 56),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(width: widget.screenWidth * 0.015),
        Expanded(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                height: widget.isSmallDevice ? 6 : 8,
                decoration: ShapeDecoration(
                  color: const Color(0xFFC3DBFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: Stack(
                  children: [
                    // Progress bar
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _progressAnimation.value,
                      child: Container(
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF3D87F5),
                              Color(0xFF6FB1FF),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                    // Shimmer effect
                    if (_progressAnimation.value > 0)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _progressAnimation.value,
                          child: ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: const [
                                  Colors.transparent,
                                  Colors.white24,
                                  Colors.transparent,
                                ],
                                stops: [
                                  _shimmerAnimation.value - 0.3,
                                  _shimmerAnimation.value,
                                  _shimmerAnimation.value + 0.3,
                                ],
                              ).createShader(bounds);
                            },
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(width: widget.screenWidth * 0.01),
        Text(
          '${widget.currentStep}/${widget.totalSteps}',
          style: GoogleFonts.workSans(
            color: const Color(0xFF4C586E),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.40,
          ),
        ),
        SizedBox(width: widget.screenWidth * 0.015),
        GestureDetector(
          onTap: () => context.push(widget.skipRoute),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.isSmallDevice ? 8 : 12,
              vertical: widget.isSmallDevice ? 6 : 8,
            ),
            child: Text(
              'Skip',
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                color: const Color(0xFF011F54),
                fontSize: 18,
                fontWeight: FontWeight.w900,
                height: 0.80,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
