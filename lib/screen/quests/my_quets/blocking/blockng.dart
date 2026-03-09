// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_app_dea/core/gen/assets.gen.dart';
// import 'package:mobile_app_dea/themes/text_styles.dart';

// class Blockng extends StatefulWidget {
//   const Blockng({super.key});

//   @override
//   State<Blockng> createState() => _BlockngState();
// }

// class _BlockngState extends State<Blockng> {
//   bool showQuests = false;
//   List<Map<String, dynamic>> quests = [
//     {
//       "emoji": "🧹",
//       "title": "Clean house",
//       "levelText": "Soft steps",
//       "levelColor": const Color(0xFF77D47D),
//       "time": "22:00",
//       "duration": "10 mins",
//     },
//     {
//       "emoji": "📘",
//       "title": "Do homework",
//       "levelText": "Elevated",
//       "levelColor": const Color(0xFFF7A94B),
//       "time": "22:00",
//       "duration": "10 mins",
//     },
//     {
//       "emoji": "🍽️",
//       "title": "Do dishes",
//       "levelText": "Stretch zone",
//       "levelColor": const Color(0xFF6AA7FF),
//       "time": "22:00",
//       "duration": "10 mins",
//     },
//     {
//       "emoji": "🏋️",
//       "title": "Workout",
//       "levelText": "Power move",
//       "levelColor": const Color(0xFFFF5A5A),
//       "time": "22:00",
//       "duration": "10 mins",
//     },
//   ];
//   String selected = "Last 30 days";

//   final List<String> options = [
//     "All time",
//     "Today",
//     "Last 7 days",
//     "Last 30 days",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     if (showQuests) {
//       return _todayQuests();
//     }

//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: SingleChildScrollView(
//           // Wrap the Column with SingleChildScrollView
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // ===== TOP ICON =====
//               Container(
//                 padding: const EdgeInsets.all(18),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Image.asset(
//                   "assets/svg_images/Button Calendar.png",
//                   height: 62,
//                   width: 62,
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // ===== BIG TITLE =====
//               Text(
//                 "No quests",
//                 textAlign: TextAlign.center,
//                 style: AppsTextStyles.workSansExtraBold20Center,
//               ),

//               const SizedBox(height: 12),

//               // ===== SUBTEXT =====
//               Text(
//                 'Look at you — on top of everything!\nIf you ever miss a quest, it’ll show up here.',
//                 textAlign: TextAlign.center,
//                 style: AppsTextStyles.workSansRegularAdd16,
//               ),

//               const SizedBox(height: 24),

//               // ===== CREATE QUEST BUTTON =====
//               SizedBox(
//                 width: 210,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       showQuests = true;
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF4C46F5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Icon(Icons.add, color: Colors.white, size: 24),
//                       const SizedBox(width: 6),
//                       Text(
//                         "Create quest",
//                         style: AppsTextStyles.workSansBlack18Center,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _todayQuests() {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Dropdown Filter
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Container(
//                   decoration: BoxDecoration(),
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       dropdownColor: Colors.white,
//                       value: selected,
//                       icon: const Icon(
//                         Icons.keyboard_arrow_down,
//                         color: Colors.black,
//                       ),
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                       items: options.map((value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           selected = value!;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                 child: Row(
//                   children: [
//                     Image.asset(Assets.svgIcons.x.path, height: 20, width: 20),
//                     SizedBox(width: 6),
//                     Text(
//                       'Clear all',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.workSans(
//                         color: const Color(0xFF4542EB), // Text-text-primary
//                         fontSize: 18,
//                         fontWeight: FontWeight.w900,
//                         height: 0.80,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           // Quest List
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: quests.map((quest) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 16),
//                   child: QuestCard(
//                     emoji: quest["emoji"],
//                     title: quest["title"],
//                     levelText: quest["levelText"],
//                     levelColor: quest["levelColor"],
//                     time: quest["time"],
//                     duration: quest["duration"],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class QuestCard extends StatelessWidget {
//   final String emoji;
//   final String title;
//   final String levelText;
//   final Color levelColor;
//   final String time;
//   final String duration;

//   const QuestCard({
//     super.key,
//     required this.emoji,
//     required this.title,
//     required this.levelText,
//     required this.levelColor,
//     required this.time,
//     required this.duration,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Color(0xFFFFFEF8),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: const Color(0xFFEEDCC5)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // --- Top Row: Missed + Refresh Icon ---
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.check_box_outline_blank,
//                     color: Colors.red.shade400,
//                   ),
//                   const SizedBox(width: 6),
//                   const Text(
//                     "Quest missed",
//                     style: TextStyle(
//                       color: Color(0xFFCC2B2B),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ],
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // Refresh action
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF7E7D9),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     Icons.refresh,
//                     color: Colors.brown.shade400,
//                     size: 18,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 14),

//           // --- Title + Icon ---
//           Row(
//             children: [
//               Text(emoji, style: const TextStyle(fontSize: 22)),
//               const SizedBox(width: 8),
//               Text(title, style: AppsTextStyles.regularResponsive(context)),
//             ],
//           ),

//           const SizedBox(height: 12),

//           // --- Date + Time ---
//           Row(
//             children: [
//               const Icon(
//                 Icons.calendar_today,
//                 size: 18,
//                 color: Color(0xFF03145B),
//               ),
//               const SizedBox(width: 6),
//               Text("Yesterday", style: AppsTextStyles.extraBold16),
//               const SizedBox(width: 14),
//               const Icon(
//                 Icons.check_circle,
//                 size: 20,
//                 color: Color(0xFF011F54),
//               ),
//               const SizedBox(width: 6),
//               Text(time, style: AppsTextStyles.extraBold16),
//             ],
//           ),

//           const SizedBox(height: 16),

//           // --- Tags ---
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 14,
//                   vertical: 6,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFFFFEF8),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   levelText,
//                   style: AppsTextStyles.labelworkSansSemiBold18,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 14,
//                   vertical: 6,
//                 ),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF8E7D3),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   duration,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF8A5C31),
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 20),

//           // --- Bottom Buttons ---
//           Row(
//             children: [
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     // Mark as completed action
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       border: Border.all(color: const Color(0xFF5C3DFF)),
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Actually, I did this',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.workSans(
//                         color: const Color(0xFF4542EB), // Text-primary
//                         fontSize: 16,
//                         fontWeight: FontWeight.w900,
//                         height: 0.80,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 14),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     // Skip action
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       border: Border.all(color: const Color(0xFF5C3DFF)),
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Skip',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.workSans(
//                         color: const Color(0xFF4542EB), // Text-primary
//                         fontSize: 16,
//                         fontWeight: FontWeight.w900,
//                         height: 0.80,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';

class Blockng extends StatefulWidget {
  const Blockng({super.key});

  @override
  State<Blockng> createState() => _BlockngState();
}

class _BlockngState extends State<Blockng> {
  bool showQuests = false;
  List<Map<String, dynamic>> quests = [
    {
      "emoji": "🧹",
      "title": "Clean house",
      "levelText": "Soft steps",
      "levelColor": const Color(0xFFA0E871),
      "time": "22:00",
      "duration": "10 mins",
    },
    {
      "emoji": "📘",
      "title": "Do homework",
      "levelText": "Elevated",
      "levelColor": const Color(0xFFF7A94B),
      "time": "22:00",
      "duration": "10 mins",
    },
    {
      "emoji": "🍽️",
      "title": "Do dishes",
      "levelText": "Stretch zone",
      "levelColor": const Color(0xFF6AA7FF),
      "time": "22:00",
      "duration": "10 mins",
    },
    {
      "emoji": "🏋️",
      "title": "Workout",
      "levelText": "Power move",
      "levelColor": const Color(0xFFFF5A5A),
      "time": "22:00",
      "duration": "10 mins",
    },
  ];
  String selected = "Last 30 days";

  final List<String> options = [
    "All time",
    "Today",
    "Last 7 days",
    "Last 30 days",
  ];

  @override
  Widget build(BuildContext context) {
    if (showQuests) {
      return _todayQuests();
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ===== TOP ICON =====
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  "assets/svg_images/Button Calendar.png",
                  height: 62,
                  width: 62,
                ),
              ),

              const SizedBox(height: 24),

              // ===== BIG TITLE =====
              Text(
                "No quests",
                textAlign: TextAlign.center,
                style: AppsTextStyles.workSansExtraBold20Center,
              ),

              const SizedBox(height: 12),

              // ===== SUBTEXT =====
              Text(
                'Look at you — on top of everything!\nIf you ever miss a quest, it\'ll show up here.',
                textAlign: TextAlign.center,
                style: AppsTextStyles.workSansRegularAdd16,
              ),

              const SizedBox(height: 24),

              // ===== CREATE QUEST BUTTON =====
              SizedBox(
                width: 210,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showQuests = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C46F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add, color: Colors.white, size: 24),
                      const SizedBox(width: 6),
                      Text(
                        "Create quest",
                        style: AppsTextStyles.workSansBlack18Center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _todayQuests() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown Filter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: selected,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      items: options.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selected = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Image.asset(Assets.svgIcons.x.path, height: 20, width: 20),
                    const SizedBox(width: 6),
                    Text(
                      'Clear all',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF4542EB),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        height: 0.80,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Quest List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: quests.map((quest) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: QuestCard(
                    emoji: quest["emoji"],
                    title: quest["title"],
                    levelText: quest["levelText"],
                    levelColor: quest["levelColor"],
                    time: quest["time"],
                    duration: quest["duration"],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String levelText;
  final Color levelColor;
  final String time;
  final String duration;

  const QuestCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.levelText,
    required this.levelColor,
    required this.time,
    required this.duration,
  });

  Color _getTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEF8),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEEDCC5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Top Row: Missed + Refresh Icon ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.red.shade400,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "Quest missed",
                    style: TextStyle(
                      color: Color(0xFFCC2B2B),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7E7D9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    Assets.images.refresh.path,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // --- Title + Icon ---
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Text(title, style: AppsTextStyles.regularResponsive(context)),
            ],
          ),

          const SizedBox(height: 12),

          // --- Date + Time ---
          Row(
            children: [
              Image.asset(Assets.images.today.path, height: 20, width: 20),
              const SizedBox(width: 10),
              Text(
                "Today",
                style: GoogleFonts.workSans(
                  color: const Color(0xFF011F54),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 20),
              Image.asset(Assets.images.clock1.path, height: 20, width: 20),
              const SizedBox(width: 10),
              Text(
                time,
                style: GoogleFonts.workSans(
                  color: const Color(0xFF011F54),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // --- Tags ---
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Level Tag
              Container(
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: ShapeDecoration(
                  color: levelColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  levelText,
                  style: GoogleFonts.workSans(
                    color: _getTextColor(levelColor),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.40,
                    letterSpacing: -0.40,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Duration Tag
              Container(
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFAE3CE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  duration,
                  style: GoogleFonts.workSans(
                    color: const Color(0xFF011F54),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                    letterSpacing: -0.40,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // --- Bottom Buttons ---
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFF5C3DFF)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Actually, I did this',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF4542EB),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        height: 0.80,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFF5C3DFF)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Skip',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF4542EB),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        height: 0.80,
                      ),
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
}
