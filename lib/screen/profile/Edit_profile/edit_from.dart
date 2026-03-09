import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';

class EditFrom extends StatefulWidget {
  const EditFrom({super.key});

  @override
  State<EditFrom> createState() => _EditFromState();
}

class _EditFromState extends State<EditFrom> {
  int selectedIndex = -1;
  bool showConfirmation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8ED),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Header with back button, progress bar, and skip
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          Assets.svgIcons.editProfilePng.path,
                          height: 32,
                          width: 32,
                        ),
                      ),
                    ],
                  ),
                ),

                // Title and subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Choose your form",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.workSans(
                        color: Color(0xFF011F54),
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),

                // Character grid - Non-scrollable
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildCharacterCard(
                                  0,
                                  'assets/svg_images/A.png',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildCharacterCard(
                                  1,
                                  'assets/svg_images/B.png',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildCharacterCard(
                                  2,
                                  'assets/svg_images/C.png',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildCharacterCard(
                                  3,
                                  'assets/svg_images/D.png',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildCharacterCard(
                                  4,
                                  'assets/svg_images/E.png',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildCharacterCard(
                                  5,
                                  'assets/svg_images/F.png',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Next button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showConfirmation = true;
                    });
                  },
                  child: Container(
                    width: 335,
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 28,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(
                        0xFF4542EB,
                      ) /* Background-bg-primary */,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 20,
                      children: [
                        Text(
                          'Update',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.workSans(
                            color: const Color(0xFFFFFDF7),
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            height: 0.80,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),

          // Confirmation Dialog
          if (showConfirmation)
            Positioned(
              left: 10,
              right: 10,
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                decoration: ShapeDecoration(
                  color: const Color(
                    0xFFDFEFFF,
                  ) /* Background-bg-primary-light */,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadows: [
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 12,
                  children: [
                    Container(
                      width: 38,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFBEC3CB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 24,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 24,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'Are you sure you want to update your form?',
                                    style: GoogleFonts.workSans(
                                      color: const Color(
                                        0xFF011F54,
                                      ), // Text color
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      height: 1.20,
                                      letterSpacing: -0.50,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 287,
                                  child: Text(
                                    'Your new friend will replace the current one - but don’t worry, your progress stays safe.',
                                    style: GoogleFonts.workSans(
                                      color: const Color(
                                        0xFF4C586E,
                                      ), // Text color
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      height: 1.40,
                                      letterSpacing: -0.50,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 8,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 8,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showConfirmation = false;
                                                  });
                                                },
                                                child: Container(
                                                  height: 66,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 14,
                                                      ),
                                                  decoration: ShapeDecoration(
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 3,
                                                        color: const Color(
                                                          0xFF6A68EF,
                                                        ) /* Border-border-subtle */,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            999,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    spacing: 8,
                                                    children: [
                                                      Text(
                                                        'Cancel',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.workSans(
                                                              color: const Color(
                                                                0xFF4542EB,
                                                              ), // Text color
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              height: 0.80,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  // Handle update confirmation
                                                  // Add your update logic here
                                                  setState(() {
                                                    showConfirmation = false;
                                                  });
                                                },
                                                child: Container(
                                                  height: 65,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 14,
                                                      ),
                                                  decoration: ShapeDecoration(
                                                    color: const Color(
                                                      0xFF4542EB,
                                                    ) /* Background-bg-primary */,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            999,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    spacing: 8,
                                                    children: [
                                                      Text(
                                                        'Yes, update',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.workSans(
                                                              color: const Color(
                                                                0xFFFFFDF7,
                                                              ), // Text color
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              height: 0.80,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCharacterCard(int index, String imagePath) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF4B7BF5) : Colors.transparent,
            width: 8,
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
