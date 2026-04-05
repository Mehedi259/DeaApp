import 'package:get/get.dart';
import 'auth_model.dart';
import 'auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<bool> register(String email, String username, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    final request = RegisterRequest(
      email: email,
      username: username,
      password: password,
    );

    final result = await _authService.register(request);
    isLoading.value = false;

    if (result['success'] == true) {
      return true;
    } else {
      errorMessage.value = result['message'] ?? 'Registration failed';
      return false;
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    isLoading.value = true;
    errorMessage.value = '';

    final request = VerifyOtpRequest(email: email, otp: otp);
    final result = await _authService.verifyOtp(request);
    isLoading.value = false;

    if (result['success'] == true) {
      return true;
    } else {
      errorMessage.value = result['message'] ?? 'OTP verification failed';
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    final request = LoginRequest(email: email, password: password);
    final result = await _authService.login(request);
    isLoading.value = false;

    if (result['success'] == true) {
      return true;
    } else {
      errorMessage.value = result['message'] ?? 'Login failed';
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}
