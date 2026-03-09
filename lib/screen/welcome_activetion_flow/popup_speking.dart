import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';

class PopupSpeking extends StatefulWidget {
  const PopupSpeking({super.key});

  @override
  State<PopupSpeking> createState() => _PopupSpekingState();
}

class _PopupSpekingState extends State<PopupSpeking> {
  int _popupStep = 0; // 0 = no popup, 1 = mic, 2 = speech recognition

  @override
  void initState() {
    super.initState();
    // Page load হওয়ার সাথে সাথে প্রথম popup দেখাবে
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPopup(1);
    });
  }

  void _nextStep() {
    setState(() {
      _popupStep++;
    });
  }

  void _showPopup(int step) {
    setState(() {
      _popupStep = step;
    });
  }

  void _closePopup() {
    setState(() {
      _popupStep = 0;
    });
  }

  Widget _buildPopupContent() {
    if (_popupStep == 1) {
      // Microphone permission popup
      return Container(
        width: 290,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '"Nowlii" Would Like To\nAccess The Microphone',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Nowlii will listen once you say\nsomething. Your voice stays private.\nAlways.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Container(height: 0.5, color: Colors.white.withValues(alpha: 0.2)),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _closePopup,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      "Don't Allow",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF0A84FF),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 0.5,
                  height: 44,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: _nextStep,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      'Allow',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0A84FF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (_popupStep == 2) {
      // Speech recognition permission popup
      return Container(
        width: 290,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '"Nowlii" Would Like To Access\nSpeech Recognition',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Nowlii uses your voice to personalize\nsessions and help you stay on track.\nSpeech data may be processed by\nApple to recognize and interpret your\ninput.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your voice stays private and is never\nstored or shared.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Nowlii listens only to help you - your\nvoice never leaves your device.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Container(height: 0.5, color: Colors.white),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _closePopup,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      "Don't Allow",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF0A84FF),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 0.5,
                  height: 44,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _closePopup();
                      // Navigate to the next page
                      context.push("/procrastinationScreen");
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      'Allow',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0A84FF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content   popupScreeLiner
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.svgImages.popupSpeaking.image().image,
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Close button
                      GestureDetector(
                        onTap: () {
                          context.pop("/onboardingScreen");
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close, size: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: SizedBox(
                          width: 273,
                          child: Text(
                            'YOU’RE ALL SET, JULIE!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(
                                0xFF011F54,
                              ) /* Text-text-default */,
                              fontSize: 46,
                              fontFamily: 'Wosker',
                              fontWeight: FontWeight.w400,
                              height: 0.80,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: SizedBox(
                          width: 274,
                          child: Text(
                            'Your Nowlii is ready to help you start strong.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.workSans(
                              color: const Color(
                                0xFF011F54,
                              ), // Text-text-default
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              height: 1.40,
                              letterSpacing: -0.50,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Card section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC3DBFF),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 270,
                              child: Text(
                                'Let’s do a quick voice check!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                  color: const Color(0xFF011F54),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  height: 1.20,
                                  letterSpacing: -1,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 289,
                              child: Text(
                                'Tell me how you feel today - no pressure, just say it out loud. 🎧',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                  color: const Color(
                                    0xFF011F54,
                                  ), // Text-text-default
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  height: 1.40,
                                  letterSpacing: -0.50,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),

                            // Tapable image to show popup
                            GestureDetector(
                              onTap: () => _showPopup(1),
                              child: Container(
                                height: 250,
                                width: 250,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/svg_images/popupSpeking.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () => {},
                                    child: Image.asset(
                                      "assets/svg_images/popup_screen_carton.png",
                                      height: 120,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 315,
                              child: Text(
                                'Hold to speak 🎙️\nNowlii will listen once you say something.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                  color: const Color(
                                    0xFF4542EB,
                                  ), // Text-text-primary
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  height: 1.40,
                                  letterSpacing: -0.50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Popup overlay
          if (_popupStep > 0)
            Container(
              color: Colors.black.withValues(alpha: 0.85),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: _buildPopupContent(),
            ),
        ],
      ),
    );
  }
}

// Placeholder for the next page
class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next Page')),
      body: const Center(
        child: Text(
          'You have navigated to the next page!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
