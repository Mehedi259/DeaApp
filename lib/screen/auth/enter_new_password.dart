// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_app_dea/core/gen/assets.gen.dart' show Assets;
// import 'package:mobile_app_dea/themes/text_styles.dart' show AppsTextStyles;
// import 'package:mobile_app_dea/screen/auth/password_updated_popup_screen.dart'
//     show PasswordUpdatedPopupScreen;

// class EnterNewPassword extends StatefulWidget {
//   const EnterNewPassword({super.key});

//   @override
//   State<EnterNewPassword> createState() => _EnterNewPasswordState();
// }

// class _EnterNewPasswordState extends State<EnterNewPassword> {
//   bool _obscurePassword = true;
//   bool _isButtonEnabled = false;

//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   final _passwordFocus = FocusNode();
//   final _confirmPasswordFocus = FocusNode();

//   bool _isPasswordValid = false;
//   bool _isConfirmPasswordValid = false;

//   @override
//   void initState() {
//     super.initState();
//     _newPasswordController.addListener(_validateForm);
//     _confirmPasswordController.addListener(_validateForm);
//   }

//   @override
//   void dispose() {
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     _passwordFocus.dispose();
//     _confirmPasswordFocus.dispose();
//     super.dispose();
//   }

//   void _validateForm() {
//     final isValid =
//         _newPasswordController.text.isNotEmpty &&
//         _confirmPasswordController.text.isNotEmpty &&
//         _isPasswordValid &&
//         _newPasswordController.text == _confirmPasswordController.text;
//     if (isValid != _isButtonEnabled) {
//       setState(() => _isButtonEnabled = isValid);
//     }
//   }

//   void _onPasswordChanged(String value) {
//     final valid =
//         value.isNotEmpty &&
//         value.length >= 8 &&
//         RegExp(
//           r'^(?=.*[A-Z])',
//         ).hasMatch(value) && // At least one uppercase letter
//         RegExp(
//           r'^(?=.*[a-z])',
//         ).hasMatch(value) && // At least one lowercase letter
//         RegExp(r'^(?=.*\d)').hasMatch(value) && // At least one number
//         RegExp(
//           r'^(?=.*[!@#$%^&*()_+=[\]{};:,.<>?/\\|`~-])',
//         ).hasMatch(value); // At least one special character

//     if (valid != _isPasswordValid) {
//       setState(() => _isPasswordValid = valid);
//     }
//     _validateForm();
//   }

//   void _onConfirmPasswordChanged(String value) {
//     final valid = value == _newPasswordController.text;
//     if (valid != _isConfirmPasswordValid) {
//       setState(() => _isConfirmPasswordValid = valid);
//     }
//     _validateForm();
//   }

//   InputDecoration _fieldDecoration({
//     required String label,
//     required String hint,
//     Widget? suffixIcon,
//     required TextStyle labelStyle,
//   }) {
//     const borderSide = BorderSide(color: Color(0xFFC3DBFF), width: 1);
//     final borderRadius = BorderRadius.circular(30);

//     final fixedBorder = OutlineInputBorder(
//       borderRadius: borderRadius,
//       borderSide: borderSide,
//       gapPadding: 8,
//     );

//     return InputDecoration(
//       labelText: label,
//       hintText: hint,
//       floatingLabelBehavior: FloatingLabelBehavior.auto,
//       floatingLabelAlignment: FloatingLabelAlignment.start,
//       floatingLabelStyle: labelStyle,
//       labelStyle: const TextStyle(color: Colors.black54),
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
//       enabledBorder: fixedBorder,
//       focusedBorder: fixedBorder,
//       errorBorder: fixedBorder.copyWith(
//         borderSide: const BorderSide(color: Colors.red, width: 2),
//       ),
//       focusedErrorBorder: fixedBorder.copyWith(
//         borderSide: const BorderSide(color: Colors.red, width: 2),
//       ),
//       suffixIcon: suffixIcon,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFFCF1),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Top Icons Row
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: Assets.svgIcons.backIconSvg.svg(
//                         height: 60,
//                         width: 60,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Assets.svgIcons.signInPageIcon.svg(height: 80, width: 80),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(
//                   width: 335,
//                   child: Text(
//                     'ENTER NEW  \nPASSWORD', // ✅ Fixed typo: PASSWOD → PASSWORD
//                     style: TextStyle(
//                       color: const Color(0xFF011F54) /* Background-bg-dark */,
//                       fontSize: 58,
//                       fontFamily: 'Wosker',
//                       fontWeight: FontWeight.w400,
//                       height: 0.80,
//                     ),
//                   ),
//                 ),
//               ),

//               // SizedBox(height: 10),
//               SizedBox(
//                 width: 335,
//                 child: Text(
//                   'Choose a new password that\'s easy for you to remember - you\'ve got this!',
//                   style: GoogleFonts.workSans(
//                     color: const Color(
//                       0xFF595754,
//                     ), // Text-text-secondary-default
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     height: 1.40,
//                     letterSpacing: -0.50,
//                   ),
//                 ),
//               ),
//               // Password Field
//               SizedBox(height: 25),

//               // TextFormField(
//               //   controller: _newPasswordController,
//               //   focusNode: _passwordFocus,
//               //   obscureText: _obscurePassword,
//               //   textInputAction: TextInputAction.next,
//               //   decoration: _fieldDecoration(
//               //     label: "New Password",
//               //     hint: "Enter a new password",
//               //     labelStyle: AppsTextStyles.fullNameAndEmailSignIn,
//               //     suffixIcon: IconButton(
//               //       icon: Icon(
//               //         _obscurePassword
//               //             ? Icons.visibility_off
//               //             : Icons.visibility,
//               //         color: Colors.grey,
//               //       ),
//               //       onPressed: () {
//               //         setState(() {
//               //           _obscurePassword = !_obscurePassword;
//               //         });
//               //       },
//               //     ),
//               //   ),
//               //   onChanged: _onPasswordChanged,
//               // ),
//               TextFormField(
//                 controller: _newPasswordController, // ✅ Fixed
//                 focusNode: _passwordFocus, // ✅ Fixed
//                 obscureText: _obscurePassword,
//                 keyboardType: TextInputType.visiblePassword,
//                 textInputAction: TextInputAction.next,
//                 style: GoogleFonts.workSans(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black87,
//                 ),
//                 decoration: InputDecoration(
//                   labelText: "New Password",
//                   labelStyle: GoogleFonts.workSans(
//                     color: const Color(0xFF4C586E),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     height: 1.40,
//                     letterSpacing: -0.50,
//                   ),
//                   floatingLabelBehavior: FloatingLabelBehavior.auto,
//                   floatingLabelStyle: GoogleFonts.workSans(
//                     color: _passwordFocus.hasFocus
//                         ? const Color(0xFF4542EB)
//                         : const Color(0xFF595754),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 20,
//                   ),
//                   constraints: const BoxConstraints(minHeight: 64),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(
//                       color: Color(0xFFC3DBFF),
//                       width: 1,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(
//                       color: Color(0xFFC3DBFF),
//                       width: 1,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(
//                       color: Color(0xFF4542EB),
//                       width: 1.5,
//                     ),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(color: Colors.red, width: 1.5),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(color: Colors.red, width: 1.5),
//                   ),
//                   suffixIcon: IconButton(
//                     // ✅ Fixed: show/hide password toggle
//                     icon: Icon(
//                       _obscurePassword
//                           ? Icons.visibility_off
//                           : Icons.visibility,
//                       color: Colors.grey,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscurePassword = !_obscurePassword;
//                       });
//                     },
//                   ),
//                 ),
//                 onChanged: _onPasswordChanged, // ✅ Fixed
//               ),
//               if (!_isPasswordValid &&
//                   _newPasswordController.text.isNotEmpty) ...[
//                 const SizedBox(height: 6),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 6),
//                   child: Text(
//                     "Password must be at least 8 characters and include:\n• 1 uppercase letter (A–Z)\n• 1 lowercase letter (a–z)\n• 1 number (0–9)\n• 1 special character (– @ # \$ % ^ & * _ + = . ? /)",
//                     style: TextStyle(color: Colors.red, fontSize: 13),
//                   ),
//                 ),
//               ],
//               SizedBox(height: 15),
//               // Confirm Password Field
//               // TextFormField(
//               //   controller: _confirmPasswordController,
//               //   focusNode: _confirmPasswordFocus,
//               //   obscureText: _obscurePassword,
//               //   textInputAction: TextInputAction.done,
//               //   decoration: _fieldDecoration(
//               //     label: "Confirm Password",
//               //     hint: "Re-enter password",
//               //     labelStyle: AppsTextStyles.fullNameAndEmailSignIn,
//               //   ),
//               //   onChanged: _onConfirmPasswordChanged,
//               // ),
//               TextFormField(
//                 controller: _confirmPasswordController, // ✅ Fixed
//                 focusNode: _confirmPasswordFocus, // ✅ Fixed
//                 obscureText: _obscurePassword,
//                 keyboardType: TextInputType.visiblePassword,
//                 textInputAction: TextInputAction.done,
//                 style: GoogleFonts.workSans(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black87,
//                 ),
//                 decoration: InputDecoration(
//                   labelText: "Confirm Password",
//                   labelStyle: GoogleFonts.workSans(
//                     color: const Color(0xFF4C586E),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     height: 1.40,
//                     letterSpacing: -0.50,
//                   ),
//                   floatingLabelBehavior: FloatingLabelBehavior.auto,
//                   floatingLabelStyle: GoogleFonts.workSans(
//                     color: _confirmPasswordFocus.hasFocus
//                         ? const Color(0xFF4542EB)
//                         : const Color(0xFF595754),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 20,
//                   ),
//                   constraints: const BoxConstraints(minHeight: 64),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(
//                       color: Color(0xFFC3DBFF),
//                       width: 1,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(
//                       color: Color(0xFFC3DBFF),
//                       width: 1,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(
//                       color: Color(0xFF4542EB),
//                       width: 1.5,
//                     ),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(color: Colors.red, width: 1.5),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(color: Colors.red, width: 1.5),
//                   ),
//                   suffixIcon: _confirmPasswordController.text.isEmpty
//                       ? null
//                       : Padding(
//                           padding: const EdgeInsets.only(right: 12),
//                           child: Icon(
//                             _isConfirmPasswordValid // ✅ Fixed
//                                 ? Icons.check_circle
//                                 : Icons.cancel,
//                             size: 22,
//                             color:
//                                 _isConfirmPasswordValid // ✅ Fixed
//                                 ? Colors.green
//                                 : const Color(0xFF4542EB).withOpacity(0.5),
//                           ),
//                         ),
//                 ),
//                 onChanged: _onConfirmPasswordChanged, // ✅ Fixed
//               ),
//               if (!_isConfirmPasswordValid &&
//                   _confirmPasswordController.text.isNotEmpty) ...[
//                 const SizedBox(height: 6),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 6),
//                   child: Text(
//                     "Passwords do not match.",
//                     style: TextStyle(color: Colors.red, fontSize: 13),
//                   ),
//                 ),
//               ],
//               const SizedBox(height: 20),

//               // Continue Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 69,
//                 child: ElevatedButton(
//                   onPressed: _isButtonEnabled
//                       ? () {
//                           // Show bottom sheet with password updated popup
//                           // ...existing code...
//                           showModalBottomSheet(
//                             context: context,
//                             backgroundColor: Colors.transparent,
//                             isScrollControlled: true,
//                             builder: (context) => Padding(
//                               padding: const EdgeInsets.only(
//                                 bottom: 20,
//                               ), // gap from bottom
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: const PasswordUpdatedPopupScreen(),
//                               ),
//                             ),
//                           );
//                           // ...existing code...
//                         }
//                       : null,

//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFFF8F26),
//                     disabledBackgroundColor: const Color(0xFFFF8F26),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: Text(
//                     "Save & Continue",
//                     style: AppsTextStyles.sendResetLinkButton,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart' show Assets;
import 'package:mobile_app_dea/themes/text_styles.dart' show AppsTextStyles;
import 'package:mobile_app_dea/screen/auth/password_updated_popup_screen.dart'
    show PasswordUpdatedPopupScreen;

class EnterNewPassword extends StatefulWidget {
  const EnterNewPassword({super.key});

  @override
  State<EnterNewPassword> createState() => _EnterNewPasswordState();
}

class _EnterNewPasswordState extends State<EnterNewPassword> {
  bool _obscurePassword = true;
  bool _isButtonEnabled = false;

  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid =
        _newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _isPasswordValid &&
        _newPasswordController.text == _confirmPasswordController.text;
    if (isValid != _isButtonEnabled) {
      setState(() => _isButtonEnabled = isValid);
    }
  }

  void _onPasswordChanged(String value) {
    final valid =
        value.isNotEmpty &&
        value.length >= 8 &&
        RegExp(r'^(?=.*[A-Z])').hasMatch(value) &&
        RegExp(r'^(?=.*[a-z])').hasMatch(value) &&
        RegExp(r'^(?=.*\d)').hasMatch(value) &&
        RegExp(r'^(?=.*[!@#$%^&*()_+=[\]{};:,.<>?/\\|`~-])').hasMatch(value);

    if (valid != _isPasswordValid) {
      setState(() => _isPasswordValid = valid);
    }
    _validateForm();
  }

  void _onConfirmPasswordChanged(String value) {
    final valid = value == _newPasswordController.text;
    if (valid != _isConfirmPasswordValid) {
      setState(() => _isConfirmPasswordValid = valid);
    }
    _validateForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Top Icons Row
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Assets.svgIcons.backIconSvg.svg(
                        height: 60,
                        width: 60,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Assets.svgIcons.signInPageIcon.svg(height: 80, width: 80),
                  ],
                ),
              ),

              // ✅ Title — Padding wrapper ও SizedBox(width:335) সরানো হয়েছে
              Text(
                'ENTER  NEW  \nPASSWORD',
                style: TextStyle(
                  color: const Color(0xFF011F54),
                  fontSize: 58,
                  fontFamily: 'Wosker',
                  fontWeight: FontWeight.w500,
                  height: 0.80,
                ),
              ),

              // ✅ Subtitle — SizedBox(width:335) সরানো হয়েছে
              Text(
                'Choose a new password that\'s easy for you to remember - you\'ve got this!',
                style: GoogleFonts.workSans(
                  color: const Color(0xFF595754),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.40,
                  letterSpacing: -0.50,
                ),
              ),
              const SizedBox(height: 25),

              // ✅ New Password Field
              TextFormField(
                controller: _newPasswordController,
                focusNode: _passwordFocus,
                obscureText: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  labelText: "New Password",
                  labelStyle: GoogleFonts.workSans(
                    color: const Color(0xFF4C586E),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: -0.50,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  floatingLabelStyle: GoogleFonts.workSans(
                    color: _passwordFocus.hasFocus
                        ? const Color(0xFF4542EB)
                        : const Color(0xFF595754),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  constraints: const BoxConstraints(minHeight: 64),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFFC3DBFF),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFFC3DBFF),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFF4542EB),
                      width: 1.5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                onChanged: _onPasswordChanged,
              ),

              if (!_isPasswordValid &&
                  _newPasswordController.text.isNotEmpty) ...[
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Text(
                    "Password must be at least 8 characters and include:\n• 1 uppercase letter (A–Z)\n• 1 lowercase letter (a–z)\n• 1 number (0–9)\n• 1 special character (– @ # \$ % ^ & * _ + = . ? /)",
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ),
              ],
              const SizedBox(height: 15),

              // ✅ Confirm Password Field
              TextFormField(
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocus,
                obscureText: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  labelStyle: GoogleFonts.workSans(
                    color: const Color(0xFF4C586E),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: -0.50,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  floatingLabelStyle: GoogleFonts.workSans(
                    color: _confirmPasswordFocus.hasFocus
                        ? const Color(0xFF4542EB)
                        : const Color(0xFF595754),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  constraints: const BoxConstraints(minHeight: 64),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFFC3DBFF),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFFC3DBFF),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFF4542EB),
                      width: 1.5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                  suffixIcon: _confirmPasswordController.text.isEmpty
                      ? null
                      : Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            _isConfirmPasswordValid
                                ? Icons.check_circle
                                : Icons.cancel,
                            size: 22,
                            color: _isConfirmPasswordValid
                                ? Colors.green
                                // ignore: deprecated_member_use
                                : const Color(0xFF4542EB).withOpacity(0.5),
                          ),
                        ),
                ),
                onChanged: _onConfirmPasswordChanged,
              ),

              if (!_isConfirmPasswordValid &&
                  _confirmPasswordController.text.isNotEmpty) ...[
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Text(
                    "Passwords do not match.",
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ),
              ],
              const SizedBox(height: 20),

              // ✅ Continue Button
              SizedBox(
                width: double.infinity,
                height: 69,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled
                      ? () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: const PasswordUpdatedPopupScreen(),
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8F26),
                    disabledBackgroundColor: const Color(0xFFFF8F26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Save & Continue",
                    style: AppsTextStyles.sendResetLinkButton,
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
