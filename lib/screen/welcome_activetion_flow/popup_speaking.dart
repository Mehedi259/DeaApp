import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';

class PopupSpeaking extends StatefulWidget {
  const PopupSpeaking({super.key});

  @override
  State<PopupSpeaking> createState() => _PopupSpeakingState();
}

class _PopupSpeakingState extends State<PopupSpeaking> with TickerProviderStateMixin {
  int currentScreen = 0;
  late AnimationController _pulseController;
  late AnimationController _rippleController;
  late Animation<double> _pulseAnimation;
  late List<Animation<double>> _rippleAnimations;
  String selectedVoice = 'Female';
  String selectedLanguage = 'English';
  String typingText = '';
  bool showLetsStart = false;

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    
    _rippleAnimations = List.generate(3, (index) {
      final delay = index * 0.33;
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _rippleController,
          curve: Interval(delay, 1.0, curve: Curves.easeOut),
        ),
      );
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  void _startTypingAnimation() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted && currentScreen == 1) {
        setState(() {
          showLetsStart = true;
        });
        _typeText("Let's start!");
      }
    });
  }

  void _typeText(String text) async {
    for (int i = 0; i <= text.length; i++) {
      if (mounted && currentScreen == 1) {
        await Future.delayed(Duration(milliseconds: 100));
        setState(() {
          typingText = text.substring(0, i);
        });
      }
    }
    
    // After typing completes, wait 1 second then navigate to loading screen
    if (mounted && currentScreen == 1) {
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        context.go('/noticeLoaderScreen');
      }
    }
  }

  Future<void> _requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      setState(() {
        currentScreen = 1;
        showLetsStart = false;
        typingText = '';
      });
      _startTypingAnimation();
    } else if (status.isDenied) {
      _showPermissionDeniedDialog();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFDFEFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          '"Nowlii" Would Like To Access The Microphone',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Nowlii will listen once you say something. Your voice stays private. Always.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontFamily: 'Work Sans',
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Don't Allow",
                    style: TextStyle(color: Color(0xFF4542EB)),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _requestMicrophonePermission();
                  },
                  child: Text(
                    'Allow',
                    style: TextStyle(color: Color(0xFF4542EB), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showVoiceSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: EdgeInsets.all(20),
        padding: const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 40),
        decoration: ShapeDecoration(
          color: const Color(0xFFDFEFFF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 4,
              decoration: ShapeDecoration(
                color: const Color(0xFFBEC3CB),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
              ),
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose voice',
                style: TextStyle(
                  color: const Color(0xFF011F54),
                  fontSize: 20,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w800,
                  height: 1.20,
                  letterSpacing: -0.50,
                ),
              ),
            ),
            SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                setState(() => selectedVoice = 'Female');
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Female',
                      style: TextStyle(
                        color: const Color(0xFF011F54),
                        fontSize: 18,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                        letterSpacing: -0.90,
                      ),
                    ),
                    if (selectedVoice == 'Female')
                      Icon(Icons.check, color: Color(0xFF4542EB), size: 18),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                setState(() => selectedVoice = 'Male');
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Male',
                      style: TextStyle(
                        color: const Color(0xFF011F54),
                        fontSize: 18,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                        letterSpacing: -0.90,
                      ),
                    ),
                    if (selectedVoice == 'Male')
                      Icon(Icons.check, color: Color(0xFF4542EB), size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: EdgeInsets.all(20),
        padding: const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 40),
        decoration: ShapeDecoration(
          color: const Color(0xFFDFEFFF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 4,
              decoration: ShapeDecoration(
                color: const Color(0xFFBEC3CB),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
              ),
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Language',
                style: TextStyle(
                  color: const Color(0xFF011F54),
                  fontSize: 20,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w800,
                  height: 1.20,
                  letterSpacing: -0.50,
                ),
              ),
            ),
            SizedBox(height: 32),
            ...[
              {'name': 'English', 'value': 'English'},
              {'name': 'Deutsch', 'value': 'Deutsch'},
              {'name': 'Español', 'value': 'Español'},
            ].map((lang) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: GestureDetector(
                onTap: () {
                  setState(() => selectedLanguage = lang['value']!);
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lang['name']!,
                      style: TextStyle(
                        color: const Color(0xFF011F54),
                        fontSize: 18,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                        letterSpacing: -0.90,
                      ),
                    ),
                    if (selectedLanguage == lang['value'])
                      Icon(Icons.check, color: Color(0xFF4542EB), size: 18),
                  ],
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA4CAFE),
      body: SafeArea(
        child: currentScreen == 0
            ? _buildInitialScreen()
            : currentScreen == 1
                ? _buildListeningScreen()
                : _buildQuestionScreen(),
      ),
    );
  }

  Widget _buildInitialScreen() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 
                     MediaQuery.of(context).padding.top - 
                     MediaQuery.of(context).padding.bottom,
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFC3DBFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(750.15),
                          ),
                        ),
                        child: Icon(Icons.close, size: 20, color: Color(0xFF4542EB)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Text(
                      "YOU'RE ALL SET, JULIE!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF011F54),
                        fontSize: 48,
                        fontFamily: 'Wosker',
                        fontWeight: FontWeight.w400,
                        height: 0.90,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Your Nowlii is ready to help you start strong.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF011F54),
                        fontSize: 16,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                        letterSpacing: -0.50,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFC3DBFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    shadows: [
                      BoxShadow(
                        color: Color(0x070A0C12),
                        blurRadius: 6,
                        offset: Offset(0, 4),
                        spreadRadius: -2,
                      ),
                      BoxShadow(
                        color: Color(0x140A0C12),
                        blurRadius: 16,
                        offset: Offset(0, 12),
                        spreadRadius: -4,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Let's do a quick voice check!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF011F54),
                          fontSize: 28,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w800,
                          height: 1.20,
                          letterSpacing: -1,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Tell me how you feel today - no pressure, just say it out loud. 🎧',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF011F54),
                          fontSize: 14,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                          letterSpacing: -0.50,
                        ),
                      ),
                      SizedBox(height: 25),
                      GestureDetector(
                        onLongPressStart: (_) async {
                          await _requestMicrophonePermission();
                        },
                        onLongPressEnd: (_) {
                          Future.delayed(Duration(seconds: 2), () {
                            if (currentScreen == 1) {
                              setState(() => currentScreen = 2);
                            }
                          });
                        },
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: ShapeDecoration(
                            gradient: RadialGradient(
                              center: Alignment(0.50, 0.50),
                              radius: 0.73,
                              colors: [const Color(0xFF7270F3), const Color(0xFF3F3CD6)],
                            ),
                            shape: OvalBorder(),
                            shadows: [
                              BoxShadow(
                                color: Color(0x995550FF),
                                blurRadius: 19.60,
                                offset: Offset(0, 0),
                                spreadRadius: 11,
                              )
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/dea_png/Popup_Speaking.png",
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        'Hold to speak 🎙️\nNowlii will listen once you say something.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF4542EB),
                          fontSize: 14,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                          letterSpacing: -0.50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListeningScreen() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 
                     MediaQuery.of(context).padding.top - 
                     MediaQuery.of(context).padding.bottom,
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.auto_awesome, color: Color(0xFF4542EB), size: 24),
                    SizedBox(width: 8),
                    Text(
                      'AI',
                      style: TextStyle(
                        color: const Color(0xFF4542EB),
                        fontSize: 28,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w900,
                        height: 0.80,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'I hear you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF4542EB),
                  fontSize: 24,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w900,
                  height: 0.80,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Thanks for sharing that.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0x334542EB),
                  fontSize: 24,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w900,
                  height: 0.80,
                ),
              ),
              SizedBox(height: 15),
              if (showLetsStart)
                Text(
                  typingText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF4542EB),
                    fontSize: 24,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w900,
                    height: 0.80,
                  ),
                ),
              Spacer(),
              Center(
                child: AnimatedBuilder(
                  animation: Listenable.merge([_pulseController, _rippleController]),
                  builder: (context, child) {
                    return SizedBox(
                      width: 300,
                      height: 300,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ..._rippleAnimations.asMap().entries.map((entry) {
                            final animation = entry.value;
                            final scale = 1.0 + (animation.value * 0.5);
                            final opacity = 1.0 - animation.value;
                            
                            return Transform.scale(
                              scale: scale,
                              child: Opacity(
                                opacity: opacity * 0.4,
                                child: Container(
                                  width: 240,
                                  height: 240,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF4542EB),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              width: 240,
                              height: 240,
                              decoration: ShapeDecoration(
                                color: const Color(0x664542EB),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Container(
                            width: 180,
                            height: 180,
                            decoration: ShapeDecoration(
                              gradient: RadialGradient(
                                center: Alignment(0.50, 0.50),
                                radius: 0.73,
                                colors: [const Color(0xFF7270F3), const Color(0xFF3F3CD6)],
                              ),
                              shape: OvalBorder(),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x995550FF),
                                  blurRadius: 19.60,
                                  offset: Offset(0, 0),
                                  spreadRadius: 11,
                                )
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: _pulseAnimation.value * 0.98,
                            child: Image.asset(
                              "assets/dea_png/Popup_Speaking.png",
                              width: 110,
                              height: 110,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _showVoiceSelection,
                        child: Container(
                          height: 44,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: const Color(0xFF4542EB)),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Choose AI voice',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF4542EB),
                                fontSize: 16,
                                fontFamily: 'Work Sans',
                                fontWeight: FontWeight.w900,
                                height: 0.80,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: _showLanguageSelection,
                        child: Container(
                          height: 44,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: const Color(0xFF4542EB)),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              selectedLanguage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF4542EB),
                                fontSize: 16,
                                fontFamily: 'Work Sans',
                                fontWeight: FontWeight.w900,
                                height: 0.80,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionScreen() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 
                     MediaQuery.of(context).padding.top - 
                     MediaQuery.of(context).padding.bottom,
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFC3DBFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(750.15),
                          ),
                        ),
                        child: Icon(Icons.close, size: 20, color: Color(0xFF4542EB)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: Text(
                  'In one line, how does the procrastination show up to you?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF4542EB),
                    fontSize: 20,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w800,
                    height: 1.20,
                    letterSpacing: -0.50,
                  ),
                ),
              ),
              Spacer(),
              Center(
                child: Container(
                  width: 240,
                  height: 240,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 240,
                        height: 240,
                        decoration: ShapeDecoration(
                          color: const Color(0x664542EB),
                          shape: OvalBorder(),
                        ),
                      ),
                      Container(
                        width: 180,
                        height: 180,
                        decoration: ShapeDecoration(
                          gradient: RadialGradient(
                            center: Alignment(0.50, 0.50),
                            radius: 0.73,
                            colors: [const Color(0xFF7270F3), const Color(0xFF3F3CD6)],
                          ),
                          shape: OvalBorder(),
                          shadows: [
                            BoxShadow(
                              color: Color(0x995550FF),
                              blurRadius: 19.60,
                              offset: Offset(0, 0),
                              spreadRadius: 11,
                            )
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/dea_png/Popup_Speaking.png",
                        width: 110,
                        height: 110,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _showVoiceSelection,
                        child: Container(
                          height: 44,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: const Color(0xFF4542EB)),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Choose AI voice',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF4542EB),
                                fontSize: 16,
                                fontFamily: 'Work Sans',
                                fontWeight: FontWeight.w900,
                                height: 0.80,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: _showLanguageSelection,
                        child: Container(
                          height: 44,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: const Color(0xFF4542EB)),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              selectedLanguage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF4542EB),
                                fontSize: 16,
                                fontFamily: 'Work Sans',
                                fontWeight: FontWeight.w900,
                                height: 0.80,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
