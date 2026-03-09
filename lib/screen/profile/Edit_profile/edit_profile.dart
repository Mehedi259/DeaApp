import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';
import 'package:mobile_app_dea/utlis/color_palette/color_palette.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController(
    text: 'Julie',
  );
  String _selectedGender = 'Women';

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsApps.iceBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        Assets.svgIcons.editProfilePng.path,
                        height: 32,
                        width: 32,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'EDIT PROFILE',
                      style: AppsTextStyles.googleContinueButton32,
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Profile Picture
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          image: DecorationImage(
                            image: AssetImage(
                              Assets.svgIcons.editProfilePng_.path,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 90,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            Assets.svgIcons.plush.path,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Fizzy Card
                Container(
                  height: 140,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColorsApps.babyBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColorsApps.royalBlue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Image.asset(
                            Assets.svgIcons.readyToMakeTodayCount.path,
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fizzy',
                              style: GoogleFonts.workSans(
                                color: const Color(0xFF011F54),
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                height: 1.20,
                                letterSpacing: -0.50,
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: 205,
                              child: Text(
                                'Pick a new form or \ncustomize your current one',
                                style: GoogleFonts.workSans(
                                  color: const Color(
                                    0xFF011F54,
                                  ), // Text-text-default
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.40,
                                  letterSpacing: -0.50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push("/editNameScreen");
                        },
                        child: Image.asset(
                          Assets.svgIcons.editProfilIcon.path,
                          height: 34,
                          width: 34,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Username Field
                Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: TextField(
                          controller: _usernameController,
                          style: GoogleFonts.workSans(
                            color: const Color(0xFF011F54),
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            height: 1.20,
                            letterSpacing: -0.50,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true, // extra height remove
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Gender Field
                Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: const Color(0xFFFFFEF8),
                            value: _selectedGender,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.check,
                              color: Color(0xFF4542EB),
                            ),
                            selectedItemBuilder: (BuildContext context) {
                              return ['Women', 'Men', 'Another gender'].map((
                                String value,
                              ) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.workSans(
                                      color: const Color(0xFF011F54),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      height: 1.20,
                                      letterSpacing: -0.50,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            items: [
                              DropdownMenuItem(
                                value: 'Women',
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    'Women',
                                    style: GoogleFonts.workSans(
                                      color: const Color(0xFF011F54),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      height: 1.20,
                                      letterSpacing: -0.50,
                                    ),
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Men',
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    'Men',
                                    style: GoogleFonts.workSans(
                                      color: const Color(0xFF011F54),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      height: 1.20,
                                      letterSpacing: -0.50,
                                    ),
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Another gender',
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    'Another gender',
                                    style: GoogleFonts.workSans(
                                      color: const Color(0xFF011F54),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      height: 1.20,
                                      letterSpacing: -0.50,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _selectedGender = newValue;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const Text(
                //   'Gender',
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: Colors.black54,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // const SizedBox(height: 8),
                // Container(
                //   height: 80,
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: DropdownButtonHideUnderline(
                //     child: DropdownButton<String>(
                //       dropdownColor: const Color(0xFFFFFEF8),
                //       value: _selectedGender,
                //       isExpanded: true,
                //       icon: const Icon(Icons.check, color: Color(0xFF4542EB)),
                //       style: const TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold,
                //         color: Color(0xFF4542EB),
                //       ),
                //       selectedItemBuilder: (BuildContext context) {
                //         return ['Women', 'Men', 'Another gender'].map((
                //           String value,
                //         ) {
                //           return Align(
                //             alignment: Alignment.centerLeft,
                //             child: Text(
                //               value,
                //               style: const TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold,
                //                 color: Color(0xFF4542EB),
                //               ),
                //             ),
                //           );
                //         }).toList();
                //       },
                //       items: const [
                //         DropdownMenuItem<String>(
                //           value: 'Women',
                //           child: Text('Women'),
                //         ),
                //         DropdownMenuItem<String>(
                //           value: 'Men',
                //           child: Text('Men'),
                //         ),
                //         DropdownMenuItem<String>(
                //           value: 'Another gender',
                //           child: Text('Another gender'),
                //         ),
                //       ],
                //       onChanged: (String? newValue) {
                //         if (newValue != null) {
                //           setState(() {
                //             _selectedGender = newValue;
                //           });
                //         }
                //       },
                //     ),
                //   ),
                // ),
                const SizedBox(height: 40),

                // Save Button
                Container(
                  width: 335,
                  height: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 28,
                  ),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF4542EB) /* Background-bg-primary */,
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
                        'Save',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
