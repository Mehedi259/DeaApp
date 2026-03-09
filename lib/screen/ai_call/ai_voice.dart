import 'package:flutter/material.dart';
import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';

class AiVoice extends StatefulWidget {
  const AiVoice({super.key});

  @override
  State<AiVoice> createState() => _AiVoiceState();
}

class _AiVoiceState extends State<AiVoice> {
  int currentSeconds = 81; // 01:21
  final int totalSeconds = 600; // 10:00
  bool isPaused = true;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.svgImages.popupScreeLiner.image().image,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Title Section
              Text('Answer emails 📧', style: AppsTextStyles.black24Uppercase),
              const SizedBox(height: 8),
              Text(
                'You\'re doing great — keep it going',
                style: AppsTextStyles.regular16l,
              ),

              const Spacer(),

              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 266,
                    height: 253,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Assets.svgImages.callStarted.image().image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Timer Display
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: Image.asset(
                          'assets/images/puse.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 9,
                    children: [
                      Text(
                        '05:43',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(
                            0xFF4542EB,
                          ) /* Text-text-primary */,
                          fontSize: 52,
                          fontFamily: 'Wosker',
                          fontWeight: FontWeight.w400,
                          height: 0.80,
                        ),
                      ),
                      Text(
                        '/',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(
                            0xFFA9A8F6,
                          ) /* Text-text-primary-disabled */,
                          fontSize: 52,
                          fontFamily: 'Wosker',
                          fontWeight: FontWeight.w400,
                          height: 0.80,
                        ),
                      ),
                      Text(
                        '10:00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(
                            0xFFA9A8F6,
                          ) /* Text-text-primary-disabled */,
                          fontSize: 52,
                          fontFamily: 'Wosker',
                          fontWeight: FontWeight.w400,
                          height: 0.80,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: 335,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8,
                      children: [
                        SizedBox(
                          width: 64,
                          height: 64,
                          child: Image.asset(
                            'assets/images/Microphone!.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 64,
                          height: 64,
                          child: Image.asset(
                            'assets/images/soubd_icon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Container(
                        //   width: 64,
                        //   height: 64,
                        //   padding: const EdgeInsets.all(10),

                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     spacing: 10,
                        //     children: [
                        //       Container(width: 24, height: 24, child: Stack()),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 12,
                      children: [
                        SizedBox(
                          width: 64,
                          height: 64,
                          // padding: const EdgeInsets.all(10),
                          // decoration: ShapeDecoration(
                          //   color: const Color(
                          //     0xFFC3DBFF,
                          //   ) /* Background-bg-primary-level-2 */,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(999),
                          //   ),
                          // ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Handle "Mark as done" tap
                                  context.push("/homeScreen");
                                },
                                child: Image.asset(
                                  'assets/images/right_sound.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(
                            'Mark as done',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(
                                0xFF011F54,
                              ) /* Text-text-default */,
                              fontSize: 12,
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
