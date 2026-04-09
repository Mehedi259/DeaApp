import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_dea/custom_code/bottom_nav.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/_buildInputCard/input_widget_card.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/buildAddSubtasksButton/build_add_subtask_button.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/buildTitle/title_widget.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/enabable_card/enabable_card.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/repeat_quest_card/repeat_quest_card.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/select_zone_card/select_zone_card.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/time_picker_card/time_picker_card.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/when_card/when_card.dart';
import 'package:mobile_app_dea/services/quest_service.dart';
import 'package:intl/intl.dart';

class CreateQuestPage extends StatefulWidget {
  const CreateQuestPage({super.key});

  @override
  State<CreateQuestPage> createState() => _CreateQuestPageState();
}

class _CreateQuestPageState extends State<CreateQuestPage> {
  bool showSubtaskGenerator = false;
  bool showDesignScreen = false;
  bool showDateSelectionScreen = false;
  
  // Form state
  final TextEditingController _taskController = TextEditingController();
  String? selectedZone;
  DateTime selectedDate = DateTime.now();
  bool enableCall = true;
  bool repeatQuest = true;
  List<String> subtasks = [];
  bool _isCreating = false;

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  Future<void> _createQuest() async {
    // Validation
    if (_taskController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a quest title')),
      );
      return;
    }

    if (selectedZone == null || selectedZone!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a zone')),
      );
      return;
    }

    setState(() => _isCreating = true);

    final questService = QuestService();
    
    // Prepare subtasks
    List<Map<String, dynamic>>? subtasksList;
    if (subtasks.isNotEmpty) {
      subtasksList = subtasks.map((title) => {
        'title': title,
        'task_done': false,
      }).toList();
    }

    final quest = await questService.createQuest(
      task: _taskController.text.trim(),
      zone: selectedZone!,
      selectADate: DateFormat('yyyy-MM-dd').format(selectedDate),
      enableCall: enableCall,
      repeatQuest: repeatQuest,
      setAlarm: true,
      subtasks: subtasksList,
    );

    setState(() => _isCreating = false);

    if (quest != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Quest created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      context.pop(); // Go back to home screen
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create quest. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final baseScale = width / 390.0;

    return Scaffold(
      backgroundColor: Color(0xFF89B6F8),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0 * baseScale,
                vertical: 12.0 * baseScale,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10 * baseScale),
                  TitleWidget(),
                  SizedBox(height: 14 * baseScale),
                  InputCardWidget(controller: _taskController),
                  SizedBox(height: 12 * baseScale),
                  AddSubtasksButton(
                    onSubtasksChanged: (List<String> newSubtasks) {
                      setState(() => subtasks = newSubtasks);
                    },
                  ),
                  SizedBox(height: 12 * baseScale),
                  SelectZoneCard(
                    onZoneSelected: (String? zone) {
                      setState(() => selectedZone = zone);
                    },
                  ),
                  SizedBox(height: 12 * baseScale),
                  WhenCard(
                    onDateSelected: (String option, DateTime date) {
                      setState(() => selectedDate = date);
                    },
                  ),
                  SizedBox(height: 12 * baseScale),
                  TimePickerCard(),
                  SizedBox(height: 12 * baseScale),
                  EnableCallCard(
                    onCallEnabledChanged: (bool value) {
                      setState(() => enableCall = value);
                    },
                  ),
                  SizedBox(height: 12 * baseScale),
                  RepeatQuestCard(
                    onRepeatChanged: (bool value) {
                      setState(() => repeatQuest = value);
                    },
                  ),
                  SizedBox(
                    height: 130 * baseScale,
                  ), // Extra space for fixed button
                ],
              ),
            ),

            // Fixed Create Quest Button at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                width: width,
                height: 108,
                child: Stack(
                  children: [
                    /// Bottom rounded bar
                    Positioned(
                      left: 0,
                      top: 74,
                      child: SizedBox(
                        width: width,
                        height: 34,
                        child: Stack(
                          children: [
                            Positioned(
                              left: (width - 134) / 2,
                              top: 21,
                              child: Container(
                                width: 134,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFDF7),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Button
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: width,
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: 20,
                          right: 20,
                          bottom: 32,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 64,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF8F26),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              alignment: Alignment.center,
                              child: _isCreating
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFF011F54),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: _createQuest,
                                      child: Text(
                                        'Create Quest',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.workSans(
                                          color: const Color(0xFF011F54),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          height: 0.80,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // DesignScreen Overlay
            if (showDesignScreen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showDesignScreen = false;
                    });
                  },
                  child: Container(
                    color: Colors.black54,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: const DesignScreen(),
                      ),
                    ),
                  ),
                ),
              ),

            // DateSelectionScreen Overlay
            if (showDateSelectionScreen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showDateSelectionScreen = false;
                    });
                  },
                  child: Container(
                    color: Colors.black38,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: DateSelectionScreen(
                          onDateSelected: (day, weekday) {
                            setState(() {
                              showDateSelectionScreen = false;
                            });
                          },
                          onClose: () {
                            setState(() {
                              showDateSelectionScreen = false;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation tap
        },
      ),
    );
  }
}
