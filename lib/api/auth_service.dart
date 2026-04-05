import 'api_constant.dart';
import 'api_service.dart';
import 'auth_model.dart';
import 'storage.dart';

class AuthService {
  final ApiService _apiService = ApiService();
  final StorageService _storage = StorageService();

  Future<Map<String, dynamic>> register(RegisterRequest request) async {
    return await _apiService.post(
      ApiConstants.register,
      request.toJson(),
    );
  }

  Future<Map<String, dynamic>> verifyOtp(VerifyOtpRequest request) async {
    return await _apiService.post(
      ApiConstants.verifyOtp,
      request.toJson(),
    );
  }

  Future<Map<String, dynamic>> login(LoginRequest request) async {
    final result = await _apiService.post(
      ApiConstants.login,
      request.toJson(),
    );

    if (result['success'] == true) {
      final loginResponse = LoginResponse.fromJson(result['data']);
      
      await _storage.saveTokens(
        loginResponse.access,
        loginResponse.refresh,
      );
      
      await _storage.saveUserData(
        loginResponse.user.userId,
        loginResponse.user.email,
        loginResponse.user.username,
      );
    }

    return result;
  }

  Future<void> logout() async {
    await _storage.clearAll();
  }

  Future<Map<String, dynamic>> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    return await _apiService.post(
      ApiConstants.forgotPassword,
      request.toJson(),
    );
  }

  Future<Map<String, dynamic>> verifyForgotPasswordOtp(
    VerifyForgotPasswordOtpRequest request,
  ) async {
    return await _apiService.post(
      ApiConstants.verifyForgotPasswordOtp,
      request.toJson(),
    );
  }

  Future<Map<String, dynamic>> setNewPassword(
    SetNewPasswordRequest request,
  ) async {
    return await _apiService.post(
      ApiConstants.setNewPassword,
      request.toJson(),
    );
  }
}
