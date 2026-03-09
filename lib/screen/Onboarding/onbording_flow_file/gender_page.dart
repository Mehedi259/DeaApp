// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_app_dea/themes/text_styles.dart';

// class GenderPage extends StatelessWidget {
//   final String userName;
//   final String selectedGender;
//   final Function(String) onGenderSelected;

//   const GenderPage({
//     super.key,
//     required this.userName,
//     required this.selectedGender,
//     required this.onGenderSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Screen size for responsive spacing
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: const Color(0xFFD9E5F5),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minHeight: screenHeight - MediaQuery.of(context).padding.top,
//             ),
//             child: IntrinsicHeight(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'HEY ${userName.toUpperCase()}!',
//                     style: TextStyle(
//                       color: const Color(0xFF011F54) /* Background-bg-dark */,
//                       fontSize: 52,
//                       fontFamily: 'Wosker',
//                       fontWeight: FontWeight.w400,
//                       height: 0.80,
//                     ),
//                   ),
//                   Text(
//                     'WHICH GENDER DESCRIBES YOU?',
//                     style: TextStyle(
//                       color: const Color(0xFF011F54) /* Background-bg-dark */,
//                       fontSize: 48,
//                       fontFamily: 'Wosker',
//                       fontWeight: FontWeight.w400,
//                       height: 0.80,
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   GenderButton(
//                     text: 'I\'m a man',
//                     value: 'man',
//                     isSelected: selectedGender == 'man',
//                     onPressed: () => onGenderSelected('man'),
//                   ),
//                   const SizedBox(height: 10),
//                   GenderButton(
//                     text: 'I\'m a woman',
//                     value: 'woman',
//                     isSelected: selectedGender == 'woman',
//                     onPressed: () => onGenderSelected('woman'),
//                   ),
//                   const SizedBox(height: 10),
//                   GenderButton(
//                     text: 'Another gender',
//                     value: 'other',
//                     isSelected: selectedGender == 'other',
//                     onPressed: () => onGenderSelected('other'),
//                   ),
//                   // const Spacer(),
//                   const SizedBox(height: 160),

//                   Text(
//                     'You can always update this later. We’ve got you.',
//                     style: GoogleFonts.workSans(
//                       color: const Color(0xFF4C586E),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       height: 1.60,
//                     ),
//                   ),
//                   // const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class GenderButton extends StatelessWidget {
//   final String text;
//   final String value;
//   final bool isSelected;
//   final VoidCallback onPressed;

//   const GenderButton({
//     super.key,
//     required this.text,
//     required this.value,
//     required this.isSelected,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         height: 70,
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 18),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF5865F2) : const Color(0xFFD9E5F5),
//           borderRadius: BorderRadius.circular(35),
//           border: Border.all(color: const Color(0xFF4542EB), width: 2.5),
//         ),
//         child: Center(
//           child: Text(
//             text,
//             textAlign: TextAlign.center,
//             style: GoogleFonts.workSans(
//               color: isSelected ? Colors.white : const Color(0xFF4542EB),
//               fontSize: 22,
//               fontWeight: FontWeight.w900,
//               height: 1.0,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderPage extends StatelessWidget {
  final String userName;
  final String selectedGender;
  final Function(String) onGenderSelected;

  const GenderPage({
    super.key,
    required this.userName,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFD9E5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight - MediaQuery.of(context).padding.top,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HEY ${userName.toUpperCase()}!',
                    style: TextStyle(
                      color: const Color(0xFF011F54),
                      fontSize: 52.sp,
                      fontFamily: 'Wosker',
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                    ),
                  ),
                  Text(
                    'WHICH GENDER DESCRIBES YOU?',
                    style: TextStyle(
                      color: const Color(0xFF011F54),
                      fontSize: 48.sp,
                      fontFamily: 'Wosker',
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  GenderButton(
                    text: 'I\'m a man',
                    value: 'man',
                    isSelected: selectedGender == 'man',
                    onPressed: () => onGenderSelected('man'),
                  ),
                  SizedBox(height: 10.h),
                  GenderButton(
                    text: 'I\'m a woman',
                    value: 'woman',
                    isSelected: selectedGender == 'woman',
                    onPressed: () => onGenderSelected('woman'),
                  ),
                  SizedBox(height: 10.h),
                  GenderButton(
                    text: 'Another gender',
                    value: 'other',
                    isSelected: selectedGender == 'other',
                    onPressed: () => onGenderSelected('other'),
                  ),
                  SizedBox(height: 140.h),
                  Text(
                    'You can always update this later. We\'ve got you.',
                    style: GoogleFonts.workSans(
                      color: const Color(0xFF4C586E),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.60,
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
}

class GenderButton extends StatelessWidget {
  final String text;
  final String value;
  final bool isSelected;
  final VoidCallback onPressed;

  const GenderButton({
    super.key,
    required this.text,
    required this.value,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 70.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5865F2) : const Color(0xFFD9E5F5),
          borderRadius: BorderRadius.circular(35.r),
          border: Border.all(color: const Color(0xFF4542EB), width: 2.5.w),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.workSans(
              color: isSelected ? Colors.white : const Color(0xFF4542EB),
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
