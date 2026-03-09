// import 'package:flutter/material.dart';
// import 'package:mobile_app_dea/core/gen/assets.gen.dart';

// class PoupProssing extends StatefulWidget {
//   const PoupProssing({super.key});

//   @override
//   State<PoupProssing> createState() => _PoupProssingState();
// }

// class _PoupProssingState extends State<PoupProssing> {
//   String selectedLanguage = "";
//   String selectedVoice = "";

//   // -------------------------------
//   // LANGUAGE BOTTOM SHEET
//   // -------------------------------
//   void _showLanguageSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (_) {
//         return Transform.translate(
//           offset: const Offset(0, -20), // Move up 20px
//           child: Container(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//             ),
//             padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Select Language',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const Divider(),

//                 _languageTile("English"),
//                 _languageTile("Deutsch"),
//                 _languageTile("Español"),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _languageTile(String title) {
//     return ListTile(
//       title: Text(
//         title,
//         style: TextStyle(
//           fontWeight: selectedLanguage == title
//               ? FontWeight.bold
//               : FontWeight.normal,
//           color: selectedLanguage == title ? Colors.blue : Colors.black,
//         ),
//       ),
//       trailing: selectedLanguage == title
//           ? const Icon(Icons.check, color: Colors.blue)
//           : null,
//       onTap: () {
//         setState(() => selectedLanguage = title);
//         Navigator.pop(context);
//         _showVoiceSheet(context);
//       },
//     );
//   }

//   // -------------------------------
//   // VOICE BOTTOM SHEET
//   // -------------------------------
//   void _showVoiceSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (_) {
//         return Transform.translate(
//           offset: const Offset(0, -20),
//           child: Container(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//             ),
//             padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Choose Voice',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const Divider(),

//                 _voiceTile("Male"),
//                 _voiceTile("Female"),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _voiceTile(String title) {
//     return ListTile(
//       title: Text(
//         title,
//         style: TextStyle(
//           fontWeight: selectedVoice == title
//               ? FontWeight.bold
//               : FontWeight.normal,
//           color: selectedVoice == title ? Colors.blue : Colors.black,
//         ),
//       ),
//       trailing: selectedVoice == title
//           ? const Icon(Icons.check, color: Colors.blue)
//           : null,
//       onTap: () {
//         setState(() => selectedVoice = title);
//         Navigator.pop(context);
//       },
//     );
//   }

//   // -------------------------------
//   // MAIN SCREEN UI
//   // -------------------------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: Assets.svgImages.popupScreeLiner.image().image,
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                 child: Column(
//                   children: [
//                     // ✅ FIXED HEADER
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Left side - Profile/Avatar
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Container(
//                               width: 24,
//                               height: 24,
//                               child: Image.asset(
//                                 "assets/images/blu_cross.png",
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ],
//                         ),

//                         // Right side - AI Label
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             SizedBox(width: 8),
//                             Image.asset(
//                               "assets/images/AI.png",
//                               height: 28,
//                               fit: BoxFit.contain,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: 20),

//                     SizedBox(height: 40),
//                     Container(
//                       width: 324.39,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         spacing: 25,
//                         children: [
//                           SizedBox(
//                             width: 273,
//                             child: Text(
//                               'SHARE HOW YOU FEEL',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: const Color(
//                                   0xFF011F54,
//                                 ) /* Text-text-default */,
//                                 fontSize: 52,
//                                 fontFamily: 'Wosker',
//                                 fontWeight: FontWeight.w400,
//                                 height: 0.80,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 324.39,
//                             child: Text(
//                               '     Tell me how you feel today - no pressure, just say it out loud. 🎧',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: const Color(
//                                   0xFF011F54,
//                                 ) /* Text-text-default */,
//                                 fontSize: 18,
//                                 fontFamily: 'Work Sans',
//                                 fontWeight: FontWeight.w400,
//                                 height: 1.40,
//                                 letterSpacing: -0.50,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 40),
//               // TITLE + IMAGES + BUTTONS
//               Column(
//                 children: [
//                   Container(
//                     width: 182.58,
//                     height: 182.58,
//                     decoration: ShapeDecoration(
//                       gradient: RadialGradient(
//                         center: Alignment(0.50, 0.50),
//                         radius: 0.73,
//                         colors: [
//                           const Color(0xFF7270F3),
//                           const Color(0xFF3F3CD6),
//                         ],
//                       ),
//                       shape: OvalBorder(),
//                       shadows: [
//                         BoxShadow(
//                           color: Color(0x995550FF),
//                           blurRadius: 19.60,
//                           offset: Offset(0, 0),
//                           spreadRadius: 11,
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 60),
//                   Text(
//                     'You didn’t say anything?\nHold and speak again.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: const Color(0xFF4542EB) /* Text-text-primary */,
//                       fontSize: 18,
//                       fontFamily: 'Work Sans',
//                       fontWeight: FontWeight.w600,
//                       height: 1.40,
//                       letterSpacing: -0.90,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                 ],
//               ),

//               const Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/screen/home/swaipe_to_talk/screen_flow_controller.dart';

class PoupProssing extends StatefulWidget {
  const PoupProssing({super.key});

  @override
  State<PoupProssing> createState() => _PoupProssingState();
}

class _PoupProssingState extends State<PoupProssing>
    with SingleTickerProviderStateMixin, ScreenFlowMixin {
  String selectedLanguage = "";
  String selectedVoice = "";

  late AnimationController _animationController;

  @override
  FlowScreen get flowScreen => FlowScreen.poupProssing;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    // Initialize automatic navigation flow (3 seconds delay)
    initializeFlow(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // -------------------------------
  // LANGUAGE BOTTOM SHEET
  // -------------------------------

  // -------------------------------
  // VOICE BOTTOM SHEET
  // -------------------------------

  // -------------------------------
  // WAVE LOADING ANIMATION
  // -------------------------------
  Widget _buildWaveCircle(int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        // Each circle has a delay based on its index
        final delay = index * 0.2;
        final animValue = (_animationController.value - delay) % 1.0;

        // Scale animation (wave effect)
        final scale = 0.6 + (0.4 * (1 - (animValue * 2 - 1).abs()));

        // Opacity animation
        final opacity = 0.4 + (0.6 * (1 - (animValue * 2 - 1).abs()));

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: 12,
              height: 12,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(),
              ),
            ),
          ),
        );
      },
    );
  }

  // -------------------------------
  // MAIN SCREEN UI
  // -------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.svgImages.popupScreeLiner.image().image,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    // HEADER
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Image.asset(
                                  "assets/images/blu_cross.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 8),
                              Image.asset(
                                "assets/images/AI.png",
                                height: 28,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 324.39,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 273,
                            child: Text(
                              'SHARE HOW YOU FEEL',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF011F54),
                                fontSize: 52,
                                fontFamily: 'Wosker',
                                fontWeight: FontWeight.w400,
                                height: 0.80,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          const SizedBox(
                            width: 324.39,
                            child: Text(
                              '     Tell me how you feel today - no pressure, just say it out loud. 🎧',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF011F54),
                                fontSize: 18,
                                fontFamily: 'Work Sans',
                                fontWeight: FontWeight.w400,
                                height: 1.40,
                                letterSpacing: -0.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // GRADIENT CIRCLE WITH WAVE ANIMATION
              Column(
                children: [
                  Container(
                    width: 182.58,
                    height: 182.58,
                    decoration: ShapeDecoration(
                      gradient: const RadialGradient(
                        center: Alignment(0.50, 0.50),
                        radius: 0.73,
                        colors: [Color(0xFF7270F3), Color(0xFF3F3CD6)],
                      ),
                      shape: const OvalBorder(),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x995550FF),
                          blurRadius: 19.60,
                          offset: Offset(0, 0),
                          spreadRadius: 11,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: _buildWaveCircle(index),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  const Text(
                    'I’m listening… take your time 💭',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF4542EB),
                      fontSize: 18,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                      letterSpacing: -0.90,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
