import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_dea/core%20/app_routes/app_routes.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';

class AiVoice extends StatefulWidget {
  const AiVoice({super.key});

  @override
  State<AiVoice> createState() => _AiVoiceState();
}

class _AiVoiceState extends State<AiVoice> with TickerProviderStateMixin {
  // Timer management
  late Duration _totalDuration;
  late Duration _elapsedTime;
  Timer? _timer;
  bool _isPaused = false;
  bool _isMuted = false;
  
  // Animation controllers
  late AnimationController _progressController;
  late AnimationController _pulseController;
  
  // State flags
  bool _showTimeWarning = false;
  bool _showMuteWarning = false;
  bool _showWrapUpDialog = false;
  bool _questCompleted = false;

  @override
  void initState() {
    super.initState();
    _totalDuration = const Duration(minutes: 10);
    _elapsedTime = Duration.zero;
    
    // Progress animation
    _progressController = AnimationController(
      vsync: this,
      duration: _totalDuration,
    );
    
    // Pulse animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    _startCall();
  }

  void _startCall() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && mounted) {
        setState(() {
          _elapsedTime = Duration(seconds: _elapsedTime.inSeconds + 1);
          
          // Update progress
          _progressController.value = _elapsedTime.inSeconds / _totalDuration.inSeconds;
          
          // Check for 5 minute mark (not 8)
          if (_elapsedTime.inMinutes == 8 && _elapsedTime.inSeconds % 60 == 0 && !_showTimeWarning) {
            _showTimeWarning = true;
          }
          
          // Quest completed
          if (_elapsedTime.inSeconds >= _totalDuration.inSeconds) {
            _onQuestComplete();
          }
        });
      }
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      if (_isMuted) {
        _showMuteWarning = true;
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _showMuteWarning = false;
            });
          }
        });
      }
    });
  }

  void _addTenMinutes() {
    setState(() {
      _totalDuration = Duration(minutes: _totalDuration.inMinutes + 10);
      _showTimeWarning = false;
    });
    
    // Show success popup
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF4542EB),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                '10 more minutes added',
                style: TextStyle(
                  color: const Color(0xFF011F54),
                  fontSize: 20,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You can now talk to me 10 more minutes!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF595754),
                  fontSize: 16,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    
    // Auto close after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  void _onQuestComplete() {
    setState(() {
      _questCompleted = true;
    });
    _timer?.cancel();
    
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(AppRoutespath.callSummary);
      }
    });
  }

  void _markAsDone() {
    setState(() {
      _showWrapUpDialog = true;
    });
  }

  void _onWrapUpYes() {
    _timer?.cancel();
    _onQuestComplete();
  }

  void _onWrapUpContinue() {
    setState(() {
      _showWrapUpDialog = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}';
  }

  Color get _backgroundColor {
    if (_questCompleted) return const Color(0xFFCCFFAA);
    if (_showTimeWarning) return const Color(0xFFFF8F26);
    return const Color(0xFF91BBF9);
  }

  Color get _timerColor {
    if (_questCompleted) return const Color(0xFF3BB64B);
    if (_showTimeWarning) return const Color(0xFFFF8F26);
    return const Color(0xFF4542EB);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: _backgroundColor,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 40),

                  // Title Section
                  Text(
                    _questCompleted ? 'Answer emails ✉️ ✓' : 'Answer emails 📧',
                    style: AppsTextStyles.black24Uppercase,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _questCompleted
                        ? 'Take a deep breath - you did great.\nI\'ll be here when you\'re ready for the next one.'
                        : _totalDuration.inMinutes > 10
                            ? 'New energy, new ${_totalDuration.inMinutes} minutes!'
                            : 'You\'re doing great — keep it going',
                    style: AppsTextStyles.regular16l,
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),

                  // Avatar with progress
                  _buildAvatarWithProgress(size),
                  
                  const Spacer(),

                  // Quest completed text
                  if (_questCompleted)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'QUEST\nCOMPLETED',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF3BB64B),
                          fontSize: 52,
                          fontFamily: 'Wosker',
                          fontWeight: FontWeight.w400,
                          height: 0.8,
                        ),
                      ),
                    ),

                  // Timer Display
                  if (!_questCompleted)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _togglePause,
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFFC3DBFF),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _isPaused ? Icons.play_arrow : Icons.pause,
                                color: const Color(0xFF4542EB),
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  Text(
                                    _formatDuration(_elapsedTime),
                                    style: TextStyle(
                                      color: _timerColor,
                                      fontSize: 52,
                                      fontFamily: 'Wosker',
                                      fontWeight: FontWeight.w400,
                                      height: 0.80,
                                    ),
                                  ),
                                  Text(
                                    ' / ',
                                    style: TextStyle(
                                      color: _timerColor.withOpacity(0.5),
                                      fontSize: 52,
                                      fontFamily: 'Wosker',
                                      fontWeight: FontWeight.w400,
                                      height: 0.80,
                                    ),
                                  ),
                                  Text(
                                    _formatDuration(_totalDuration),
                                    style: TextStyle(
                                      color: _timerColor.withOpacity(0.5),
                                      fontSize: 52,
                                      fontFamily: 'Wosker',
                                      fontWeight: FontWeight.w400,
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

                  const SizedBox(height: 40),

                  // Controls
                  if (!_questCompleted)
                    SizedBox(
                      width: 335,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: _toggleMute,
                                child: Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: _isMuted ? const Color(0xFFFFE5E5) : const Color(0xFFC3DBFF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _isMuted ? Icons.mic_off : Icons.mic,
                                    color: _isMuted ? Colors.red : const Color(0xFF4542EB),
                                    size: 28,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  // Volume control - TODO: Implement volume functionality
                                },
                                child: Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC3DBFF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.volume_up,
                                    color: const Color(0xFF4542EB),
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _markAsDone,
                                child: SizedBox(
                                  width: 64,
                                  height: 64,
                                  child: Image.asset(
                                    'assets/images/right_sound.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Mark as done',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF011F54),
                                  fontSize: 12,
                                  fontFamily: 'Work Sans',
                                  fontWeight: FontWeight.w600,
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
              
              // Time warning popup
              if (_showTimeWarning && !_questCompleted)
                _buildTimeWarningPopup(),
              
              // Mute warning
              if (_showMuteWarning)
                _buildMuteWarning(),
              
              // Wrap up dialog
              if (_showWrapUpDialog)
                _buildWrapUpDialog(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarWithProgress(Size size) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final pulseValue = _pulseController.value;
        
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outermost pulse ring (animated)
            if (!_questCompleted)
              Container(
                width: 320 + (pulseValue * 40),
                height: 320 + (pulseValue * 40),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.5,
                    colors: [
                      _timerColor.withOpacity(0),
                      _timerColor.withOpacity(0.1 * (1 - pulseValue)),
                    ],
                  ),
                ),
              ),
            
            // Middle pulse ring
            if (!_questCompleted)
              Container(
                width: 300 + (pulseValue * 20),
                height: 300 + (pulseValue * 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.5,
                    colors: [
                      _timerColor.withOpacity(0),
                      _timerColor.withOpacity(0.2 * (1 - pulseValue)),
                    ],
                  ),
                ),
              ),
            
            // Progress ring
            SizedBox(
              width: 280,
              height: 280,
              child: CircularProgressIndicator(
                value: _progressController.value,
                strokeWidth: 8,
                backgroundColor: _timerColor.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation(_timerColor),
              ),
            ),
            
            // Inner glow
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _timerColor.withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
            
            // Avatar image with scale animation
            Transform.scale(
              scale: 1.0 + (pulseValue * 0.05),
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Assets.svgImages.callStarted.image().image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimeWarningPopup() {
    return Positioned(
      top: 100,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: const Color(0xFFFFFCF1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x070A0C12),
              blurRadius: 6,
              offset: Offset(0, 4),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Call ending soon!',
              style: TextStyle(
                color: const Color(0xFF011F54),
                fontSize: 20,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w800,
                height: 1.2,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'You can add 10 more minutes to your call!',
              style: TextStyle(
                color: const Color(0xFF595754),
                fontSize: 14,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w400,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addTenMinutes,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8F26),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 18, color: const Color(0xFF011F54)),
                  const SizedBox(width: 8),
                  Text(
                    'Add 10 minutes',
                    style: TextStyle(
                      color: const Color(0xFF011F54),
                      fontSize: 18,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMuteWarning() {
    return Positioned(
      top: 100,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: const Color(0xFFFFFCF1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.mic_off, color: const Color(0xFF011F54)),
            const SizedBox(width: 12),
            Text(
              'You\'re muted',
              style: TextStyle(
                color: const Color(0xFF011F54),
                fontSize: 18,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWrapUpDialog() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(24),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 50, color: const Color(0xFF4542EB)),
                const SizedBox(height: 16),
                Text(
                  'Wrap up already?',
                  style: TextStyle(
                    color: const Color(0xFF011F54),
                    fontSize: 24,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'No rush — but if you\'re done, let\'s mark this quest complete.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF595754),
                    fontSize: 16,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _onWrapUpContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: const Color(0xFF4542EB), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                  child: Text(
                    'Continue a bit longer',
                    style: TextStyle(
                      color: const Color(0xFF4542EB),
                      fontSize: 18,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _onWrapUpYes,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4542EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                  child: Text(
                    'Yes, I\'m done',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
