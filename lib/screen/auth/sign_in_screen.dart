/*
import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart' show Assets;
import 'package:mobile_app_dea/screen/auth/sign_in_controller.dart';
import 'package:mobile_app_dea/themes/text_styles.dart' show AppsTextStyles;

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());

    InputDecoration fieldDecoration({
      required String label,
      required String hint,
      Widget? suffixIcon,
      required TextStyle labelStyle,
    }) {
      const borderSide = BorderSide(color: Color(0xFFC3DBFF), width: 1);
      final borderRadius = BorderRadius.circular(16);

      final fixedBorder = OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
        gapPadding: 8,
      );

      return InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelStyle: labelStyle,
        labelStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 24,
        ),
        enabledBorder: fixedBorder,
        focusedBorder: fixedBorder,
        errorBorder: fixedBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: fixedBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        suffixIcon: suffixIcon,
      );
    }

    Widget socialButton({required String icon, required String text}) {
      return SizedBox(
        width: double.infinity,
        height: 64,
        child: OutlinedButton.icon(
          icon: SvgPicture.asset(icon, height: 20, width: 20),
          label: Text(text, style: AppsTextStyles.workSansSemiBold16signIn),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF011F54), width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {},
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Icons Row
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Assets.svgIcons.backIconSvg.svg(
                      height: 80,
                      width: 80,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Assets.svgIcons.signInPageIcon.svg(height: 80, width: 80),
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                    color: Color(0xFF011F54),
                    fontSize: 54, // ✅ Fixed: replaced 68.sp with a static value
                    fontFamily: 'Wosker',
                    fontWeight: FontWeight.w400,
                    height: 0.80,
                  ),
                ),
              ),
              const SizedBox(height: 5),

              // 📧 Email Field
              Obx(() {
                final isValid = controller.isEmailValid.value;
                // ✅ Fix: also read text length reactively via controller listener
                final hasText = controller.emailController.text.isNotEmpty;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 59,
                      child: TextFormField(
                        controller: controller.emailController,
                        focusNode: controller.emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(
                          context,
                        ).requestFocus(controller.passwordFocus),
                        decoration: fieldDecoration(
                          label: "Email address",
                          hint: "",
                          labelStyle: AppsTextStyles.fullNameAndEmailSignIn,
                          suffixIcon: !hasText
                              ? null
                              : IconButton(
                                  // ✅ Fix: removed double Padding wrapper
                                  icon: Icon(
                                    isValid
                                        ? Icons.check_circle
                                        : Icons.warning_amber_rounded,
                                    size: 20,
                                    color: isValid ? Colors.green : Colors.red,
                                  ),
                                  onPressed: () =>
                                      controller.emailController.clear(),
                                ),
                        ),
                      ),
                    ),
                    // ✅ Fix: error text moved inside Obx column (no separate Obx needed)
                    if (!isValid && hasText) ...[
                      const SizedBox(height: 6),
                      const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Text(
                          "Please enter a valid email address.",
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ),
                    ],
                  ],
                );
              }),

              const SizedBox(height: 10),

              // 🔒 Password Field
              Obx(
                () => SizedBox(
                  height: 59,
                  child: TextFormField(
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocus,
                    obscureText: controller.obscurePassword.value,
                    textInputAction: TextInputAction.done,
                    decoration: fieldDecoration(
                      label: "Password",
                      hint: "*****",
                      labelStyle: AppsTextStyles.fullNameAndEmailSignIn,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Forgot Password Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    Flexible(
                      child: RichText(
                        overflow: TextOverflow.visible,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "It happens! ",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: GestureDetector(
                                onTap: () {
                                  context.push("/resentPasswordPage");
                                },
                                child: const Text(
                                  "Reset it here.",
                                  style: TextStyle(
                                    color: Color(0xFF0A214D),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    context.push("/onboardingFlow");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8F26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: AppsTextStyles.signInContinueButton,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Divider with "or"
              // ✅ Fix: removed erroneous `const` on Row with non-const children
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 2, color: Colors.black26)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("or", style: TextStyle(color: Colors.black54)),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.black26)),
                ],
              ),
              const SizedBox(height: 25),

              // Social Buttons
              socialButton(
                icon: Assets.svgIcons.signInGoole.path,
                text: "Continue with Google",
              ),
              const SizedBox(height: 15),
              socialButton(
                icon: Assets.svgIcons.appleIconSignIn.path,
                text: "Continue with Apple",
              ),

              const SizedBox(height: 90),

              // Sign Up Link
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? → ",
                    style: AppsTextStyles.workSansSemiBold16,
                    children: [
                      TextSpan(
                        text: "Sign up",
                        style: AppsTextStyles.workSansSemiBold16SignInAlread,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push("/signUpScreen");
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart' show Assets;
import 'package:mobile_app_dea/screen/auth/sign_in_controller.dart';
import 'package:mobile_app_dea/themes/text_styles.dart' show AppsTextStyles;

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());

    InputDecoration fieldDecoration({
      required String label,
      required String hint,
      Widget? suffixIcon,
      required TextStyle labelStyle,
    }) {
      const borderSide = BorderSide(color: Color(0xFFC3DBFF), width: 1);
      final borderRadius = BorderRadius.circular(16);

      final fixedBorder = OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
        gapPadding: 8,
      );

      return InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelStyle: labelStyle,
        labelStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Color(0xFFFFFEF8),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 24,
        ),
        enabledBorder: fixedBorder,
        focusedBorder: fixedBorder,
        errorBorder: fixedBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: fixedBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        suffixIcon: suffixIcon,
      );
    }

    Widget socialButton({required String icon, required String text}) {
      return SizedBox(
        width: double.infinity,
        height: 64,
        child: OutlinedButton.icon(
          icon: SvgPicture.asset(icon, height: 24, width: 24),
          label: Text(text, style: AppsTextStyles.workSansSemiBold16signIn),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF011F54), width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {},
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Icons Row
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Assets.svgIcons.backIconSvg.svg(
                      height: 80,
                      width: 80,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Assets.svgIcons.signInPageIcon.svg(height: 80, width: 80),
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                    color: Color(0xFF011F54),
                    fontSize: 86,
                    fontFamily: 'Wosker',
                    fontWeight: FontWeight.w400,
                    height: 0.80,
                  ),
                ),
              ),
              const SizedBox(height: 5),

              // 📧 Email Field
              Obx(() {
                final isValid = controller.isEmailValid.value;
                final hasText = controller.emailController.text.isNotEmpty;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 59,
                      child: TextFormField(
                        controller: controller.emailController,
                        focusNode: controller.emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(
                          context,
                        ).requestFocus(controller.passwordFocus),
                        decoration: fieldDecoration(
                          label: "Email address",
                          hint: "",
                          labelStyle: AppsTextStyles.fullNameAndEmailSignIn,
                          suffixIcon: !hasText
                              ? null
                              : IconButton(
                                  icon: Icon(
                                    isValid
                                        ? Icons.check_circle
                                        : Icons.warning_amber_rounded,
                                    size: 20,
                                    color: isValid ? Colors.green : Colors.red,
                                  ),
                                  onPressed: () =>
                                      controller.emailController.clear(),
                                ),
                        ),
                      ),
                    ),
                    if (!isValid && hasText) ...[
                      const SizedBox(height: 6),
                      const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Text(
                          "Please enter a valid email address.",
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ),
                    ],
                  ],
                );
              }),

              const SizedBox(height: 10),

              // 🔒 Password Field
              Obx(
                () => SizedBox(
                  height: 59,
                  child: TextFormField(
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocus,
                    obscureText: controller.obscurePassword.value,
                    textInputAction: TextInputAction.done,
                    decoration: fieldDecoration(
                      label: "Password",
                      hint: "*****",
                      labelStyle: AppsTextStyles.fullNameAndEmailSignIn,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // ✅ Forgot Password Row — Fixed
              // ✅ Forgot Password Row — Overflow Fixed
              _buildForgotPasswordRow(context),

              const SizedBox(height: 20),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    context.push("/onboardingFlow");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8F26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: AppsTextStyles.signInContinueButton,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Divider with "or"
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1, color: Colors.black26)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("or", style: TextStyle(color: Colors.black54)),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.black26)),
                ],
              ),
              const SizedBox(height: 25),

              // Social Buttons
              socialButton(
                icon: Assets.svgIcons.signInGoole.path,
                text: "Continue with Google",
              ),
              const SizedBox(height: 15),
              socialButton(
                icon: Assets.svgIcons.appleIconSignIn.path,
                text: "Continue with Apple",
              ),

              const SizedBox(height: 90),

              // Sign Up Link
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? → ",
                    style: AppsTextStyles.workSansSemiBold16,
                    children: [
                      TextSpan(
                        text: "Sign up",
                        style: AppsTextStyles.workSansSemiBold16SignInAlread,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push("/signUpScreen");
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordRow(BuildContext context) {
    // ✅ BuildContext parameter
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Forgot password?',
          style: GoogleFonts.workSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF595754),
            letterSpacing: -0.50,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'It happens! ',
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF595754),
                  letterSpacing: -0.50,
                ),
              ),
              TextSpan(
                text: 'Reset it here.',
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF011F54),
                  letterSpacing: -0.50,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF011F54),
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.push("/resentPasswordPage"); // ✅ এখন কাজ করবে
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
