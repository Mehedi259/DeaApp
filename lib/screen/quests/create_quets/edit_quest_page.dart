import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/custom_code/bottom_nav.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/_buildInputCard/input_widget_card.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/buildAddSubtasksButton/build_add_subtask_button.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/buildTitle/edit_title_widget.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/enabable_card/enabable_card.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/repeat_quest_card/repeat_quest_card.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/select_zone_card/select_zone_card.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/time_picker_card/time_picker_card.dart';
import 'package:mobile_app_dea/screen/quests/create_quets/when_card/when_card.dart';

class EditQuestPage extends StatefulWidget {
  final Map<String, dynamic>? taskData;
  final int? taskId;

  const EditQuestPage({
    super.key,
    this.taskData,
    this.taskId,
  });

  @override
  State<EditQuestPage> createState() => _EditQuestPageState();
}

class _EditQuestPageState extends State<EditQuestPage> {
  bool showSubtaskGenerator = false;
  bool showDesignScreen = false;
  bool showDateSelectionScreen = false;
  String? selectedZone;
  bool isCallEnabled = true;

  String selectedDateOption = 'Today';

  @override
  void initState() {
    super.initState();
    // Pre-fill data if available
    if (widget.taskData != null) {
      // Initialize with existing task data
      // You can pass this data to child widgets via controllers or state management
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
                  EditTitleWidget(),
                  SizedBox(height: 14 * baseScale),
                  InputCardWidget(
                    initialValue: widget.taskData?['title'],
                  ),
                  SizedBox(height: 12 * baseScale),
                  AddSubtasksButton(),
                  SizedBox(height: 12 * baseScale),
                  SelectZoneCard(),
                  SizedBox(height: 12 * baseScale),
                  WhenCard(),
                  SizedBox(height: 12 * baseScale),
                  TimePickerCard(
                    initialTime: widget.taskData?['time'],
                  ),
                  SizedBox(height: 12 * baseScale),
                  EnableCallCard(),
                  SizedBox(height: 12 * baseScale),
                  RepeatQuestCard(),
                  SizedBox(
                    height: 130 * baseScale,
                  ), // Extra space for fixed button
                ],
              ),
            ),

            // Fixed Update Quest Button at bottom
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
                            GestureDetector(
                              onTap: _handleUpdateQuest,
                              child: Container(
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
                                child: Text(
                                  'Update Quest',
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
                              selectedDateOption = '$weekday, Jan $day';
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

  void _handleUpdateQuest() {
    // TODO: Implement PATCH API call to update quest
    // Use widget.taskId to identify which quest to update
    // Collect data from all form fields
    // Call API service
    
    debugPrint('Updating quest with ID: ${widget.taskId}');
    
    // After successful update, navigate back
    Navigator.of(context).pop();
  }
}
