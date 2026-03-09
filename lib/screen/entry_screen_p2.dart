import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _imageOpacity;
  late Animation<Offset> _containerSlide;
  late Animation<double> _containerOpacity;
  late Animation<Offset> _headingSlide;
  late Animation<double> _headingOpacity;
  late Animation<Offset> _subtitleSlide;
  late Animation<double> _subtitleOpacity;
  late Animation<double> _button1Scale;
  late Animation<double> _button1Opacity;
  late Animation<double> _button2Scale;
  late Animation<double> _button2Opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Image fade in
    _imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    // Container slide up from bottom
    _containerSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _containerOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeOut),
      ),
    );

    // Heading slide from left
    _headingSlide = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    _headingOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.65, curve: Curves.easeOut),
      ),
    );

    // Subtitle slide from left (delayed)
    _subtitleSlide = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.75, curve: Curves.easeOut),
      ),
    );

    // Button 1 scale and fade
    _button1Scale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.65, 0.85, curve: Curves.elasticOut),
      ),
    );

    _button1Opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.65, 0.85, curve: Curves.easeOut),
      ),
    );

    // Button 2 scale and fade (delayed)
    _button2Scale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 0.95, curve: Curves.elasticOut),
      ),
    );

    _button2Opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 0.95, curve: Curves.easeOut),
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
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image with fade
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _imageOpacity,
              child: Image.asset(
                Assets.svgImages.enttryTwoScrenn.path,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Bottom rounded container with slide and fade
          Positioned(
            top: h * 0.50,
            left: 0,
            right: 0,
            bottom: 0,
            child: SlideTransition(
              position: _containerSlide,
              child: FadeTransition(
                opacity: _containerOpacity,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF4542EB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.06,
                      vertical: h * 0.03,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: h * 0.02),

                        /// Heading with slide and fade
                        SlideTransition(
                          position: _headingSlide,
                          child: FadeTransition(
                            opacity: _headingOpacity,
                            child: Text(
                              'LET\'S GET\nTHINGS DONE.',
                              style: TextStyle(
                                color: const Color(0xFFFFFDF7),
                                fontSize: w * 0.13,
                                fontFamily: 'Wosker',
                                fontWeight: FontWeight.w400,
                                height: 0.85,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.01),

                        /// Subtitle with slide and fade
                        SlideTransition(
                          position: _subtitleSlide,
                          child: FadeTransition(
                            opacity: _subtitleOpacity,
                            child: Text(
                              "Your daily push to start - with real \n voice support.",
                              style: AppsTextStyles.workSansBodyEntryScreen
                                  .copyWith(
                                fontSize: w * 0.0410,
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        /// Get Started Button with scale and fade
                        ScaleTransition(
                          scale: _button1Scale,
                          child: FadeTransition(
                            opacity: _button1Opacity,
                            child: SizedBox(
                              width: double.infinity,
                              height: h * 0.10,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF8A00),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                onPressed: () {
                                  context.push("/readyToStartScreen");
                                },
                                child: Text(
                                  'Get Started',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.workSans(
                                    color: const Color(0xFF011F54),
                                    fontSize: w * 0.059,
                                    fontWeight: FontWeight.w900,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.015),

                        /// Have an Account Button with scale and fade
                        ScaleTransition(
                          scale: _button2Scale,
                          child: FadeTransition(
                            opacity: _button2Opacity,
                            child: SizedBox(
                              width: double.infinity,
                              height: h * 0.10,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: w * 0.007,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                onPressed: () {
                                  context.push("/signInScreen");
                                },
                                child: Text(
                                  'Have an account?',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.workSans(
                                    color: const Color(0xFFFFFDF7),
                                    fontSize: w * 0.059,
                                    fontWeight: FontWeight.w900,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.02),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}