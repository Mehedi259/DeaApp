// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_app_dea/core/gen/assets.gen.dart';
// import 'package:mobile_app_dea/themes/text_styles.dart';

// class EntryScreen extends StatelessWidget {
//   const EntryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image - Fixed to top
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             // height: MediaQuery.of(context).size.height * 0.50,
//             child: Image.asset(
//               Assets.svgImages.enttryTwoScrenn.path,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),

//           // Logo overlay on top
//           // Positioned(
//           //   top: 30,
//           //   left: 0,
//           //   right: 0,
//           //   child: Center(
//           //     child: Container(
//           //       padding: const EdgeInsets.symmetric(
//           //         horizontal: 20,
//           //         vertical: 8,
//           //       ),
//           //       child: Assets.svgIcons.nowlnLogo.svg(
//           //         width: 140,
//           //         height: 80,
//           //         fit: BoxFit.contain,
//           //       ),
//           //     ),
//           //   ),
//           // ),

//           // Bottom rounded container with content
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.50,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Color(0xFF4542EB),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24.0,
//                   vertical: 30.0,
//                 ),
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       /// Heading
//                       SizedBox(height: 17.0),
//                       SizedBox(
//                         width: 335,
//                         child: Text(
//                           'LET’S GET THINGS DONE.',
//                           style: TextStyle(
//                             color: const Color(
//                               0xFFFFFDF7,
//                             ) /* Text-text-light */,
//                             fontSize: 48,
//                             fontFamily: 'Wosker',
//                             fontWeight: FontWeight.w400,
//                             height: 0.80,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8.0),

//                       /// Subtitle
//                       SizedBox(
//                         width: 335,
//                         child: Text(
//                           "Your daily push to start - with real voice support.",
//                           style: AppsTextStyles.workSansBodyEntryScreen,
//                         ),
//                       ),
//                       const SizedBox(height: 24.0),

//                       /// Get Started Button
//                       SizedBox(
//                         width: double.infinity,
//                         height: 80,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFFF8A00),
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                           onPressed: () {
//                             context.push("/welcomeScreen");
//                           },
//                           child: Text(
//                             'Get Started',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.workSans(
//                               color: const Color(0xFF011F54),
//                               fontSize: 24,
//                               fontWeight: FontWeight.w900,
//                               height: 1.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12.0),

//                       /// Have an Account Button
//                       SizedBox(
//                         width: double.infinity,
//                         height: 80,
//                         child: OutlinedButton(
//                           style: OutlinedButton.styleFrom(
//                             side: const BorderSide(
//                               color: Colors.white,
//                               width: 3,
//                             ),
//                             backgroundColor: Colors.transparent,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                           onPressed: () {
//                             context.push("/signInScreen");
//                           },
//                           child: Text(
//                             'Have an account?',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.workSans(
//                               color: const Color(0xFFFFFDF7),
//                               fontSize: 24,
//                               fontWeight: FontWeight.w900,
//                               height: 1.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              Assets.svgImages.enttryTwoScrenn.path,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Bottom rounded container
          Positioned(
            top: h * 0.50,
            left: 0,
            right: 0,
            bottom: 0,
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

                    /// Heading
                    Text(
                      'LET\'S GET\nTHINGS DONE.',
                      style: TextStyle(
                        color: const Color(0xFFFFFDF7),
                        fontSize: w * 0.13,
                        fontFamily: 'Wosker',
                        fontWeight: FontWeight.w400,
                        height: 0.85,
                      ),
                    ),
                    SizedBox(height: h * 0.01),

                    /// Subtitle
                    Text(
                      "Your daily push to start - with real \n voice support.",
                      style: AppsTextStyles.workSansBodyEntryScreen.copyWith(
                        fontSize: w * 0.0410,
                      ),
                    ),

                    const Spacer(),

                    /// Get Started Button
                    SizedBox(
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
                    SizedBox(height: h * 0.015),

                    /// Have an Account Button
                    SizedBox(
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
                    SizedBox(height: h * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
