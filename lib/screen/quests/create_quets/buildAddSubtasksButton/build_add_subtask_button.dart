import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/create_qutes.dart';

class AddSubtasksButton extends StatefulWidget {
  final double scale;

  const AddSubtasksButton({super.key, this.scale = 1.0});

  @override
  State<AddSubtasksButton> createState() => _AddSubtasksButtonState();
}

class _AddSubtasksButtonState extends State<AddSubtasksButton> {
  bool showSubtaskGenerator = false;
  bool showGeneratedSubtasks = false;

  // Sample generated subtasks
  final List<String> generatedSubtasks = [
    'Clean kitchen',
    'Wash dishes',
    'Take out trash',
  ];

  // Chosen/selected subtasks
  final List<String> chosenSubtasks = [];

  void _onGenerateSubtasks() {
    setState(() {
      showGeneratedSubtasks = true;
    });
  }

  void _onToggleSubtask(String subtask) {
    setState(() {
      if (chosenSubtasks.contains(subtask)) {
        chosenSubtasks.remove(subtask);
      } else {
        chosenSubtasks.add(subtask);
      }
    });
  }

  void _onDeselectAll() {
    setState(() {
      chosenSubtasks.clear();
    });
  }

  void _onRefreshGenerate() {
    // Re-generate subtasks (can be replaced with actual logic)
    setState(() {
      showGeneratedSubtasks = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double s = widget.scale;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE6F0FF),
        borderRadius: BorderRadius.circular(12 * s),
        border: Border.all(color: Colors.blue.shade100, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with icon and add button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24 * s, vertical: 8 * s),
            child: Row(
              children: [
                Image.asset(
                  Assets.svgIcons.arrow.path,
                  height: 20 * s,
                  width: 20 * s,
                ),
                SizedBox(width: 8 * s),
                Expanded(
                  child: Text(
                    'ADD SUBTASKS',
                    style: AppTextStylesQutes.workSansBlack24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showSubtaskGenerator = !showSubtaskGenerator;
                    });
                  },
                  child: Container(
                    width: 32 * s,
                    height: 32 * s,
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(8 * s),
                    ),
                    child: Image.asset(
                      Assets.svgIcons.quests.path,
                      height: 20 * s,
                      width: 20 * s,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Expandable subtask generator section
          if (showSubtaskGenerator) ...[
            SizedBox(height: 12 * s),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12 * s),
              child: GestureDetector(
                onTap: _onGenerateSubtasks,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14 * s),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFA9A8F6)),
                    borderRadius: BorderRadius.circular(25 * s),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.svgIcons.star.path,
                        height: 20 * s,
                        width: 20 * s,
                      ),
                      SizedBox(width: 8 * s),
                      Text(
                        "Generate subtasks",
                        style: AppTextStylesQutes.workSansBlack18,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- Generated subtasks section ---
            if (showGeneratedSubtasks) ...[
              SizedBox(height: 16 * s),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * s),
                child: Row(
                  children: [
                    Text(
                      'Generated subtasks',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF011F54), // Text-text-default
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.20,
                        letterSpacing: -0.50,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _onRefreshGenerate,
                      child: Container(
                        width: 28 * s,
                        height: 28 * s,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6E4FF),
                          borderRadius: BorderRadius.circular(8 * s),
                        ),
                        child: Image.asset(
                          Assets.images.cleanWindowsRefers.path,
                          height: 24 * s,
                          width: 24 * s,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10 * s),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * s),
                child: Wrap(
                  spacing: 8 * s,
                  runSpacing: 8 * s,
                  children: generatedSubtasks.map((subtask) {
                    final isSelected = chosenSubtasks.contains(subtask);
                    return GestureDetector(
                      onTap: () => _onToggleSubtask(subtask),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16 * s,
                          vertical: 10 * s,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF4542EB)
                              : const Color(0xFFE6F0FF),
                          borderRadius: BorderRadius.circular(25 * s),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF4542EB)
                                : const Color(0xFFB3C6E6),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              Assets.images.cleanKitchen.path,
                              height: 18 * s,
                              width: 18 * s,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF4542EB),
                            ),
                            SizedBox(width: 6 * s),
                            Text(
                              subtask,
                              style: GoogleFonts.workSans(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF4542EB),
                                // color: const Color(
                                //   0xFF4542EB,
                                // ), // Text-text-primary
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                height: 0.80,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // --- Chosen section ---
              if (chosenSubtasks.isNotEmpty) ...[
                SizedBox(height: 16 * s),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16 * s),
                  child: Row(
                    children: [
                      Text(
                        'Choosen',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.workSans(
                          color: const Color(0xFF011F54), // Text-text-default
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          height: 1.20,
                          letterSpacing: -0.50,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _onDeselectAll,
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.images.deselectAll.path,
                              height: 16 * s,
                              width: 16 * s,
                            ),
                            SizedBox(width: 4 * s),
                            Text(
                              'Deselect all',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.workSans(
                                color: const Color(
                                  0xFF4542EB,
                                ), // Text-text-primary
                                fontSize: 16,
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
                SizedBox(height: 10 * s),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16 * s),
                  child: Wrap(
                    spacing: 8 * s,
                    runSpacing: 8 * s,
                    children: chosenSubtasks.map((subtask) {
                      return GestureDetector(
                        onTap: () => _onToggleSubtask(subtask),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16 * s,
                            vertical: 10 * s,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4542EB),
                            borderRadius: BorderRadius.circular(25 * s),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                Assets.images.checkCircle.path,
                                height: 18 * s,
                                width: 18 * s,
                                color: Colors.white,
                              ),
                              SizedBox(width: 6 * s),
                              Text(
                                subtask,
                                style: GoogleFonts.workSans(
                                  color: const Color(
                                    0xFFFFFDF7,
                                  ), // Text-text-light
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  height: 0.80,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
              SizedBox(height: 12 * s),
            ],

            SizedBox(height: 12 * s),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12 * s),
              child: Container(
                padding: EdgeInsets.all(14 * s),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12 * s),
                  border: Border.all(color: Colors.blue.shade100, width: 1.5),
                ),
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Write subtask...',
                    hintStyle: AppTextStylesQutes.workSansExtraBold32,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: AppTextStylesQutes.workSansSemiBold18,
                ),
              ),
            ),
            SizedBox(height: 12 * s),
          ],
        ],
      ),
    );
  }
}
