// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_app_dea/core/gen/assets.gen.dart';
// import 'package:mobile_app_dea/themes/text_styles.dart';
// import 'package:mobile_app_dea/utlis/color_palette/color_palette.dart';
// import 'package:mobile_app_dea/widget/custom_button.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   String _selectedName = '';
//   final String _selectedGender = '';

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   // void _completeOnboarding() {
//   //   context.push("/popupSpeking");
//   // }

//   // bool _canProceed() {
//   //   if (_currentPage == 0) {
//   //     return _selectedName.isNotEmpty;
//   //   } else if (_currentPage == 1) {
//   //     return _selectedGender.isNotEmpty;
//   //   }
//   //   return false;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFF5E6),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: PageView(
//                 controller: _pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 onPageChanged: (index) {
//                   setState(() {
//                     _currentPage = index;
//                   });
//                 },
//                 children: [
//                   NameSelectionPage(
//                     selectedName: _selectedName,
//                     onNameSelected: (name) {
//                       setState(() {
//                         _selectedName = name;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             // _buildNextButton(),
//             GestureDetector(
//               onTap: () => context.push("/popupSpeking"),
//               child: Container(
//                 width: 334,
//                 height: 116,
//                 padding: const EdgeInsets.only(
//                   top: 8,
//                   left: 40,
//                   right: 8,
//                   bottom: 8,
//                 ),
//                 decoration: ShapeDecoration(
//                   color: const Color(0xFFFF8F26) /* Background-bg-secondary */,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(999),
//                   ),
//                   shadows: [
//                     BoxShadow(
//                       color: Color(0x070A0C12),
//                       blurRadius: 6,
//                       offset: Offset(0, 4),
//                       spreadRadius: -2,
//                     ),
//                     BoxShadow(
//                       color: Color(0x140A0C12),
//                       blurRadius: 16,
//                       offset: Offset(0, 12),
//                       spreadRadius: -4,
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 170,
//                       child: Text(
//                         'Next',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.workSans(
//                           color: const Color(0xFF011F54),
//                           fontSize: 28,
//                           fontWeight: FontWeight.w900,
//                           height: 0.8,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 20), // spacing
//                     Container(
//                       padding: const EdgeInsets.all(16), // আগে 24 ছিল
//                       decoration: ShapeDecoration(
//                         color: const Color(0xFF011F54),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(999),
//                         ),
//                       ),
//                       child: SvgPicture.asset(
//                         Assets.svgIcons.startLetsGo.path,
//                         width: 60,
//                         height: 60,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Back button
//           GestureDetector(
//             onTap: () {
//               context.push("/onbordingFetures");
//             },
//             child: SizedBox(
//               height: 56,
//               width: 56,
//               child: CircleAvatar(
//                 child: Assets.svgIcons.backIconSvg.svg(height: 56, width: 56),
//               ),
//             ),
//           ),

//           const SizedBox(width: 20),

//           // Progress bar
//           Expanded(
//             child: Container(
//               height: 10,
//               decoration: ShapeDecoration(
//                 color: const Color(0xFFC3DBFF),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(999),
//                 ),
//               ),
//               child: FractionallySizedBox(
//                 alignment: Alignment.centerLeft,
//                 widthFactor: 0.5,
//                 child: Container(
//                   decoration: ShapeDecoration(
//                     color: const Color(0xFF3D87F5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(999),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(width: 15),

//           // Progress text
//           Text(
//             '6/6',
//             style: GoogleFonts.workSans(
//               color: const Color(0xFF4C586E),
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               height: 1.40,
//             ),
//           ),

//           // Skip button
//           GestureDetector(
//             onTap: () {
//               context.push("/onboardingScreen");
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Text(
//                 'Skip',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.workSans(
//                   color: const Color(0xFF011F54),
//                   fontSize: 18,
//                   fontWeight: FontWeight.w900,
//                   height: 0.80,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildNextButton() {
//   //   return CustomNextButton(
//   //     isEnabled: _canProceed(),
//   //     onTap: () {
//   //       context.push("/popupSpeking");
//   //     },
//   //     buttonText: 'NEXT',
//   //     iconPath: Assets.svgIcons.startLetsGo.path,
//   //     textStyle: AppsTextStyles.letsStartNext.copyWith(fontSize: 32),
//   //   );
//   // }
// }

// class NameSelectionPage extends StatefulWidget {
//   final String selectedName;
//   final Function(String) onNameSelected;

//   const NameSelectionPage({
//     super.key,
//     required this.selectedName,
//     required this.onNameSelected,
//   });

//   @override
//   State<NameSelectionPage> createState() => _NameSelectionPageState();
// }

// class _NameSelectionPageState extends State<NameSelectionPage>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController _nameController = TextEditingController();
//   late AnimationController _bounceController;
//   late Animation<double> _bounceAnimation;

//   bool _showTextField = false;
//   int _currentAvatarIndex = 0;
//   bool _showNameDisplay = true;

//   // Avatar list with PNG images
//   final List<AvatarData> avatars = [
//     AvatarData(
//       name: 'KNOTTY',
//       assetPath: 'assets/svg_images/A.png',
//       isLottie: false,
//     ),
//     AvatarData(
//       name: 'BLOOBY',
//       assetPath: 'assets/svg_images/B.png',
//       isLottie: false,
//     ),
//     AvatarData(
//       name: 'FIZZY',
//       assetPath: 'assets/svg_images/C.png',
//       isLottie: false,
//     ),
//     AvatarData(
//       name: 'BOUNCY',
//       assetPath: 'assets/svg_images/D.png',
//       isLottie: false,
//     ),
//     AvatarData(
//       name: 'ZIPPY',
//       assetPath: 'assets/svg_images/E.png',
//       isLottie: false,
//     ),
//     AvatarData(
//       name: 'MELON',
//       assetPath: 'assets/svg_images/F.png',
//       isLottie: false,
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();

//     _bounceController = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );

//     _bounceAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
//       CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
//     );

//     // ✅ FIX: Deferred until after the first frame is built
//     // to avoid calling setState() on the parent during the build phase.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       widget.onNameSelected(avatars[_currentAvatarIndex].name);
//     });

//     _startAutoRotation();
//   }

//   void _startAutoRotation() async {
//     for (int i = 0; i < avatars.length; i++) {
//       if (!mounted) break;

//       await Future.delayed(const Duration(seconds: 3));

//       if (!mounted) break;

//       setState(() {
//         _currentAvatarIndex = (i + 1) % avatars.length;
//       });
//       _bounceController.forward(from: 0);

//       if (!_showTextField) {
//         widget.onNameSelected(avatars[_currentAvatarIndex].name);
//       }
//     }
//   }

//   void _rotateAvatar() {
//     setState(() {
//       _currentAvatarIndex = (_currentAvatarIndex + 1) % avatars.length;
//       _showTextField = false;
//       _nameController.clear();
//     });
//     widget.onNameSelected(avatars[_currentAvatarIndex].name);
//     _bounceController.forward(from: 0);
//   }

//   void _showCustomNameInput() {
//     setState(() {
//       _showTextField = true;
//     });
//   }

//   void _onCustomNameChanged(String value) {
//     if (value.trim().length >= 2 && value.trim().length <= 12) {
//       widget.onNameSelected(value.trim());
//       _bounceController.forward(from: 0);
//     } else if (value.trim().isEmpty) {
//       widget.onNameSelected('');
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _bounceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: 335,
//               child: Text(
//                 'HOW WOULD YOU LIKE TO CALL IT?',
//                 style: GoogleFonts.workSans(
//                   color: const Color(0xFF011F54),
//                   fontSize: 24,
//                   fontWeight: FontWeight.w900,
//                   height: 0.90,
//                   letterSpacing: -0.50,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Give your form a name.',
//               style: AppsTextStyles.passwordDescription,
//             ),
//             const SizedBox(height: 32),

//             // Character with animation and border radius
//             ScaleTransition(
//               scale: _bounceAnimation,
//               child: Container(
//                 height: screenHeight * 0.25,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: Center(
//                   child: CharacterWidget(
//                     assetPath: _showTextField
//                         ? avatars[0].assetPath
//                         : avatars[_currentAvatarIndex].assetPath,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),

//             if (!_showTextField && _showNameDisplay) ...[
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       avatars[_currentAvatarIndex].name,
//                       style: AppsTextStyles.signupText28,
//                     ),
//                     const SizedBox(width: 16),
//                     GestureDetector(
//                       onTap: _rotateAvatar,
//                       child: Image.asset(
//                         Assets.svgIcons.buttonRegular.path,
//                         width: 66,
//                         height: 44,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Center(
//                 child: SizedBox(
//                   width: 320,
//                   height: 50,
//                   child: OutlinedButton.icon(
//                     onPressed: _showCustomNameInput,
//                     icon: Image.asset(
//                       Assets.svgIcons.onBordingPlus.path,
//                       width: 18,
//                       height: 18,
//                     ),
//                     label: Text(
//                       'Choose your own name',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.workSans(
//                         color: const Color(0xFF011F54),
//                         fontSize: 18,
//                         fontWeight: FontWeight.w900,
//                         height: 0.80,
//                       ),
//                     ),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: AppColorsApps.darkBlue,
//                       side: const BorderSide(
//                         color: AppColorsApps.darkBlue,
//                         width: 2,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ] else if (_showTextField) ...[
//               // Custom name input
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 4,
//                 ),
//                 child: TextField(
//                   controller: _nameController,
//                   textAlign: TextAlign.center,
//                   maxLength: 12,
//                   autofocus: true,
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w900,
//                     color: Color(0xFF1E293B),
//                     letterSpacing: 2,
//                   ),
//                   decoration: InputDecoration(
//                     hintText: 'TYPE SOMETHING FUN...',
//                     hintStyle: AppsTextStyles.typeSomeThingHere,
//                     border: InputBorder.none,
//                     counterText: '',
//                   ),
//                   onChanged: _onCustomNameChanged,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Center(
//                 child: SizedBox(
//                   width: 320,
//                   height: 50,
//                   child: OutlinedButton.icon(
//                     onPressed: () {
//                       setState(() {
//                         _showTextField = false;
//                         _showNameDisplay = true;
//                         if (_nameController.text.trim().isEmpty) {
//                           widget.onNameSelected(
//                             avatars[_currentAvatarIndex].name,
//                           );
//                         }
//                       });
//                     },
//                     icon: const Icon(Icons.close, size: 18),
//                     label: Text(
//                       'Back to suggestions',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.workSans(
//                         color: const Color(0xFF011F54),
//                         fontSize: 18,
//                         fontWeight: FontWeight.w900,
//                         height: 0.80,
//                       ),
//                     ),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: AppColorsApps.darkBlue,
//                       side: const BorderSide(
//                         color: AppColorsApps.darkBlue,
//                         width: 2,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],

//             const SizedBox(height: 40),

//             const Center(
//               child: Text(
//                 'You can always rename it later.',
//                 style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Avatar data model
// class AvatarData {
//   final String name;
//   final String assetPath;
//   final bool isLottie;

//   AvatarData({
//     required this.name,
//     required this.assetPath,
//     this.isLottie = false,
//   });
// }

// class CharacterWidget extends StatelessWidget {
//   final String assetPath;

//   const CharacterWidget({super.key, required this.assetPath});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(24),
//       child: Image.asset(assetPath, width: 260, height: 210, fit: BoxFit.cover),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';
import 'package:mobile_app_dea/utlis/color_palette/color_palette.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  String _selectedName = '';

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E6),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {});
                },
                children: [
                  NameSelectionPage(
                    selectedName: _selectedName,
                    onNameSelected: (name) {
                      setState(() {
                        _selectedName = name;
                      });
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => context.push("/popupSpeking"),
              child: Container(
                width: 334,
                height: 116,
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 40,
                  right: 8,
                  bottom: 8,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFF8F26),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x070A0C12),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                      spreadRadius: -2,
                    ),
                    BoxShadow(
                      color: Color(0x140A0C12),
                      blurRadius: 16,
                      offset: Offset(0, 12),
                      spreadRadius: -4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 170,
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.workSans(
                          color: const Color(0xFF011F54),
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          height: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF011F54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: SvgPicture.asset(
                        Assets.svgIcons.startLetsGo.path,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({double progress = 1.0}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 🔙 Back Button
          GestureDetector(
            onTap: () {
              context.push("/onbordingFetures");
            },
            child: SizedBox(
              height: 56,
              width: 56,
              child: CircleAvatar(
                child: Assets.svgIcons.backIconSvg.svg(height: 56, width: 56),
              ),
            ),
          ),
          const SizedBox(width: 20),

          /// 📊 Progress Bar
          Expanded(
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0), // 🔹 Background Color
                borderRadius: BorderRadius.circular(999),
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress, // 0.0 to 1.0
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF3D87F5), // 🔵 Progress Color
                        // gradient: const LinearGradient(
                        //   colors: [
                        //     Color(0xFF3D87F5), // 🔵 Start Color
                        //     Color(0xFF6FB1FF), // 🔵 End Color
                        //   ],
                        // ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 15),

          /// Step Text
          const Text(
            '6/6',
            style: TextStyle(
              color: Color(0xFF4C586E),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),

          /// Skip Button
          GestureDetector(
            onTap: () {
              context.push("/onboardingScreen");
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      ),
    );
  }

  // Widget _buildHeader() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         GestureDetector(
  //           onTap: () {
  //             context.push("/onbordingFetures");
  //           },
  //           child: SizedBox(
  //             height: 56,
  //             width: 56,
  //             child: CircleAvatar(
  //               child: Assets.svgIcons.backIconSvg.svg(height: 56, width: 56),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(width: 20),
  //         Expanded(
  //           child: Container(
  //             height: 10,
  //             decoration: ShapeDecoration(
  //               color: const Color(0xFFC3DBFF),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(999),
  //               ),
  //             ),
  //             child: FractionallySizedBox(
  //               alignment: Alignment.centerLeft,
  //               widthFactor: 0.5,
  //               child: Container(
  //                 decoration: ShapeDecoration(
  //                   color: const Color(0xFF3D87F5),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(999),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(width: 15),
  //         Text(
  //           '6/6',
  //           style: GoogleFonts.workSans(
  //             color: const Color(0xFF4C586E),
  //             fontSize: 12,
  //             fontWeight: FontWeight.w400,
  //             height: 1.40,
  //           ),
  //         ),
  // GestureDetector(
  //   onTap: () {
  //     context.push("/onboardingScreen");
  //   },
  //   child: Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //     child: Text(
  //       'Skip',
  //       textAlign: TextAlign.center,
  //       style: GoogleFonts.workSans(
  //         color: const Color(0xFF011F54),
  //         fontSize: 18,
  //         fontWeight: FontWeight.w900,
  //         height: 0.80,
  //       ),
  //     ),
  //   ),
  // ),
  //       ],
  //     ),
  //   );
  // }
}

// ─────────────────────────────────────────────
class NameSelectionPage extends StatefulWidget {
  final String selectedName;
  final Function(String) onNameSelected;

  const NameSelectionPage({
    super.key,
    required this.selectedName,
    required this.onNameSelected,
  });

  @override
  State<NameSelectionPage> createState() => _NameSelectionPageState();
}

class _NameSelectionPageState extends State<NameSelectionPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  bool _showTextField = false;
  int _currentAvatarIndex = 0;
  bool _showNameDisplay = true;

  final List<AvatarData> avatars = [
    AvatarData(name: 'KNOTTY', assetPath: 'assets/svg_images/A.png'),
    AvatarData(name: 'BLOOBY', assetPath: 'assets/svg_images/B.png'),
    AvatarData(name: 'FIZZY', assetPath: 'assets/svg_images/C.png'),
    AvatarData(name: 'BOUNCY', assetPath: 'assets/svg_images/D.png'),
    AvatarData(name: 'ZIPPY', assetPath: 'assets/svg_images/E.png'),
    AvatarData(name: 'MELON', assetPath: 'assets/svg_images/F.png'),
  ];

  @override
  void initState() {
    super.initState();

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onNameSelected(avatars[_currentAvatarIndex].name);
    });

    _startAutoRotation();
  }

  void _startAutoRotation() async {
    for (int i = 0; i < avatars.length; i++) {
      if (!mounted) break;
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) break;
      setState(() {
        _currentAvatarIndex = (i + 1) % avatars.length;
      });
      _bounceController.forward(from: 0);
      if (!_showTextField) {
        widget.onNameSelected(avatars[_currentAvatarIndex].name);
      }
    }
  }

  void _rotateAvatar() {
    setState(() {
      _currentAvatarIndex = (_currentAvatarIndex + 1) % avatars.length;
      _showTextField = false;
      _nameController.clear();
    });
    widget.onNameSelected(avatars[_currentAvatarIndex].name);
    _bounceController.forward(from: 0);
  }

  void _showCustomNameInput() {
    setState(() {
      _showTextField = true;
    });
  }

  void _onCustomNameChanged(String value) {
    if (value.trim().length >= 2 && value.trim().length <= 12) {
      widget.onNameSelected(value.trim());
      _bounceController.forward(from: 0);
    } else if (value.trim().isEmpty) {
      widget.onNameSelected('');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title ──
            SizedBox(
              width: screenWidth * 0.85,
              child: Text(
                'HOW WOULD YOU LIKE TO CALL IT?',
                style: GoogleFonts.workSans(
                  color: const Color(0xFF011F54),
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  height: 0.90,
                  letterSpacing: -0.50,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Give your form a name.',
              style: AppsTextStyles.passwordDescription,
            ),
            const SizedBox(height: 16),

            // ── Avatar ──
            Flexible(
              flex: 4,
              child: ScaleTransition(
                scale: _bounceAnimation,
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: 120,
                    maxHeight: 260,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: CharacterWidget(
                      assetPath: _showTextField
                          ? avatars[0].assetPath
                          : avatars[_currentAvatarIndex].assetPath,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Name Display / TextField ──
            if (!_showTextField && _showNameDisplay) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    avatars[_currentAvatarIndex].name,
                    style: AppsTextStyles.signupText28,
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: _rotateAvatar,
                    child: Image.asset(
                      Assets.svgIcons.buttonRegular.path,
                      width: 66,
                      height: 44,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: _showCustomNameInput,
                    icon: Image.asset(
                      Assets.svgIcons.onBordingPlus.path,
                      width: 18,
                      height: 18,
                    ),
                    label: Text(
                      'Choose your own name',
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF011F54),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        height: 0.80,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColorsApps.darkBlue,
                      side: const BorderSide(
                        color: AppColorsApps.darkBlue,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ] else if (_showTextField) ...[
              TextField(
                controller: _nameController,
                textAlign: TextAlign.center,
                maxLength: 12,
                autofocus: true,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                  letterSpacing: 2,
                ),
                decoration: InputDecoration(
                  hintText: 'TYPE SOMETHING FUN...',
                  hintStyle: AppsTextStyles.typeSomeThingHere,
                  border: InputBorder.none,
                  counterText: '',
                ),
                onChanged: _onCustomNameChanged,
              ),
              const SizedBox(height: 12),
              Center(
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        _showTextField = false;
                        _showNameDisplay = true;
                        if (_nameController.text.trim().isEmpty) {
                          widget.onNameSelected(
                            avatars[_currentAvatarIndex].name,
                          );
                        }
                      });
                    },
                    icon: const Icon(Icons.close, size: 18),
                    label: Text(
                      'Back to suggestions',
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF011F54),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        height: 0.80,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColorsApps.darkBlue,
                      side: const BorderSide(
                        color: AppColorsApps.darkBlue,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],

            // ── Spacer + Bottom hint ──
            const Spacer(),
            const Center(
              child: Text(
                'You can always rename it later.',
                style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
class AvatarData {
  final String name;
  final String assetPath;
  final bool isLottie;

  AvatarData({
    required this.name,
    required this.assetPath,
    this.isLottie = false,
  });
}

class CharacterWidget extends StatelessWidget {
  final String assetPath;

  const CharacterWidget({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(assetPath, width: 260, height: 210, fit: BoxFit.cover),
    );
  }
}
