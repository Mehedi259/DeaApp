// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_app_dea/je_je_page_gula_connect_kori_nai.dart/ai_calling.dart';
// import 'package:mobile_app_dea/je_je_page_gula_connect_kori_nai.dart/quest_for_done_screen.dart';
// import 'package:mobile_app_dea/je_je_page_gula_connect_kori_nai.dart/steak_popup.dart';
// import 'package:mobile_app_dea/screen/Onboarding/onboarding_features/onbording_fetures.dart';
// import 'package:mobile_app_dea/screen/Onboarding/pop_spking_loding.dart';
// import 'package:mobile_app_dea/je_je_page_gula_connect_kori_nai.dart/popup_multi_misscal_talk.dart';
// import 'package:mobile_app_dea/screen/progress/progress.dart';

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true,
//       builder: (context) => const MyApp(), // Wrap your app
//     ),
//   );
// }
// // void main() {
// //   runApp(const MyApp());
// // }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812), // Ensure responsiveness
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return MaterialApp(
//           // useInheritedMediaQuery: true,
//           locale: DevicePreview.locale(context),
//           builder: DevicePreview.appBuilder,
//           debugShowCheckedModeBanner: false,
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//             textTheme:
//                 GoogleFonts.poppinsTextTheme(), // Optional: keeps your GoogleFonts styling
//           ),
//           home: const Progress(),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core%20/app_routes/app_pages.dart';

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode, // Enable only in development mode
//       builder: (context) => MyApp(), // Wrap the app in DevicePreview
//     ),
//   );
// }
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),

          routerConfig: AppPages.router,
        );
      },
    );
  }
}
