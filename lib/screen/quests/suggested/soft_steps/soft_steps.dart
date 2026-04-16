// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nowlii/core/gen/assets.gen.dart';
// import 'package:nowlii/utlis/color_palette/color_palette.dart';

// class ShuffleScreen extends StatelessWidget {
//   const ShuffleScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
//       child: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.all(16),
//                 children: [
//                   // Special "To sleep" card with different design
//                   SleepRoutineCard(
//                     title: 'To sleep',
//                     description:
//                         'Wind down, unplug, and prep your mind for rest.',
//                     time: '22:00',
//                     softSteps: 'Soft steps',
//                     hardSteps: '10 Hard',
//                     imagePath: Assets.svgIcons.moon4.path,
//                     emoji: Assets.svgIcons.moonPng_.path,
//                     hardStepsColor: const Color(0xFF89B6F8), // Green
//                     softStepsColor: AppColorsApps.freshGreen, // Light Green
//                   ),
//                   const SizedBox(height: 8),
//                   RoutineCard(
//                     title: 'To wake up',
//                     description:
//                         'Rise fresh. Stretch, breathe — just light, breath, and presence.',
//                     time: '22:00',
//                     softSteps: 'Soft steps',
//                     hardSteps: '10 mins',
//                     imagePath: Assets.svgIcons.toWakeUp.path,
//                     emoji: Assets.svgIcons.sun.path,
//                     hardStepsColor: Color(0xFFFFB46E), // Orange
//                     softStepsColor: AppColorsApps.freshGreen, // Purple
//                   ),
//                   const SizedBox(height: 8),
//                   RoutineCard(
//                     title: 'To walk',
//                     description:
//                         'Move your body, clear your mind. Even for a little bit counts.',
//                     time: '22:00',
//                     softSteps: 'Soft steps',
//                     hardSteps: '10 mins',
//                     imagePath: Assets.svgIcons.toWalk.path,
//                     emoji: Assets.svgIcons.toWalkIcon.path,
//                     hardStepsColor: const Color(0xFFA0E871), // Light Blue
//                     softStepsColor: AppColorsApps.freshGreen, // Amber
//                   ),
//                   const SizedBox(height: 8),
//                   RoutineCard(
//                     title: 'To study',
//                     description:
//                         'Focus, learn, retain. Deep in reflection — just progress.',
//                     time: '22:00',
//                     softSteps: 'Soft steps',
//                     hardSteps: '10 mins',
//                     imagePath: Assets.svgIcons.toStudy.path,
//                     emoji: Assets.svgIcons.book.path,
//                     hardStepsColor: const Color(0xFFA9A8F6), // Deep Purple
//                     softStepsColor: AppColorsApps.freshGreen, // Light Green
//                   ),
//                   const SizedBox(height: 8),
//                   RoutineCard(
//                     title: 'To train',
//                     description:
//                         'Sweat, strengthen, boost energy. Show up for yourself.',
//                     time: '22:00',
//                     softSteps: 'Soft steps',
//                     hardSteps: '10 mins',
//                     imagePath: Assets.svgIcons.toTrain.path,
//                     emoji: Assets.svgIcons.push.path,
//                     hardStepsColor: const Color(0xFFFFCE73), // Red
//                     softStepsColor: AppColorsApps.freshGreen, // Teal
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: ShapeDecoration(
//           shape: RoundedRectangleBorder(
//             side: BorderSide(
//               width: 2,
//               color: const Color(0xFF011F54) /* Border-border-dark */,
//             ),
//             borderRadius: BorderRadius.circular(999),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               Assets.svgIcons.shuffle.path,
//               width: 20,
//               height: 20,
//               color: const Color(0xFF011F54),
//             ),
//             SizedBox(width: 8),
//             Text(
//               'Shuffle',
//               style: GoogleFonts.workSans(
//                 color: const Color(0xFF011F54),
//                 fontSize: 18,
//                 fontWeight: FontWeight.w900,
//                 height: 0.8,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Special card for "To sleep" routine
// class SleepRoutineCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String time;
//   final String softSteps;
//   final String hardSteps;
//   final String imagePath;
//   final String emoji;
//   final Color hardStepsColor;
//   final Color softStepsColor;

//   const SleepRoutineCard({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.time,
//     required this.softSteps,
//     required this.hardSteps,
//     required this.imagePath,
//     required this.emoji,
//     required this.hardStepsColor,
//     required this.softStepsColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(minHeight: 295),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Emoji image display - 64px
//               Image.asset(emoji, width: 64, height: 64),
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Image.asset(
//                   Assets.svgIcons.toMoonPlus.path,
//                   width: 48,
//                   height: 48,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             title,
//             style: GoogleFonts.workSans(
//               color: Colors.white,
//               fontSize: 32,
//               fontWeight: FontWeight.w800,
//               height: 1.2,
//               letterSpacing: -1,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Flexible(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 6,
//                     vertical: 2,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.3),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image.asset(
//                         Assets.svgIcons.calendarBlank.path,
//                         width: 12,
//                         height: 12,
//                         color: Colors.white,
//                       ),
//                       const SizedBox(width: 4),
//                       const Flexible(
//                         child: Text(
//                           'Today',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Flexible(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 6,
//                     vertical: 2,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.3),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image.asset(
//                         Assets.svgIcons.clockBlack.path,
//                         width: 12,
//                         height: 12,
//                         color: Colors.white,
//                       ),
//                       const SizedBox(width: 4),
//                       Flexible(
//                         child: Text(
//                           time,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             description,
//             style: GoogleFonts.workSans(
//               color: const Color(0xFFFFFEF8),
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               height: 1.4,
//               letterSpacing: -0.9,
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           const Spacer(),
//           Row(
//             children: [
//               Flexible(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: hardStepsColor,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     hardSteps,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Flexible(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: softStepsColor,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     softSteps,
//                     style: GoogleFonts.workSans(
//                       color: const Color(0xFF011F54), // Text color
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       height: 1.4,
//                       letterSpacing: -0.9,
//                     ),
//                     overflow: TextOverflow.ellipsis,
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

// // Regular routine card for other routines
// class RoutineCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String time;
//   final String softSteps;
//   final String hardSteps;
//   final String imagePath;
//   final String emoji;
//   final Color hardStepsColor;
//   final Color softStepsColor;

//   const RoutineCard({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.time,
//     required this.softSteps,
//     required this.hardSteps,
//     required this.imagePath,
//     required this.emoji,
//     required this.hardStepsColor,
//     required this.softStepsColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(minHeight: 295),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Emoji check - image or text - 64px
//               // emoji.contains('.')
//               //     ? Image.asset(emoji, width: 64, height: 64)
//               //     : Text(emoji, style: const TextStyle(fontSize: 64)),
//               Image.asset(emoji, width: 64, height: 64),

//               Container(
//                 padding: const EdgeInsets.all(8),
//                 child: Image.asset(
//                   Assets.svgIcons.buttonCalendar.path,
//                   width: 48,
//                   height: 48,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             title,
//             style: GoogleFonts.workSans(
//               color: const Color(0xFF011F54),
//               fontSize: 32,
//               fontWeight: FontWeight.w800,
//               height: 1.2,
//               letterSpacing: -1,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Flexible(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 6,
//                     vertical: 2,
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image.asset(
//                         Assets.svgIcons.calendarBlank.path,
//                         width: 12,
//                         height: 12,
//                         color: const Color(0xFF011F54),
//                       ),
//                       const SizedBox(width: 4),
//                       Flexible(
//                         child: Text(
//                           'Today',
//                           style: GoogleFonts.workSans(
//                             color: const Color(0xFF011F54),
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             height: 1.4,
//                             letterSpacing: -0.9,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Flexible(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 6,
//                     vertical: 2,
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image.asset(
//                         Assets.svgIcons.clockBlack.path,
//                         width: 12,
//                         height: 12,
//                         color: const Color(0xFF011F54),
//                       ),
//                       const SizedBox(width: 4),
//                       Flexible(
//                         child: Text(
//                           time,
//                           style: GoogleFonts.workSans(
//                             color: const Color(0xFF011F54),
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             height: 1.4,
//                             letterSpacing: -0.9,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             description,
//             style: GoogleFonts.workSans(
//               color: const Color(0xFF4C586E),
//               fontSize: 18,
//               fontWeight: FontWeight.w400,
//               height: 1.4,
//               letterSpacing: -0.5,
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           const Spacer(),
//           Row(
//             children: [
//               Flexible(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: hardStepsColor,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     hardSteps,
//                     style: GoogleFonts.workSans(
//                       color: const Color(0xFF011F54), // Text color
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       height: 1.4,
//                       letterSpacing: -0.9,
//                     ),

//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Flexible(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: softStepsColor,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     softSteps,
//                     style: GoogleFonts.workSans(
//                       color: const Color(0xFF011F54), // Text color
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       height: 1.4,
//                       letterSpacing: -0.9,
//                     ),
//                     overflow: TextOverflow.ellipsis,
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
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nowlii/core/gen/assets.gen.dart';
import 'package:nowlii/utlis/color_palette/color_palette.dart';
import 'package:nowlii/models/quest_suggestion_model.dart';
import 'package:nowlii/services/quest_suggestion_service.dart';

class ShuffleScreen extends StatefulWidget {
  const ShuffleScreen({super.key});

  @override
  State<ShuffleScreen> createState() => _ShuffleScreenState();
}

class _ShuffleScreenState extends State<ShuffleScreen> {
  final QuestSuggestionService _service = QuestSuggestionService();
  List<QuestSuggestion> _suggestions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print('\n');
    print('═══════════════════════════════════════');
    print('🎯 SHUFFLE SCREEN INITIALIZED');
    print('═══════════════════════════════════════');
    print('\n');
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    print('🔄 Loading quest suggestions...');
    setState(() => _isLoading = true);
    
    try {
      print('📞 Calling API...');
      final response = await _service.getQuestSuggestions();
      print('📦 API Response received: ${response != null ? "Success" : "Null"}');
      
      if (response != null && mounted) {
        print('✅ Setting ${response.weekly.questSuggestions.length} suggestions');
        setState(() {
          _suggestions = response.weekly.questSuggestions;
          _isLoading = false;
        });
      } else {
        print('⚠️ Using fallback data');
        // Use fallback data if API fails
        _useFallbackData();
      }
    } catch (e) {
      print('❌ Error in _loadSuggestions: $e');
      _useFallbackData();
    }
  }
  void _useFallbackData() {
    // Fallback to hardcoded data if API fails
    setState(() {
      _suggestions = [
        QuestSuggestion(
          task: 'To sleep',
          description: 'Wind down, unplug, and prep your mind for rest.',
          zone: 'Soft steps',
          suggestedTime: '22:00',
        ),
        QuestSuggestion(
          task: 'To wake up',
          description: 'Rise fresh. Stretch, breathe — just light, breath, and presence.',
          zone: 'Soft steps',
          suggestedTime: '07:00',
        ),
        QuestSuggestion(
          task: 'To walk',
          description: 'Move your body, clear your mind. Even for a little bit counts.',
          zone: 'Stretch zone',
          suggestedTime: '18:00',
        ),
        QuestSuggestion(
          task: 'To study',
          description: 'Focus, learn, retain. Deep in reflection — just progress.',
          zone: 'Power move',
          suggestedTime: '14:00',
        ),
        QuestSuggestion(
          task: 'To train',
          description: 'Sweat, strengthen, boost energy. Show up for yourself.',
          zone: 'Elevated',
          suggestedTime: '06:00',
        ),
      ];
      _isLoading = false;
    });
  }

  Color _getZoneColor(String zone) {
    switch (zone.toLowerCase()) {
      case 'soft steps':
        return const Color(0xFF89B6F8);
      case 'stretch zone':
        return const Color(0xFFFFB46E);
      case 'power move':
        return const Color(0xFFA9A8F6);
      case 'elevated':
        return const Color(0xFFFFCE73);
      default:
        return const Color(0xFFA0E871);
    }
  }

  String _getEmojiForTask(String task) {
    final taskLower = task.toLowerCase();
    if (taskLower.contains('sleep')) return Assets.svgIcons.moon.path;
    if (taskLower.contains('wake')) return Assets.svgIcons.sun.path;
    if (taskLower.contains('walk')) return Assets.svgIcons.toWalkIcon.path;
    if (taskLower.contains('study') || taskLower.contains('read')) return Assets.svgIcons.book.path;
    if (taskLower.contains('train') || taskLower.contains('exercise')) return Assets.svgIcons.push.path;
    return Assets.svgIcons.moon.path; // default
  }

  String _getBackgroundForTask(String task) {
    final taskLower = task.toLowerCase();
    if (taskLower.contains('sleep')) return Assets.svgIcons.moon4.path;
    if (taskLower.contains('wake')) return Assets.svgIcons.toWakeUp.path;
    if (taskLower.contains('walk')) return Assets.svgIcons.toWalk.path;
    if (taskLower.contains('study') || taskLower.contains('read')) return Assets.svgIcons.toStudy.path;
    if (taskLower.contains('train') || taskLower.contains('exercise')) return Assets.svgIcons.toTrain.path;
    return Assets.svgIcons.moon4.path; // default
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            if (_isLoading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4542EB)),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = _suggestions[index];
                    final isFirst = index == 0;
                    
                    if (isFirst) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SleepRoutineCard(
                          title: suggestion.task,
                          description: suggestion.description,
                          time: suggestion.suggestedTime,
                          softSteps: suggestion.zone,
                          hardSteps: '10 mins',
                          imagePath: _getBackgroundForTask(suggestion.task),
                          emoji: _getEmojiForTask(suggestion.task),
                          hardStepsColor: _getZoneColor(suggestion.zone),
                          softStepsColor: AppColorsApps.freshGreen,
                          suggestion: suggestion,
                        ),
                      );
                    }
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: RoutineCard(
                        title: suggestion.task,
                        description: suggestion.description,
                        time: suggestion.suggestedTime,
                        softSteps: suggestion.zone,
                        hardSteps: '10 mins',
                        imagePath: _getBackgroundForTask(suggestion.task),
                        emoji: _getEmojiForTask(suggestion.task),
                        hardStepsColor: _getZoneColor(suggestion.zone),
                        softStepsColor: AppColorsApps.freshGreen,
                        suggestion: suggestion,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2, color: Color(0xFF011F54)),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.svgIcons.shuffle.path,
              width: 20,
              height: 20,
              color: const Color(0xFF011F54),
            ),
            const SizedBox(width: 8),
            Text(
              'Shuffle',
              style: GoogleFonts.workSans(
                color: const Color(0xFF011F54),
                fontSize: 18,
                fontWeight: FontWeight.w900,
                height: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SleepRoutineCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String softSteps;
  final String hardSteps;
  final String imagePath;
  final String emoji;
  final Color hardStepsColor;
  final Color softStepsColor;
  final QuestSuggestion? suggestion;

  const SleepRoutineCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.softSteps,
    required this.hardSteps,
    required this.imagePath,
    required this.emoji,
    required this.hardStepsColor,
    required this.softStepsColor,
    this.suggestion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(emoji, width: 64, height: 64),
              GestureDetector(
                onTap: () {
                  context.push('/suggestedTaskOverview', extra: suggestion);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    Assets.svgIcons.toMoonPlus.path,
                    width: 48,
                    height: 48,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.workSans(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.svgIcons.calendarBlank.path,
                        width: 15,
                        height: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      const Flexible(
                        child: Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.svgIcons.clockBlack.path,
                        width: 15,
                        height: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.workSans(
              color: const Color(0xFFFFFEF8),
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1.4,
              letterSpacing: -0.9,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: hardStepsColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    hardSteps,
                    style: GoogleFonts.workSans(
                      color: const Color(0xFF011F54),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: softStepsColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    softSteps,
                    style: GoogleFonts.workSans(
                      color: const Color(0xFF011F54),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
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

class RoutineCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String softSteps;
  final String hardSteps;
  final String imagePath;
  final String emoji;
  final Color hardStepsColor;
  final Color softStepsColor;
  final QuestSuggestion? suggestion;

  const RoutineCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.softSteps,
    required this.hardSteps,
    required this.imagePath,
    required this.emoji,
    required this.hardStepsColor,
    required this.softStepsColor,
    this.suggestion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(emoji, width: 84, height: 84),
              GestureDetector(
                onTap: () {
                  context.push('/suggestedTaskOverview', extra: suggestion);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    Assets.svgIcons.buttonCalendar.path,
                    width: 48,
                    height: 48,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.workSans(
              color: const Color(0xFF011F54),
              fontSize: 32,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.svgIcons.calendarBlank.path,
                        width: 12,
                        height: 12,
                        color: const Color(0xFF011F54),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'Today',
                          style: GoogleFonts.workSans(
                            color: const Color(0xFF011F54),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.svgIcons.clockBlack.path,
                        width: 12,
                        height: 12,
                        color: const Color(0xFF011F54),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          time,
                          style: GoogleFonts.workSans(
                            color: const Color(0xFF011F54),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: GoogleFonts.workSans(
              color: const Color(0xFF4C586E),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.3,
              letterSpacing: -0.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: hardStepsColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    hardSteps,
                    style: GoogleFonts.workSans(
                      color: const Color(0xFF011F54),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: softStepsColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    softSteps,
                    style: GoogleFonts.workSans(
                      color: const Color(0xFF011F54),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
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
