class ApiConstants {
  // Main Backend API URL
  static const String baseUrl = 'https://eastward-hurricane-squeezing.ngrok-free.dev';
  
  // AI Backend API URL (separate server)
  static const String aiBaseUrl = 'https://apricot-rhyme-humming.ngrok-free.dev';
  
  static const String apiPrefix = '/api/auth';
  static const String profilePrefix = '/api/profiles';
  static const String insightsPrefix = '/api';
  static const String aiCallPrefix = '/api/v1';
  static const String questsPrefix = '/api/quests';
  
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
  
  // Insights endpoints
  static const String getInsights = '$insightsPrefix/insights/';
  
  // Quests endpoints
  static const String getStreak = '$questsPrefix/streak/';
  
  // AI Call endpoints (use aiBaseUrl)
  static const String createSession = '$aiCallPrefix/session/new';
  static const String chatStream = '$aiCallPrefix/chat-stream';
  
  // Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
}
