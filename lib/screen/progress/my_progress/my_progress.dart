import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/create_qutes.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';

class MyProgress extends StatelessWidget {
  const MyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStreakCard(),
              const SizedBox(height: 16),
              _buildWeeklyStreak(),
              const SizedBox(height: 24),
              _buildMovesSection(),
              const SizedBox(height: 24),
              _buildActivityTrend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreakCard() {
    return Container(
      height: 410,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/svg_icons/120Days.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 302,
            child: Text(
              'Daily streak',
              style: GoogleFonts.workSans(
                color: const Color(0xFF011F54),
                fontSize: 32,
                fontWeight: FontWeight.w800,
                height: 1.2,
                letterSpacing: -1,
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 302,
            child: Text(
              "You've stayed consistent for \n7 days straight!",
              style: GoogleFonts.workSans(
                color: const Color(0xFF011F54),
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 1.4,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: ShapeDecoration(
              color: const Color(0xFFFF8F26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Assets.svgIcons.fire.path, width: 40, height: 40),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    '120 DAYS',
                    style: TextStyle(
                      color: const Color(0xFF3F3CD6),
                      fontSize: 48,
                      fontFamily: 'Wosker',
                      fontWeight: FontWeight.w400,
                      height: 0.80,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 80,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset(
                Assets.svgIcons.shareMySuccess.path,
                width: 24,
                height: 24,
              ),
              label: Text(
                'Share',
                textAlign: TextAlign.center,
                style: GoogleFonts.workSans(
                  color: const Color(0xFFFFFDF7),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  height: 0.80,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyStreak() {
    final days = ['Fri', 'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              7,
              (index) => Column(
                children: [
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: Center(
                      child: Image.asset(
                        index == 6
                            ? Assets.svgIcons.blue.path
                            : Assets.svgIcons.sunButton.path,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    days[index],
                    style: AppTextStylesQutes.workSansSemiBold18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 24,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFC3DBFF),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: constraints.maxWidth * 0.53,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFFDFEFFF), Color(0xFF4542EB)],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '7-Day Streak',
                style: GoogleFonts.workSans(
                  color: const Color(0xFF4C586E),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                  letterSpacing: -0.9,
                ),
              ),
              Text(
                '23% to 30 days',
                style: GoogleFonts.workSans(
                  color: const Color(0xFF4542EB),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMovesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFFCB9B)),
        color: const Color(0xFFFFFCF1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Your moves', style: AppTextStylesQutes.workSansBlack20),
              Container(
                padding: const EdgeInsets.only(
                  top: 4,
                  left: 8,
                  right: 4,
                  bottom: 4,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFAE3CE),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1,
                        letterSpacing: -0.5,
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
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMoveCircle(
                '8',
                'Soft Moves',
                const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF3BB64B), Color(0x003BB64B)],
                  stops: [0.0, 1.075],
                ),
                0.75,
                isPartial: true,
                trackColor: const Color(0xFFE8EDE0),
              ),
              _buildMoveCircle(
                '22',
                'Power moves',
                const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF4542EB), Color(0x004542EB)],
                  stops: [0.0, 1.075],
                ),
                1.0,
                isPartial: false,
                trackColor: Colors.transparent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoveCircle(
    String count,
    String label,
    LinearGradient gradient,
    double sweepFraction, {
    bool isPartial = true,
    Color trackColor = const Color(0xFFE8EDE0),
  }) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GradientRingCircle(
                label: count,
                gradient: gradient,
                labelColor: gradient.colors.first,
                sweepFraction: sweepFraction,
                trackColor: trackColor,
                isPartial: isPartial,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityTrend() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFDFEFFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC3DBFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    const Icon(Icons.trending_up, color: Color(0xFF1E3A8A), size: 20),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'Activity trend',
                        style: AppsTextStyles.black24Uppercase,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.only(
                  top: 4,
                  left: 8,
                  right: 4,
                  bottom: 4,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFFC3DBFF),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1,
                        letterSpacing: -0.5,
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
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Completed quests per day',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 20,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun',
                        ];
                        return Text(
                          days[value.toInt()],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 5,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _buildBar(0, 8),
                  _buildBar(1, 12),
                  _buildBar(2, 10),
                  _buildBar(3, 14),
                  _buildBar(4, 12),
                  _buildBar(5, 18),
                  _buildBar(6, 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFFDFEFFF), Color(0xFF4542EB)],
          ),
          width: 34.14,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Gradient Ring Circle Widget
// ─────────────────────────────────────────────
class GradientRingCircle extends StatelessWidget {
  final String label;
  final LinearGradient gradient;
  final Color labelColor;
  final double sweepFraction; // 0.0 – 1.0
  final Color trackColor;
  final bool isPartial;

  const GradientRingCircle({
    super.key,
    required this.label,
    required this.gradient,
    required this.labelColor,
    required this.sweepFraction,
    required this.trackColor,
    required this.isPartial,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 112,
      height: 112,
      child: CustomPaint(
        painter: GradientRingPainter(
          gradient: gradient,
          strokeWidth: 15,
          sweepFraction: sweepFraction,
          trackColor: trackColor,
          isPartial: isPartial,
        ),
        child: Center(
          child: Text(
            label,
            // style: TextStyle(
            //   fontSize: 28,
            //   fontWeight: FontWeight.bold,
            //   color: labelColor,
            // ),
            style: GoogleFonts.workSans(
              color: labelColor, // Text-text-green
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.20,
              letterSpacing: -0.50,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Custom Painter
// ─────────────────────────────────────────────
class GradientRingPainter extends CustomPainter {
  final LinearGradient gradient;
  final double strokeWidth;
  final double sweepFraction; // 0.0 – 1.0
  final Color trackColor;
  final bool isPartial;

  GradientRingPainter({
    required this.gradient,
    required this.strokeWidth,
    required this.sweepFraction,
    required this.trackColor,
    required this.isPartial,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    // ── Track (background circle) ──────────────────
    if (trackColor != Colors.transparent) {
      final trackPaint = Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawCircle(center, radius, trackPaint);
    }

    // ── Gradient arc / ring ────────────────────────
    final gradientPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (isPartial) {
      final startAngle = (-220) * (pi / 180);
      final sweepAngle = sweepFraction * 2 * pi;
      canvas.drawArc(rect, startAngle, sweepAngle, false, gradientPaint);
    } else {
      // Full ring
      gradientPaint.strokeCap = StrokeCap.butt;
      canvas.drawCircle(center, radius, gradientPaint);
    }
  }

  @override
  bool shouldRepaint(covariant GradientRingPainter oldDelegate) {
    return oldDelegate.sweepFraction != sweepFraction ||
        oldDelegate.gradient != gradient;
  }
}

/*
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/create_qutes.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';

class MyProgress extends StatelessWidget {
  const MyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStreakCard(),
              const SizedBox(height: 16),
              _buildWeeklyStreak(),
              const SizedBox(height: 24),
              _buildMovesSection(),
              const SizedBox(height: 24),
              _buildActivityTrend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreakCard() {
    return Container(
      height: 410,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/svg_icons/120Days.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 302,
            child: Text(
              'Daily streak',
              style: GoogleFonts.workSans(
                color: const Color(0xFF011F54),
                fontSize: 32,
                fontWeight: FontWeight.w800,
                height: 1.2,
                letterSpacing: -1,
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 302,
            child: Text(
              "You've stayed consistent for \n7 days straight!",
              style: GoogleFonts.workSans(
                color: const Color(0xFF011F54),
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 1.4,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ✅ FIX 1: Use intrinsic sizing with Flexible text to prevent overflow
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: ShapeDecoration(
              color: const Color(0xFFFF8F26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Assets.svgIcons.fire.path, width: 44, height: 44),
                const SizedBox(width: 8),
                // ✅ FittedBox prevents the large Wosker font from overflowing
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '120 DAYS',
                      style: TextStyle(
                        color: const Color(0xFF3F3CD6),
                        fontSize: 52,
                        fontFamily: 'Wosker',
                        fontWeight: FontWeight.w400,
                        height: 0.80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 80,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset(
                Assets.svgIcons.shareMySuccess.path,
                width: 24,
                height: 24,
              ),
              label: Text(
                'Share',
                textAlign: TextAlign.center,
                style: GoogleFonts.workSans(
                  color: const Color(0xFFFFFDF7),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  height: 0.80,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyStreak() {
    final days = ['Fri', 'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              7,
              (index) => Column(
                children: [
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: Center(
                      child: Image.asset(
                        index == 6
                            ? Assets.svgIcons.blue.path
                            : Assets.svgIcons.sunButton.path,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    days[index],
                    style: AppTextStylesQutes.workSansSemiBold18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 24,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFC3DBFF),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: constraints.maxWidth * 0.53,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFFDFEFFF), Color(0xFF4542EB)],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '7-Day Streak',
                style: GoogleFonts.workSans(
                  color: const Color(0xFF4C586E),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                  letterSpacing: -0.9,
                ),
              ),
              Text(
                '23% to 30 days',
                style: GoogleFonts.workSans(
                  color: const Color(0xFF4542EB),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMovesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFFCB9B)),
        color: const Color(0xFFFFFCF1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Your moves', style: AppTextStylesQutes.workSansBlack20),
              Container(
                padding: const EdgeInsets.only(
                  top: 4,
                  left: 8,
                  right: 4,
                  bottom: 4,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFAE3CE),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1,
                        letterSpacing: -0.5,
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
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(
                    Assets.images.eight.path,
                    width: 139,
                    height: 178,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    Assets.images.twintytwo.path,
                    width: 139,
                    height: 178,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoveCircle(
    String count,
    String label,
    LinearGradient gradient,
    double progress,
  ) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      gradient.colors.first.withValues(alpha: 0.1),
                      gradient.colors.first.withValues(alpha: 0.05),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 85,
                height: 85,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: gradient.colors.first.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    gradient.colors.first,
                  ),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                count,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: gradient.colors.first,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityTrend() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFDFEFFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC3DBFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ FIX 2: Wrap this Row's children safely to prevent overflow at line ~469
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.trending_up, color: Color(0xFF1E3A8A)),
                    const SizedBox(width: 8),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Activity trend',
                          style: AppsTextStyles.black24Uppercase,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.only(
                  top: 4,
                  left: 8,
                  right: 4,
                  bottom: 4,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFFC3DBFF),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1,
                        letterSpacing: -0.5,
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
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Completed quests per day',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 20,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun',
                        ];
                        return Text(
                          days[value.toInt()],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 5,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _buildBar(0, 8),
                  _buildBar(1, 12),
                  _buildBar(2, 10),
                  _buildBar(3, 14),
                  _buildBar(4, 12),
                  _buildBar(5, 18),
                  _buildBar(6, 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFFDFEFFF), Color(0xFF4542EB)],
          ),
          width: 34.14,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }
}
*/
