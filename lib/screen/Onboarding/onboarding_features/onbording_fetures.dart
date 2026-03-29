import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';

class OnboardingFeatures extends StatelessWidget {
  const OnboardingFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    final isSmallDevice = screenHeight < 700;
    final isMediumDevice = screenHeight >= 700 && screenHeight < 800;
    final topPadding = screenHeight * 0.01;
    final horizontalPadding = screenWidth * 0.04;
    final headerTitleSpacing = isSmallDevice
        ? 8.0
        : (isMediumDevice ? 16.0 : 24.0);
    final titleCardSpacing = isSmallDevice
        ? 8.0
        : (isMediumDevice ? 16.0 : 24.0);
    final buttonBottomSpacing = isSmallDevice
        ? 8.0
        : (isMediumDevice ? 10.0 : 12.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            top: topPadding,
            bottom: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top bar
              _buildTopBar(context, size, isSmallDevice, isMediumDevice),
              SizedBox(height: headerTitleSpacing),
              Text(
                "MEET NOWLII",
                style: AppsTextStyles.black24Uppercase.copyWith(
                  fontSize: isSmallDevice
                      ? 18.0
                      : (isMediumDevice ? 22.0 : 28.0),
                ),
              ),
              SizedBox(height: titleCardSpacing),

              /// Feature cards
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildResponsiveCard(
                        color: Colors.blue.shade300,
                        svgPath: Assets.svgIcons.realCompany.path,
                        title: "REAL \nCOMPANY",
                        description:
                            "Nowlii is your always-available friend. Here for you - anytime, anywhere.",
                        isSmallDevice: isSmallDevice,
                        isMediumDevice: isMediumDevice,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: _buildResponsiveCard(
                        color: Colors.orange.shade400,
                        svgPath: Assets.svgIcons.dailyMoments.path,
                        title: "DAILY \nMOMENTS",
                        description:
                            "Whether you're walking, shopping, or hitting the gym - Nowlii joins in.",
                        isSmallDevice: isSmallDevice,
                        isMediumDevice: isMediumDevice,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: _buildResponsiveCard(
                        color: Colors.green.shade400,
                        svgPath: Assets.svgIcons.emotionalSupport.path,
                        title: "EMOTIONAL \nSUPPORT",
                        description:
                            "Low on motivation? Feeling alone? Nowlii listens, nudges, and cheers you on.",
                        isSmallDevice: isSmallDevice,
                        isMediumDevice: isMediumDevice,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ),
                    const SizedBox(height: 10),

                    /// Let's start button
                    GestureDetector(
                      onTap: () => context.push("/nowliHowToUse"),
                      child: Container(
                        width: double.infinity,
                        height: 116,
                        padding: const EdgeInsets.only(
                          top: 8,
                          left: 24,
                          right: 8,
                          bottom: 8,
                        ),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFF8F26),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          shadows: [
                            BoxShadow(
                              color: const Color(0x070A0C12),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                              spreadRadius: -2,
                            ),
                            BoxShadow(
                              color: const Color(0x140A0C12),
                              blurRadius: 16,
                              offset: const Offset(0, 12),
                              spreadRadius: -4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Let\'s start',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                  color: const Color(0xFF011F54),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  height: 0.8,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF011F54),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: SvgPicture.asset(
                                Assets.svgIcons.startLetsGo.path,
                                width: 60,
                                height: 60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(height: buttonBottomSpacing),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(
    BuildContext context,
    Size size,
    bool isSmallDevice,
    bool isMediumDevice,
  ) {
    final screenWidth = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => context.push("/onboardingFlow"),
          child: SizedBox(
            width: isSmallDevice ? 44 : (isMediumDevice ? 50 : 56),
            height: isSmallDevice ? 44 : (isMediumDevice ? 50 : 56),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                Assets.svgIcons.backIconSvg.path,
                width: isSmallDevice ? 44 : (isMediumDevice ? 50 : 56),
                height: isSmallDevice ? 44 : (isMediumDevice ? 50 : 56),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.015),
        Expanded(
          child: Container(
            height: isSmallDevice ? 6 : 8,
            decoration: ShapeDecoration(
              color: const Color(0xFFC3DBFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.5,
              child: Container(
                decoration: ShapeDecoration(
                  color: const Color(0xFF3D87F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.01),
        Text(
          '3/6',
          style: GoogleFonts.workSans(
            color: const Color(0xFF4C586E),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.40,
          ),
        ),
        SizedBox(width: screenWidth * 0.015),
        GestureDetector(
          onTap: () => context.push("/nowliHowToUse"),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallDevice ? 8 : 12,
              vertical: isSmallDevice ? 6 : 8,
            ),
            child: Text(
              'Skip',
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                color: const Color(0xFF011F54),
                fontSize: 18,
                fontWeight: FontWeight.w900,
                height: 0.80,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveCard({
    required Color color,
    required String svgPath,
    required String title,
    required String description,
    required bool isSmallDevice,
    required bool isMediumDevice,
    required double screenWidth,
    required double screenHeight,
  }) {
    final cardPadding = isSmallDevice ? 10.0 : (isMediumDevice ? 14.0 : 16.0);
    final spaceBetween = isSmallDevice ? 10.0 : (isMediumDevice ? 16.0 : 16.0);
    final textSpacing = isSmallDevice ? 4.0 : (isMediumDevice ? 6.0 : 8.0);
    final titleFontSize = isSmallDevice ? 20.0 : (isMediumDevice ? 22.0 : 36.0);
    // final iconSize = isSmallDevice ? 70.0 : (isMediumDevice ? 98.0 : 97.0);
    // এই লাইনটা delete করুন
    // final iconSize = isSmallDevice ? 70.0 : (isMediumDevice ? 98.0 : 97.0);
    final iconSize = isSmallDevice ? 70.0 : (isMediumDevice ? 98.0 : 110.0);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(cardPadding),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgPath,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
          ),
          SizedBox(width: spaceBetween),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFF011F54),
                      fontSize: titleFontSize,
                      fontFamily: 'Wosker',
                      fontWeight: FontWeight.w400,

                      // ✅ height: 0.95 use kora hoyeche
                      // Default height: 1.1 thakle line gap beshi mone hoto,
                      // especially "EMOTIONAL \nSUPPORT" er moton 2-line title e.
                      // 0.95 dile actual line height = fontSize × 0.95,
                      // mane lines gulo ektu kache ashe — tighter & cleaner dekha jay.
                      height: 0.80,

                      letterSpacing: 0.68,
                    ),
                  ),
                ),
                SizedBox(height: textSpacing),
                Flexible(
                  child: Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.workSans(
                      color: const Color(0xFF011F54),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.50,
                      letterSpacing: -0.50,
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

  static Widget buildCard({
    required Color color,
    required String svgPath,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(svgPath, width: 97, height: 100),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF011F54),
                    fontSize: 32,
                    fontFamily: 'Wosker',
                    fontWeight: FontWeight.w400,

                    // ✅ Static buildCard e-o same fix apply kora hoyeche.
                    // height: 0.95 — 2-line title gulo tighter dekhabe.
                    height: 0.95,

                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.workSans(
                    color: const Color(0xFF011F54),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: -0.50,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
