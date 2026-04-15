import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nowlii/core/gen/assets.gen.dart';
import 'package:nowlii/themes/text_styles.dart';
import 'package:nowlii/utlis/color_palette/color_palette.dart';
import 'package:nowlii/api/profile_controller.dart';
import 'package:nowlii/api/profile_model.dart';

class EditNameScreen extends StatefulWidget {
  const EditNameScreen({super.key});

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  final PageController _pageController = PageController();
  final ProfileController _profileController = ProfileController();

  String _selectedName = '';
  bool _isLoading = false;
  ProfileModel? _currentProfile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    
    await _profileController.fetchProfile();
    
    if (_profileController.profile != null) {
      setState(() {
        _currentProfile = _profileController.profile;
        // Load existing custom name or nowlii name
        _selectedName = _currentProfile?.customNowliiName ?? 
                       _currentProfile?.nowliiName ?? 
                       '';
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateAvatarName() async {
    if (_selectedName.trim().isEmpty) {
      _showErrorDialog('Please select or enter a name');
      return;
    }

    setState(() => _isLoading = true);

    final success = await _profileController.updateProfile(
      customNowliiName: _selectedName.trim(),
    );

    setState(() => _isLoading = false);

    if (success) {
      _showSuccessDialog('Avatar name updated successfully!');
    } else {
      _showErrorDialog(_profileController.errorMessage ?? 'Failed to update avatar name');
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsApps.iceBlue,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      Assets.svgIcons.editProfilePng.path,
                      height: 32,
                      width: 32,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {});
                },
                children: [
                  NameSelectionPage(
                    selectedName: _selectedName,
                    currentProfile: _currentProfile,
                    onNameSelected: (name) {
                      setState(() {
                        _selectedName = name;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _isLoading ? null : _updateAvatarName,
              child: Container(
                width: 335,
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
                decoration: ShapeDecoration(
                  color: _isLoading 
                      ? Colors.grey 
                      : const Color(0xFF4542EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 20,
                  children: [
                    if (_isLoading)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    else
                      Text(
                        'Update',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.workSans(
                          color: const Color(0xFFFFFDF7),
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          height: 0.80,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class NameSelectionPage extends StatefulWidget {
  final String selectedName;
  final ProfileModel? currentProfile;
  final Function(String) onNameSelected;

  const NameSelectionPage({
    super.key,
    required this.selectedName,
    this.currentProfile,
    required this.onNameSelected,
  });

  @override
  State<NameSelectionPage> createState() => _NameSelectionPageState();
}

class _NameSelectionPageState extends State<NameSelectionPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  bool _showTextField = false;
  int _currentAvatarIndex = 0;
  bool _showNameDisplay = true;

  // Avatar list with PNG images
  final List<AvatarData> avatars = [
    AvatarData(
      name: 'KNOTTY',
      assetPath: 'assets/svg_images/A.png',
      isLottie: false,
    ),
    AvatarData(
      name: 'BLOOBY',
      assetPath: 'assets/svg_images/B.png',
      isLottie: false,
    ),
    AvatarData(
      name: 'FIZZY',
      assetPath: 'assets/svg_images/C.png',
      isLottie: false,
    ),
    AvatarData(
      name: 'BOUNCY',
      assetPath: 'assets/svg_images/D.png',
      isLottie: false,
    ),
    AvatarData(
      name: 'ZIPPY',
      assetPath: 'assets/svg_images/E.png',
      isLottie: false,
    ),
    AvatarData(
      name: 'MELON',
      assetPath: 'assets/svg_images/F.png',
      isLottie: false,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );

    // Load existing avatar name if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.currentProfile != null) {
        final existingName = widget.currentProfile!.customNowliiName ?? 
                            widget.currentProfile!.nowliiName ?? '';
        
        if (existingName.isNotEmpty) {
          // Check if it matches any preset avatar
          final matchedIndex = avatars.indexWhere(
            (avatar) => avatar.name.toUpperCase() == existingName.toUpperCase()
          );
          
          if (matchedIndex != -1) {
            setState(() {
              _currentAvatarIndex = matchedIndex;
            });
          } else {
            // It's a custom name
            setState(() {
              _showTextField = true;
              _nameController.text = existingName;
            });
          }
          widget.onNameSelected(existingName);
        } else {
          widget.onNameSelected(avatars[_currentAvatarIndex].name);
        }
      } else {
        widget.onNameSelected(avatars[_currentAvatarIndex].name);
      }
    });
  }

  void _rotateAvatar() {
    setState(() {
      _currentAvatarIndex = (_currentAvatarIndex + 1) % avatars.length;
      _showTextField = false;
      _nameController.clear();
    });
    widget.onNameSelected(avatars[_currentAvatarIndex].name);
    _bounceController.forward(from: 0);
  }

  void _showCustomNameInput() {
    setState(() {
      _showTextField = true;
    });
  }

  void _onCustomNameChanged(String value) {
    if (value.trim().length >= 2 && value.trim().length <= 12) {
      widget.onNameSelected(value.trim());
      _bounceController.forward(from: 0);
    } else if (value.trim().isEmpty) {
      widget.onNameSelected('');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 335,
              child: Text(
                'HOW WOULD YOU LIKE TO CALL your form?',
                style: GoogleFonts.workSans(
                  color: const Color(0xFF011F54),
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  height: 0.90,
                  letterSpacing: -0.50,
                ),
              ),
            ),
            const SizedBox(height: 8),

            const SizedBox(height: 32),

            // Character with animation and border radius
            ScaleTransition(
              scale: _bounceAnimation,
              child: Container(
                height: screenHeight * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: CharacterWidget(
                    assetPath: _showTextField
                        ? avatars[0].assetPath
                        : avatars[_currentAvatarIndex].assetPath,
                    avatarUrl: widget.currentProfile?.avatarLogo,
                    onEditTap: () {
                      // Add your edit functionality here
                      debugPrint('Edit icon tapped');
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Name display or input
            if (!_showTextField && _showNameDisplay) ...[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      avatars[_currentAvatarIndex].name,
                      style: AppsTextStyles.signupText28,
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: _rotateAvatar,
                      child: Image.asset(
                        Assets.svgIcons.buttonRegular.path,
                        width: 66,
                        height: 44,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: _showCustomNameInput,
                    icon: Image.asset(
                      Assets.svgIcons.onBordingPlus.path,
                      width: 18,
                      height: 18,
                    ),
                    label: Text(
                      'Edit Name',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF011F54),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        height: 0.80,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColorsApps.darkBlue,
                      side: const BorderSide(
                        color: AppColorsApps.darkBlue,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ] else if (_showTextField) ...[
              // Custom name input
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: TextField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  maxLength: 12,
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B),
                    letterSpacing: 2,
                  ),
                  decoration: InputDecoration(
                    hintText: 'TYPE SOMETHING FUN...',
                    hintStyle: AppsTextStyles.typeSomeThingHere,
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  onChanged: _onCustomNameChanged,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        _showTextField = false;
                        _showNameDisplay = true;
                        if (_nameController.text.trim().isEmpty) {
                          widget.onNameSelected(
                            avatars[_currentAvatarIndex].name,
                          );
                        }
                      });
                    },
                    icon: const Icon(Icons.close, size: 18),
                    label: Text(
                      'Back to suggestions',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF011F54),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        height: 0.80,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColorsApps.darkBlue,
                      side: const BorderSide(
                        color: AppColorsApps.darkBlue,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Avatar data model
class AvatarData {
  final String name;
  final String assetPath;
  final bool isLottie;

  AvatarData({
    required this.name,
    required this.assetPath,
    this.isLottie = false,
  });
}

class CharacterWidget extends StatelessWidget {
  final String assetPath;
  final String? avatarUrl;
  final VoidCallback? onEditTap;

  const CharacterWidget({
    super.key, 
    required this.assetPath, 
    this.avatarUrl,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main image - show network image if available, otherwise local asset
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: avatarUrl != null && avatarUrl!.isNotEmpty
              ? Image.network(
                  avatarUrl!,
                  width: 260,
                  height: 210,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      assetPath,
                      width: 260,
                      height: 210,
                      fit: BoxFit.cover,
                    );
                  },
                )
              : Image.asset(
                  assetPath,
                  width: 260,
                  height: 210,
                  fit: BoxFit.cover,
                ),
        ),

        // Edit icon on the right side (top-right)
        Positioned(
          right: 12,
          top: 12,
          child: GestureDetector(
            onTap: () {
              context.push("/editFrom");
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.edit, size: 18, color: Color(0xFF011F54)),
            ),
          ),
        ),
      ],
    );
  }
}
