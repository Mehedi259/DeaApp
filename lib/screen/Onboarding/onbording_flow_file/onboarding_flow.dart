import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_dea/core%20/app_routes/app_routes.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/screen/Onboarding/onbording_flow_file/gender_page.dart';
import 'package:mobile_app_dea/screen/Onboarding/onbording_flow_file/name_page.dart'
    show NamePage;

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int currentPage = 0;
  final PageController _pageController = PageController();
  String userName = '';
  String selectedGender = '';

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage < 4) {
      setState(() {
        currentPage++;
      });
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {}
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void updateName(String name) {
    setState(() {
      userName = name;
    });
  }

  void selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        context.go(AppRoutespath.loadingOnboardingNowli);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E4F0),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: previousPage,
                    icon: Assets.svgIcons.signUnBackScrren.svg(height: 60),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC3DBFF),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: (currentPage + 1) / 5,
                          child: Container(
                            height: 14,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3D87F5),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${currentPage + 1}/5',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A2B5F),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  NamePage(
                    onContinue: nextPage,
                    onNameChanged: updateName,
                    initialName: userName,
                  ),
                  GenderPage(
                    userName: userName,
                    selectedGender: selectedGender,
                    onGenderSelected: selectGender,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
