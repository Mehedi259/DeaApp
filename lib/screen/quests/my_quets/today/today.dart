import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';

class Today extends StatefulWidget {
  const Today({super.key});

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
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
      "levelColor": const Color(0xFFFF8F26),
      "time": "22:00",
      "duration": "10 mins",
    },
    {
      "emoji": "",
      "title": "Do dishes",
      "levelText": "Stretch zone",
      "levelColor": const Color(0xFF3D87F5),
      "time": "22:00",
      "duration": "10 mins",
    },
    {
      "emoji": "",
      "title": "Workout",
      "levelText": "Power move",
      "levelColor": const Color(0xFFD53D40),
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              SizedBox(
                width: 222,
                child: Text(
                  'No quests yet, but your journey starts here.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                    color: const Color(0xFF011F54),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    height: 1.20,
                    letterSpacing: -0.50,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 335,
                child: Text(
                  'Add your first quest and take the smallest possible step — we\'re not chasing perfection, just progress.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                    color: const Color(0xFF4C586E),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: -0.50,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 230,
                height: 50,
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
                        'Create quest',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.workSans(
                          color: const Color(0xFFFFFDF7),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          height: 0.80,
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
    );
  }

  void _showFilterMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final result = await showMenu<String>(
      context: context,
      position: position,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      items: options.map((value) {
        final isSelected = value == selected;
        return PopupMenuItem<String>(
          value: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: GoogleFonts.workSans(
                  color: const Color(0xFF011F54),
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
              if (isSelected)
                const Icon(Icons.check, color: Color(0xFF4C46F5), size: 18),
            ],
          ),
        );
      }).toList(),
    );

    if (result != null) {
      setState(() {
        selected = result;
      });
    }
  }

  Widget _todayQuests() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom Dropdown Filter
        Padding(
          padding: const EdgeInsets.all(16),
          child: Builder(
            builder: (context) => GestureDetector(
              onTap: () => _showFilterMenu(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selected,
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF011F54),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                        letterSpacing: -0.9,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Quest List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: quests.length,
            itemBuilder: (context, index) {
              final quest = quests[index];
              return Slidable(
                key: ValueKey(quest["title"]),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  extentRatio: 0.20,
                  children: [
                    CustomSlidableAction(
                      onPressed: (context) {
                        setState(() {
                          quests.removeAt(index);
                        });
                      },
                      backgroundColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        Assets.images.buttonCalendarDelate.path,
                        height: 42,
                        width: 42,
                      ),
                    ),
                  ],
                ),
                child: QuestCard(
                  emoji: quest["emoji"],
                  title: quest["title"],
                  levelText: quest["levelText"],
                  levelColor: quest["levelColor"],
                  time: quest["time"],
                  duration: quest["duration"],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class QuestCard extends StatefulWidget {
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

  @override
  State<QuestCard> createState() => _QuestCardState();
}

class _QuestCardState extends State<QuestCard> {
  bool isChecked = false;

  Color _getTextColor(Color levelColor) {
    if (levelColor == const Color(0xFFA0E871)) {
      return const Color(0xFF011F54);
    } else if (levelColor == const Color(0xFFFF8F26)) {
      return const Color(0xFF011F54);
    } else if (levelColor == const Color(0xFF3D87F5)) {
      return const Color(0xFFEEEEEE);
    } else if (levelColor == const Color(0xFFD53D40)) {
      return const Color(0xFFFFFDF7);
    }
    return const Color(0xFF011F54);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFFFFEF8),
        border: Border.all(color: const Color(0xFFFFCB9B), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------- TOP ROW: Checkbox + Edit Icon --------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Custom Checkbox
              GestureDetector(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: isChecked
                        ? const Color(0xFF4542EB)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      width: 2,
                      color: const Color(0xFF4542EB),
                    ),
                  ),
                  child: isChecked
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
                ),
              ),

              // Edit Icon Button
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  Assets.images.buttonCalendar.path,
                  height: 48,
                  width: 48,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // -------- Title --------
          Text(
            "${widget.emoji}  ${widget.title}",
            style: GoogleFonts.workSans(
              color: const Color(0xFF011F54),
              fontSize: 32,
              fontWeight: FontWeight.w800,
              height: 1.20,
              letterSpacing: -1,
            ),
          ),

          const SizedBox(height: 16),

          // -------- Time Row --------
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
                widget.time,
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

          // -------- Level Tag + Duration --------
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Level Tag
              Container(
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: ShapeDecoration(
                  color: widget.levelColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.levelText,
                  style: GoogleFonts.workSans(
                    color: _getTextColor(widget.levelColor),
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
                  widget.duration,
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
        ],
      ),
    );
  }
}
