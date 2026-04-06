class ApiConstants {
  static const String baseUrl = 'http://127.0.0.1:8000';
  static const String apiPrefix = '/api/auth';
  static const String profilePrefix = '/api/profiles';
  
  // Auth endpoints
  static const String register = '$apiPrefix/register/';
  static const String verifyOtp = '$apiPrefix/verify-otp/';
  static const String login = '$apiPrefix/login/';
  static const String forgotPassword = '$apiPrefix/forgot-password/';
  static const String verifyForgotPasswordOtp = '$apiPrefix/verify-forgot-password-otp/';
  static const String setNewPassword = '$apiPrefix/set-new-password/';
  
  // Profile endpoints
  static const String createProfile = '$profilePrefix/';
  static const String getProfile = '$profilePrefix/'; // GET with auth
  static const String updateProfile = '$profilePrefix/'; // PATCH with auth
  
  // Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
}
