import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/create_qutes.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';
import 'package:mobile_app_dea/utlis/color_palette/color_palette.dart';

class ProfileNotificationsScreen extends StatelessWidget {
  const ProfileNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              Assets.svgImages.profile.path,
              fit: BoxFit.cover,
            ),
          ),
          // Scrollable Content
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildProfileSection(context),
                      const SizedBox(height: 20),
                      _buildNotificationsSection(context),
                    ],
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

Widget _buildProfileSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(Assets.svgIcons.profileBack.path, () {
              context.pop();
            }),
            _buildIconButton(Assets.svgIcons.settingProfile.path, () {
              context.push('/settingsScreen');
            }),
          ],
        ),
        const SizedBox(height: 20),

        // Profile Picture
        Center(
          child: Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  image: DecorationImage(
                    image: AssetImage(Assets.svgIcons.editProfilePng_.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 20,
                bottom: 90,
                child: Container(
                  padding: const EdgeInsets.all(4),

                  child: Image.asset(
                    Assets.images.love.path,
                    height: 26,
                    width: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Center(
        //   child: Stack(
        //     children: [
        //       Container(
        //         width: 120,
        //         height: 120,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           border: Border.all(color: Colors.white, width: 4),
        //           image: DecorationImage(
        //             image: AssetImage(Assets.svgIcons.editProfilePng_.path),
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         left: 95,
        //         bottom: 70,
        //         child: Container(
        //           padding: const EdgeInsets.all(4),

        //           child: Image.asset(
        //             Assets.images.love.path,
        //             height: 32,
        //             width: 32,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const SizedBox(height: 65),

        // Profile Card
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColorsApps.softCream1,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // Name Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.svgIcons.fireTab.path,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 8),

                      Text(
                        '1 day streak',
                        style: GoogleFonts.workSans(
                          color: const Color(0xFF011F54), // Text-text-default
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          height: 1.20,
                          letterSpacing: -0.50,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Quests Active
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.svgIcons.magicWand.path,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '32 quests active',
                        style: GoogleFonts.workSans(
                          color: const Color(0xFF011F54), // Text-text-default
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          height: 1.20,
                          letterSpacing: -0.50,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Optional Image — tap to open NowliProSubscription
                  Assets.svgIcons.nowliJuli.path.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            context.push('/nowliProSubscription');
                          },
                          child: Image.asset(
                            Assets.svgIcons.nowliJuli.path,
                            height: 87,
                            width: 303,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),

            // JULIE Badge
            Positioned(
              top: -68,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 74,
                  width: 265,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7FFF00),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'JULIE',
                      textAlign: TextAlign.center,
                      style: AppTextStylesQutes.alfaSlabOneTitle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Action Buttons
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActionButton(
              'Edit Profile',
              Assets.svgIcons.editProfilePng__.path,
              () {
                context.push('/editProfileScreen');
              },
            ),
            const SizedBox(height: 12),
            _buildActionButton(
              'Contact support',
              Assets.svgIcons.contactSupport.path,
              () {
                context.push('/supportScreen');
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildNotificationsSection(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;

  return Container(
    constraints: BoxConstraints(minHeight: screenHeight * 0.5),
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Notifications Header - FIXED
        Row(
          children: [
            Text('NOTIFICATIONS', style: AppsTextStyles.signupText32),
            const SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFA0E871),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '2',
                style: GoogleFonts.workSans(
                  color: const Color(0xFF011F54),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Today Section
        const Text(
          'Today',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),

        _buildNotificationCard(
          iconPath: Assets.svgIcons.profileNotificationLove.path,
          title: "Fizzy noticed you're most productive around 11am.",
          subtitle: "Let's use that time strategically!",
          action: 'Create task',
          time: '9m',
          isNew: true,
        ),
        const SizedBox(height: 12),

        _buildNotificationCard(
          iconPath: Assets.svgIcons.fireLove.path,
          title: "🔥 You've kept your streak for 3 days straight — keep going!",
          subtitle: "You completed 7 quests today. Tiny wins really add up.",
          action: 'See progress',
          time: '2h',
        ),
        const SizedBox(height: 20),

        // Yesterday Section
        const Text(
          'Yesterday',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),

        _buildNotificationCard(
          iconPath: Assets.svgIcons.yoyyRese.path,
          title: "You reached your first 7-day streak",
          subtitle: "That's real consistency!",
          action: 'See progress',
          time: '1d',
        ),

        const SizedBox(height: 40),
      ],
    ),
  );
}

Widget _buildIconButton(String assetPath, VoidCallback onPressed) {
  return IconButton(icon: Image.asset(assetPath), onPressed: onPressed);
}

Widget _buildActionButton(
  String text,
  String assetPath,
  VoidCallback onPressed,
) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColorsApps.skyBlue2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(assetPath, width: 28, height: 28),
          const SizedBox(width: 8),
          Text(text, style: AppsTextStyles.workSansBlack20),
        ],
      ),
    ),
  );
}

Widget _buildNotificationCard({
  IconData? icon,
  String? iconPath,
  required String title,
  required String subtitle,
  required String action,
  required String time,
  bool isNew = false,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF8F9FA),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: iconPath != null
              ? Image.asset(iconPath, width: 50, height: 50)
              : Icon(icon, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          action,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4A90E2),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Color(0xFF4A90E2),
                        ),
                      ],
                    ),
                  ),
                  if (isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7FFF00),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'NEW',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
