import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';

class ProcrastinationScreen extends StatefulWidget {
  const ProcrastinationScreen({super.key});

  @override
  State<ProcrastinationScreen> createState() => _ProcrastinationScreenState();
}

class _ProcrastinationScreenState extends State<ProcrastinationScreen> {
  String selectedLanguage = "English";
  String selectedVoice = "";

  // -------------------------------
  // LANGUAGE BOTTOM SHEET
  // -------------------------------
  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 16,
              left: 20,
              right: 20,
              bottom: 40,
            ),
            decoration: ShapeDecoration(
              color: const Color(0xFFDFEFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Handle bar
                Container(
                  width: 38,
                  height: 4,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFBEC3CB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Content
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Language',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.workSans(
                          color: const Color(0xFF011F54),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          height: 1.20,
                          letterSpacing: -0.50,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Language options
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // English
                            _buildLanguageOption('English'),
                            const SizedBox(height: 24),

                            // Deutsch
                            _buildLanguageOption('Deutsch'),
                            const SizedBox(height: 24),

                            // Español
                            _buildLanguageOption('Español'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
        Navigator.pop(context);
        // Show voice selection after language is selected
        Future.delayed(const Duration(milliseconds: 300), () {
          _showVoiceBottomSheet();
        });
      },
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              language,
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                color: const Color(0xFF011F54),
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.40,
                letterSpacing: -0.90,
              ),
            ),
            // Radio button indicator
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedLanguage == language
                      ? const Color(0xFF4542EB)
                      : const Color(0xFFBEC3CB),
                  width: 2,
                ),
              ),
              child: selectedLanguage == language
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF4542EB),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------
  // VOICE BOTTOM SHEET
  // -------------------------------
  void _showVoiceBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 16,
              left: 20,
              right: 20,
              bottom: 40,
            ),
            decoration: ShapeDecoration(
              color: const Color(0xFFDFEFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Handle bar
                Container(
                  width: 38,
                  height: 4,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFBEC3CB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Content
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose voice',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.workSans(
                          color: const Color(0xFF011F54),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          height: 1.20,
                          letterSpacing: -0.50,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Voice options
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Female
                            _buildVoiceOption('Female'),
                            const SizedBox(height: 24),

                            // Male
                            _buildVoiceOption('Male'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVoiceOption(String voice) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedVoice = voice;
        });
        Navigator.pop(context);
      },
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              voice,
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                color: const Color(0xFF011F54),
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.40,
                letterSpacing: -0.90,
              ),
            ),
            // Radio button indicator
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedVoice == voice
                      ? const Color(0xFF4542EB)
                      : const Color(0xFFBEC3CB),
                  width: 2,
                ),
                color: selectedVoice == voice
                    ? const Color(0xFF4542EB)
                    : Colors.transparent,
              ),
              child: selectedVoice == voice
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------
  // MAIN SCREEN UI
  // -------------------------------
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
              // Close Button
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.close, color: Colors.blue),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // TITLE + IMAGES + BUTTONS
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'In one line, how does the procrastination show up to you?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4542EB),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // IMAGE STACK
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Assets.svgImages.twoColorPopupSpkeing
                                .image()
                                .image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Assets.svgImages.popupSpeking.image().image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: ClipOval(
                            child: Assets.svgImages.popUpSpekingTwoCarton.image(
                              width: 120,
                              height: 120,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 60),

                  // BUTTON ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Choose AI voice button
                      GestureDetector(
                        onTap: () {
                          // context.push("/aiVoice");
                          // context.go("");
                          context.push("/popSpkingLoding");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 3,
                                color: Color(0xFF4542EB),
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: Text(
                            'Choose AI voice',
                            style: GoogleFonts.workSans(
                              color: const Color(0xFF4542EB),
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              height: 0.8,
                            ),
                          ),
                        ),
                      ),

                      // Language selection button
                      GestureDetector(
                        onTap: () {
                          _showLanguageBottomSheet();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 3,
                                color: Color(0xFF4542EB),
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: Text(
                            selectedLanguage.isEmpty
                                ? 'English'
                                : selectedLanguage,
                            style: GoogleFonts.workSans(
                              color: const Color(0xFF4542EB),
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              height: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';

/// Voice states for the screen
enum VoiceState {
  idle, // Initial — just show the widget
  listening, // Holding mic — "i'm listening.. take your time"
  noInput, // Released with no audio — "You didn't say anything?"
  heard, // Audio detected — "I hear you."
  confirmed, // After "I hear you." — faded text + "Let's start!"
}

class ProcrastinationScreen extends StatefulWidget {
  const ProcrastinationScreen({super.key});

  @override
  State<ProcrastinationScreen> createState() => _ProcrastinationScreenState();
}

class _ProcrastinationScreenState extends State<ProcrastinationScreen>
    with SingleTickerProviderStateMixin {
  VoiceState _voiceState = VoiceState.idle;
  Timer? _listenTimer;
  Timer? _heardTimer;

  // Pulse animation controller for the listening ring
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _listenTimer?.cancel();
    _heardTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  // ─── Hold Start ───────────────────────────────────────────────
  void _onHoldStart(LongPressStartDetails details) {
    _listenTimer?.cancel();
    setState(() => _voiceState = VoiceState.listening);

    // Simulate: after 3 s of holding → "I hear you."
    _listenTimer = Timer(const Duration(seconds: 3), () {
      if (_voiceState == VoiceState.listening) {
        _onVoiceDetected();
      }
    });
  }

  // ─── Hold End (released early = no input) ─────────────────────
  void _onHoldEnd(LongPressEndDetails details) {
    _listenTimer?.cancel();
    if (_voiceState == VoiceState.listening) {
      setState(() => _voiceState = VoiceState.noInput);
    }
  }

  // ─── Voice detected ───────────────────────────────────────────
  void _onVoiceDetected() {
    setState(() => _voiceState = VoiceState.heard);

    // After 1.5 s show confirmed state
    _heardTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _voiceState = VoiceState.confirmed);
    });
  }

  // ─── Reset ────────────────────────────────────────────────────
  void _reset() {
    _listenTimer?.cancel();
    _heardTimer?.cancel();
    setState(() => _voiceState = VoiceState.idle);
  }

  // ─── Build overlay text based on state ────────────────────────
  Widget _buildStateText() {
    switch (_voiceState) {
      case VoiceState.idle:
        return const SizedBox.shrink();

      case VoiceState.listening:
        return Text(
          "i'm listening..\ntake your time",
          textAlign: TextAlign.center,
          style: GoogleFonts.workSans(
            color: const Color(0xFF4542EB),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.40,
            letterSpacing: -0.90,
          ),
        );

      case VoiceState.noInput:
        return Text(
          'You didn\'t say anything?\nHold and speak again.',
          textAlign: TextAlign.center,
          style: GoogleFonts.workSans(
            color: const Color(0xFF4542EB),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.40,
            letterSpacing: -0.90,
          ),
        );

      case VoiceState.heard:
        return Text(
          'I hear you.',
          textAlign: TextAlign.center,
          style: GoogleFonts.workSans(
            color: const Color(0xFF4542EB),
            fontSize: 24,
            fontWeight: FontWeight.w900,
            height: 0.80,
          ),
        );

      case VoiceState.confirmed:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'I hear you. Thanks for sharing that',
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                color: const Color(0x334542EB), // faded
                fontSize: 24,
                fontWeight: FontWeight.w900,
                height: 0.80,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Let\'s start!',
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                color: const Color(0xFF4542EB),
                fontSize: 24,
                fontWeight: FontWeight.w900,
                height: 0.80,
              ),
            ),
          ],
        );
    }
  }

  // ─── Build the speaking widget (holdable mic) ──────────────────
  Widget _buildSpeakingWidget() {
    final isListening = _voiceState == VoiceState.listening;

    return GestureDetector(
      onLongPressStart: _onHoldStart,
      onLongPressEnd: _onHoldEnd,
      onTap: () {
        // If in noInput or confirmed, tapping resets
        if (_voiceState == VoiceState.noInput ||
            _voiceState == VoiceState.confirmed) {
          _reset();
        }
      },
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          final scale = isListening ? _pulseAnimation.value : 1.0;
          return Transform.scale(scale: scale, child: child);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer ring (300×300)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Assets.svgImages.twoColorPopupSpkeing.image().image,
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
                // Glow when listening
                boxShadow: isListening
                    ? [
                        BoxShadow(
                          color: const Color(0xFF4542EB).withOpacity(0.35),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ]
                    : [],
              ),
            ),

            // Inner speaking widget (200×200)
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Assets.svgImages.popupSpeking.image().image,
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: ClipOval(
                  child: Assets.svgImages.popUpSpekingTwoCarton.image(
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
            ),

            // Listening indicator ring overlay
            if (isListening)
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF4542EB).withOpacity(0.6),
                    width: 3,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
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
              // ── Close / Back ──
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.close, color: Colors.blue),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // ── Question title ──
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'In one line, how does the procrastination show up to you?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4542EB),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // ── Speaking widget (holdable) ──
              _buildSpeakingWidget(),

              const SizedBox(height: 32),

              // ── Dynamic state text ──
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.15),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: KeyedSubtree(
                  key: ValueKey(_voiceState),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: _buildStateText(),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Hold hint (only in idle / noInput) ──
              if (_voiceState == VoiceState.idle ||
                  _voiceState == VoiceState.noInput)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Hold to speak',
                    style: GoogleFonts.workSans(
                      color: const Color(0xFF4542EB).withOpacity(0.45),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              // ── "Let's start" CTA button in confirmed state ──
              if (_voiceState == VoiceState.confirmed)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to next screen
                      // context.push('/nextScreen');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4542EB),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Continue',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.workSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
*/
