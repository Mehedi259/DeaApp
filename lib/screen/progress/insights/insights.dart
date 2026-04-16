import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nowlii/core/gen/assets.gen.dart';
import 'package:nowlii/themes/text_styles.dart' show AppsTextStyles;
import 'package:nowlii/utlis/color_palette/color_palette.dart';
import 'package:nowlii/services/insights_service.dart';
import 'package:nowlii/models/insights_models.dart';

enum DayStatus { skipped, consistent, streak, empty }

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  int selectedTabIndex = 0;
  final List<String> tabs = ['All', 'Recent sessions', 'AI insights'];
  String selectedWeek = 'This week';
  String selectedMonth = 'This month';
  
  final InsightsService _insightsService = InsightsService();
  InsightsResponse? _insightsData;
  bool _isLoading = true;

  // Emoji overlays for specific calendar days (0-indexed)
  final Map<int, String> dayEmojis = {
    3: '😊', // Thu Week 1
    9: '😰', // Wed Week 2
    14: '😊', // Mon Week 3
    17: '😡', // Thu Week 3
  };

  @override
  void initState() {
    super.initState();
    _loadInsights();
  }

  Future<void> _loadInsights() async {
    setState(() => _isLoading = true);
    final data = await _insightsService.getInsights();
    setState(() {
      _insightsData = data;
      _isLoading = false;
    });
  }

  List<DayStatus> _getCalendarStatuses() {
    if (_insightsData == null) return [];
    
    return _insightsData!.monthly.calendar.map((day) {
      switch (day.status) {
        case 'consistent':
          return DayStatus.consistent;
        case 'skipped':
          return DayStatus.skipped;
        case 'streak':
          return DayStatus.streak;
        default:
          return DayStatus.empty;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFFFFEF8),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_insightsData == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFFFFEF8),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Failed to load insights'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadInsights,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTabNavigation(),
                const SizedBox(height: 24),
                if (selectedTabIndex == 0) ...[
                  _buildRecentSessions(),
                  const SizedBox(height: 24),
                  _buildAIInsights(),
                  _buildWeeklyReflection(),
                  _buildMonthlyOverview(),
                  _buildMilestonesAndAchievements(),
                ] else if (selectedTabIndex == 1) ...[
                  _buildRecentSessions(),
                ] else ...[
                  _buildAIInsights(),
                  const SizedBox(height: 24),
                  _buildWeeklyReflection(),
                  const SizedBox(height: 24),
                  _buildMonthlyOverview(),
                  const SizedBox(height: 24),
                  _buildMilestonesAndAchievements(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabNavigation() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFEF8),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(tabs.length, (index) {
            final isSelected = selectedTabIndex == index;
            return GestureDetector(
              onTap: () => setState(() => selectedTabIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(right: index < tabs.length - 1 ? 8 : 0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFC3DBFF)
                        : const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                  color: isSelected
                      ? const Color(0xFFC3DBFF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  tabs[index],
                  style: AppsTextStyles.workSansSemiBold15.copyWith(
                    color: isSelected
                        ? const Color(0xFF1A2B4F)
                        : const Color(0xFF6B7280),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildRecentSessions() {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFFCB9B), width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent sessions',
                style: AppsTextStyles.extraBold32Centered,
              ),
              const SizedBox(height: 8),
              Text(
                'Your focus moments and reflections saved for you.',
                style: AppsTextStyles.workSansRegularF16,
              ),
              const SizedBox(height: 20),
              _buildSessionCard(
                'Today',
                'Focused on confidence',
                const Color(0xFF4542EB),
                GoogleFonts.workSans(
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  height: 1.2,
                  letterSpacing: -0.5,
                  color: Colors.white,
                ),
                Image.asset(
                  Assets.svgIcons.todayBack.path,
                  height: 48,
                  width: 48,
                ),
                focusTextStyle: AppsTextStyles.myWorkSansStyle.copyWith(
                  color: const Color(0xFFFFFDF7) /* Text-text-light */,
                ),
              ),
              const SizedBox(height: 12),
              _buildSessionCard(
                'Yesterday',
                'Focused on clarity',
                const Color(0xFFFF8F26),
                AppsTextStyles.textDefaultStyle,
                Image.asset(
                  Assets.svgIcons.yesterdayBack.path,
                  height: 48,
                  width: 48,
                ),
              ),
              const SizedBox(height: 12),
              _buildSessionCard(
                'Monday',
                'Focused on getting unstuck',
                const Color(0xFFA0E871),
                AppsTextStyles.textDefaultStyle,
                Image.asset(
                  Assets.svgIcons.mondayBack.path,
                  height: 48,
                  width: 48,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSessionCard(
    String day,
    String focus,
    Color color,
    TextStyle dayTextStyle,
    Widget trailing, {
    TextStyle? focusTextStyle,
  }) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            day,
                            style: dayTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            focus,
                            style: focusTextStyle ?? AppsTextStyles.myWorkSansStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAIInsights() {
    const koro = Color(0xFF5B6FFF);
    final monthly = _insightsData!.monthly;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Color(0xFFF5E6D3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: koro,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Your AI insights',
                style: AppsTextStyles.extraBold32Centered,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFFFCB9B)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 295,
                  child: Text(
                    'Most completed quests',
                    style: GoogleFonts.workSans(
                      color: const Color(0xFF011F54),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.20,
                      letterSpacing: -0.50,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'These are the quests you tend to finish the most:',
                  style: TextStyle(fontSize: 14, color: Color(0xFF1A1A3E)),
                ),
                const SizedBox(height: 16),
                ...monthly.mostCompletedQuests.take(3).map((quest) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildQuestItem(quest.task),
                  );
                }).toList(),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 295,
                  child: Text(
                    'Most productive days / hours',
                    style: GoogleFonts.workSans(
                      color: const Color(0xFF011F54),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.20,
                      letterSpacing: -0.50,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: koro,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Day',
                              style: GoogleFonts.workSans(
                                color: const Color(0xFFFFFDF7),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 1.20,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              monthly.mostProductiveDay,
                              style: GoogleFonts.workSans(
                                color: const Color(0xFFFFFDF7),
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                height: 1.20,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4E7FF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hour',
                              style: GoogleFonts.workSans(
                                color: const Color(0xFF4542EB),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 1.40,
                                letterSpacing: -0.50,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '10:00',
                              style: GoogleFonts.workSans(
                                color: const Color(0xFF4542EB),
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                height: 1.20,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildPreferredQuestTypes(),
        ],
      ),
    );
  }

  Widget _buildQuestItem(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFCB9B)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                Assets.svgIcons.insightCheckBox.path,
                height: 21.6,
                width: 21.6,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.workSans(
                  color: const Color(0xFF011F54), // Text-text-default
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.40,
                  letterSpacing: -0.90,
                ),
              ),
            ],
          ),
          Image.asset(
            Assets.svgIcons.buttonCalendarComplate.path,
            height: 32,
            width: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferredQuestTypes() {
    final preferredTypes = _insightsData!.monthly.preferredQuestTypes;
    final softStepsPct = preferredTypes.softStepsPct.toStringAsFixed(1);
    final powerMovesPct = preferredTypes.powerMovesPct.toStringAsFixed(1);
    
    // Calculate width factor for gradient (0.0 to 1.0)
    final softStepsWidthFactor = preferredTypes.softStepsPct / 100;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 295,
            child: Text(
              'Preferred quest types',
              style: GoogleFonts.workSans(
                color: const Color(0xFF011F54),
                fontSize: 20,
                fontWeight: FontWeight.w800,
                height: 1.20,
                letterSpacing: -0.50,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 295,
            child: Text(
              preferredTypes.summary,
              style: GoogleFonts.workSans(
                color: const Color(0xFF4C586E),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.40,
                letterSpacing: -0.50,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 97,
            decoration: ShapeDecoration(
              color: const Color(0xFFFAE3CE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8 * softStepsWidthFactor,
                    height: 97,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.89, 0.00),
                        end: Alignment(0.00, 0.00),
                        colors: [
                          Color(0xFFFF8F26),
                          Color(0x00FF8F26),
                        ],
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 10,
                  child: SizedBox(
                    width: 95,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Text(
                          'Soft moves',
                          style: GoogleFonts.workSans(
                            color: const Color(0xFF011F54),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          '$softStepsPct%',
                          style: GoogleFonts.workSans(
                            color: const Color(0xFF011F54),
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 10,
                  child: SizedBox(
                    width: 112,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: [
                        Text(
                          'Power moves',
                          style: GoogleFonts.workSans(
                            color: const Color(0xFF011F54),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          '$powerMovesPct%',
                          style: GoogleFonts.workSans(
                            color: const Color(0xFF011F54),
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyReflection() {
    final weekly = _insightsData!.weekly;
    final completionRate = weekly.totalQuests > 0
        ? weekly.questsCompleted / weekly.totalQuests
        : 0.0;
    
    return Container(
      decoration: BoxDecoration(color: AppColorsApps.lightBlueBackground),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly reflection',
                textAlign: TextAlign.center,
                style: GoogleFonts.workSans(
                  color: const Color(0xFF011F54),
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  height: 1.20,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 16,
                  right: 12,
                  bottom: 8,
                ),
                decoration: ShapeDecoration(
                  color: const Color(
                    0xFFC3DBFF,
                  ), // Background-bg-primary-level-2
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'This week',
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF011F54),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.40,
                        letterSpacing: -0.50,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(Assets.images.arow.path, height: 20, width: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quests completed',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.workSans(
                                color: const Color(
                                  0xFF011F54,
                                ), // Text-text-default
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1,
                                letterSpacing: -0.50,
                              ),
                            ),
                            Text(
                              '${weekly.questsCompleted}/${weekly.totalQuests}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.workSans(
                                color: const Color(
                                  0xFF011F54,
                                ), // Text-text-default
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                height: 0.80,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E8FF),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: completionRate,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Color(0xFFDFEFFF), Color(0xFF4542EB)],
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInsightItem(
                        'You’ve been most consistent on Thursdays 🌿 ',
                      ),
                      const SizedBox(height: 12),
                      _buildInsightItem(
                        'You tend to complete more tasks on days you report feeling neutral or focused',
                      ),
                      const SizedBox(height: 12),
                      _buildInsightItem(
                        'Your average mood this week improved by 12%',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your mood',
                        style: GoogleFonts.workSans(
                          color: const Color(0xFF011F54),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          height: 1.20,
                          letterSpacing: -0.50,
                        ),
                      ),
                      const SizedBox(height: 20),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: _buildMoodBar(
                                  60,
                                  const Color(0xFF5DADE2),
                                  '😰',
                                  'Mon',
                                ),
                              ),
                              Expanded(
                                child: _buildMoodBar(
                                  80,
                                  const Color(0xFFFFB74D),
                                  '😊',
                                  'Tue',
                                ),
                              ),
                              Expanded(
                                child: _buildMoodBar(
                                  70,
                                  const Color(0xFFFF8A65),
                                  '😠',
                                  'Wed',
                                ),
                              ),
                              Expanded(
                                child: _buildMoodBar(
                                  100,
                                  const Color(0xFFE57373),
                                  '😡',
                                  'Thu',
                                ),
                              ),
                              Expanded(
                                child: _buildMoodBar(
                                  90,
                                  const Color(0xFF81C784),
                                  '😄',
                                  'Fri',
                                ),
                              ),
                              Expanded(
                                child: _buildMoodBar(
                                  75,
                                  const Color(0xFFFFD54F),
                                  '😊',
                                  'Sat',
                                ),
                              ),
                              Expanded(
                                child: _buildMoodBar(
                                  50,
                                  const Color(0xFFFFB74D),
                                  '😊',
                                  'Sun',
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your progress',
                        style: GoogleFonts.workSans(
                          color: const Color(0xFF011F54),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          height: 1.20,
                          letterSpacing: -0.50,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildProgressItem('Soft steps', 8, 10),
                      const SizedBox(height: 12),
                      _buildProgressItem('Stretch Zone', 3, 10),
                      const SizedBox(height: 12),
                      _buildProgressItem('Elevated', 5, 10),
                      const SizedBox(height: 12),
                      _buildProgressItem('Power move', 1, 10),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 276,
                        child: Text(
                          'Skipped days',
                          style: GoogleFonts.workSans(
                            color: const Color(0xFF011F54),
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            height: 1.20,
                            letterSpacing: -0.50,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 276,
                        height: 39,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'You usually skip ',
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
                              TextSpan(
                                text: 'Sundays.',
                                style: GoogleFonts.workSans(
                                  color: const Color(0xFF011F54),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  height: 1.40,
                                  letterSpacing: -0.50,
                                ),
                              ),
                              TextSpan(
                                text: ' Maybe a rest day?',
                                style: GoogleFonts.workSans(
                                  color: const Color(0xFF011F54),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.40,
                                  letterSpacing: -0.50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xFF6A68EF), // Border-border-subtle
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Yes, It’s my rest day',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.workSans(
                                color: const Color(
                                  0xFF4542EB,
                                ), // Text-text-primary
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressItem(String title, int completed, int total) {
    double progress = completed / total;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Title
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A2B4F),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Progress bar
          Expanded(
            child: Container(
              height: 25,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8FF),
                borderRadius: BorderRadius.circular(25),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFFDFEFFF), Color(0xFF4542EB)],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Count
          Text(
            '$completed/$total',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A2B4F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyOverview() {
    return Container(
      decoration: BoxDecoration(color: AppColorsApps.babyBlue),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Monthly Overview', style: AppsTextStyles.extraBold32Centered),
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.only(
                top: 8,
                left: 16,
                right: 12,
                bottom: 8,
              ),
              decoration: ShapeDecoration(
                color: const Color(0xFF89B6F7), // Background-bg-primary-level-3
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'This month',
                    style: GoogleFonts.workSans(
                      color: const Color(0xFF011F54),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.40,
                      letterSpacing: -0.50,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset(
                      Assets.images.arow.path,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 346,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quests completed',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A2B4F),
                          ),
                        ),
                        Text(
                          '66/100',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A2B4F),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 25,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E8FF),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: 0.66,
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xFFDFEFFF), Color(0xFF4542EB)],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'January',
                        style: GoogleFonts.workSans(
                          color: const Color(0xFF011F54),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          height: 1.20,
                          letterSpacing: -0.50,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildWeekdayHeaders(),
                      const SizedBox(height: 16),
                      _buildCalendarGrid(),
                      const SizedBox(height: 24),
                      _buildLegend(),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),
            SizedBox(
              width: 287,
              child: Text(
                'Add personal note',
                style: GoogleFonts.workSans(
                  color: const Color(0xFF011F54), // Text-text-default
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  letterSpacing: -0.50,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: 346,
              height: 87,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE8E8FF), width: 1),
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Write short note to yourself for this month...',
                  style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekdayHeaders() {
    const weekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: GoogleFonts.workSans(
                color: const Color(
                  0xFFADB2BC,
                ), // Placeholder / secondary text color
                fontSize: 16,
                fontWeight: FontWeight.w400, // Regular
                height: 1.4,
                letterSpacing: -0.5,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final calendarStatuses = _getCalendarStatuses();
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 35,
      itemBuilder: (context, index) {
        final emoji = dayEmojis[index];
        if (index >= calendarStatuses.length) {
          return _buildDayCircle(
            DayStatus.empty,
            index - calendarStatuses.length + 1,
            emoji: emoji,
          );
        }
        return _buildDayCircle(calendarStatuses[index], index + 1, emoji: emoji);
      },
    );
  }

  Widget _buildDayCircle(DayStatus status, int day, {String? emoji}) {
    Color backgroundColor;
    Color borderColor;
    String? imagePath;

    switch (status) {
      case DayStatus.skipped:
        backgroundColor = Color(0xFFFEDCDC);
        borderColor = const Color(0xFFD32F2F);
        imagePath = Assets.svgImages.xCircle.path;
        break;
      case DayStatus.consistent:
        backgroundColor = const Color(0xFFFFE4CC);
        borderColor = const Color(0xFFFF8C42);
        imagePath = Assets.svgImages.rigthSymbol.path;
        break;
      case DayStatus.streak:
        backgroundColor = const Color(0xFFE3EAFF);
        borderColor = const Color(0xFF4A6FFF);
        imagePath = Assets.svgImages.vector.path;
        break;
      case DayStatus.empty:
        backgroundColor = const Color(0xFFF5F5F5);
        borderColor = Colors.transparent;
        imagePath = null;
        break;
    }

    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: status == DayStatus.streak
                  ? Border.all(color: borderColor, width: 2.5)
                  : null,
            ),
            child: Center(
              child: imagePath != null
                  ? Image.asset(imagePath, width: 20, height: 20)
                  : null,
            ),
          ),
          if (emoji != null)
            Positioned(
              top: -6,
              right: -4,
              child: Text(emoji, style: const TextStyle(fontSize: 16)),
            ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        _buildLegendItem(
          color: const Color(0xFFD32F2F),
          label: 'Skipped',
          icon: Icons.close,
        ),
        _buildLegendItem(
          color: const Color(0xFFFF8C42),
          label: 'Consistent',
          icon: Icons.check,
        ),
        _buildLegendItem(
          color: const Color(0xFF4A6FFF),
          label: 'Streak',
          icon: Icons.local_fire_department,
        ),
      ],
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required IconData icon,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildMilestonesAndAchievements() {
    final milestones = _insightsData!.monthly.milestones;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFFE0B2), width: 1),
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 296,
                    child: Text(
                      'Milestones & Achievements',
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF011F54), // Text-text-default
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        height: 1.20,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.svgIcons.questCompleted.path),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quest completed',
                          style: GoogleFonts.workSans(
                            color: const Color(0xFF4542EB), // Text-text-primary
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                            letterSpacing: -0.90,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              Assets.svgIcons.questComapltedSatrt.path,
                              height: 32,
                              width: 32,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${milestones.questsCompletedThisMonth}',
                              style: GoogleFonts.workSans(
                                color: const Color(
                                  0xFF4542EB,
                                ), // Text-text-primary
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                height: 1.20,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.svgIcons.longestStreak.path),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Longest streak',
                          style: GoogleFonts.workSans(
                            color: const Color(
                              0xFF8C4F15,
                            ), // Text-text-secondary-disabled
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                            letterSpacing: -0.90,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              Assets.svgIcons.longestStreakFire.path,
                              height: 32,
                              width: 32,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${milestones.longestStreakDays}',
                              style: GoogleFonts.workSans(
                                color: const Color(
                                  0xFFFF8F26,
                                ), // Text-text-secondary
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                height: 1.20,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4542EB),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Share my success',
                          style: GoogleFonts.workSans(
                            color: const Color(0xFFFFFDF7),
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            height: 1.40,
                            letterSpacing: -0.90,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Image.asset(
                          Assets.svgIcons.shareMySuccess.path,
                          height: 20,
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInsightItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 3),
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.svgIcons.loveBlue.path),
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: AppsTextStyles.regular16l)),
      ],
    );
  }

  Widget _buildMoodBar(double height, Color color, String emoji, String day) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 8),
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 4),
        Text(
          day,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
