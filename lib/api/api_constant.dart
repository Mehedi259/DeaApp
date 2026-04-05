class ApiConstants {
  static const String baseUrl = 'http://127.0.0.1:8000';
  static const String apiPrefix = '/api/auth';
  
  // Auth endpoints
  static const String register = '$apiPrefix/register/';
  static const String verifyOtp = '$apiPrefix/verify-otp/';
  static const String login = '$apiPrefix/login/';
  
  // Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
}
