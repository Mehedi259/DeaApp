import 'package:flutter/material.dart';
import 'package:mobile_app_dea/screen/quests/my_quets/completed/task_card/task_card.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  bool showQuests = false;

  @override
  Widget build(BuildContext context) {
    // 🔥 Start quest চাপলে Quest List দেখাবে
    if (showQuests) {
      return const QuestList();
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TOP ICON
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                "assets/svg_images/Button Calendar.png",
                height: 64,
                width: 64,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "No quests completed yet.",
              textAlign: TextAlign.center,
              style: AppsTextStyles.workSansExtraBold20Center,
            ),

            const SizedBox(height: 12),

            Text(
              "Progress comes in small wins — start today and this list will grow.\nYou’ve got this.",
              textAlign: TextAlign.center,
              style: AppsTextStyles.workSansRegularAdd16,
            ),

            const SizedBox(height: 24),

            // START QUEST BUTTON
            SizedBox(
              width: 210,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showQuests = true; // Show the tasks
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
                    const Icon(Icons.add, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      "Start quest",
                      style: AppsTextStyles.workSansBlack18Center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';
import 'package:mobile_app_dea/screen/quests/my_quets/completed/task_card/task_card.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  bool showQuests = false;

  @override
  Widget build(BuildContext context) {
    /// ✔ Start Quest চাপলেই Quest List দেখাবে
    if (showQuests) {
      return const QuestList();
    }

    /// ✔ ScrollView + Center → No overflow
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TOP ICON
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  "assets/svg_images/Button Calendar.png",
                  height: 50,
                  width: 50,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                "No quests completed yet.",
                textAlign: TextAlign.center,
                style: AppsTextStyles.workSansExtraBold20Center,
              ),

              const SizedBox(height: 12),

              Text(
                "Progress comes in small wins — start today and this list will grow.\nYou’ve got this.",
                textAlign: TextAlign.center,
                style: AppsTextStyles.workSansRegularAdd16,
              ),

              const SizedBox(height: 24),

              // START QUEST BUTTON
              SizedBox(
                width: 210,
                child: ElevatedButton(
                  onPressed: () {
                    /// ✔ preventing setState after dispose
                    if (!mounted) return;

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
                      const Icon(Icons.add, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        "Start quest",
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
}
*/