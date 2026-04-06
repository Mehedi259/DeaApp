# API Integration Guide

## Overview
This directory contains all API-related code for authentication, user management, and profile management.

## Files Structure

- `api_constant.dart` - API endpoints and constants
- `api_service.dart` - HTTP client wrapper for API calls
- `auth_model.dart` - Data models for authentication
- `auth_service.dart` - Authentication API service layer
- `auth_controller.dart` - GetX controller for auth state management
- `profile_model.dart` - Data models for user profile
- `profile_service.dart` - Profile API service layer
- `profile_controller.dart` - Controller for profile state management
- `storage.dart` - Local storage for tokens, user data, and profile data

## Usage

### Sign Up Flow
```dart
final authController = Get.put(AuthController());

// 1. Register user
final success = await authController.register(
  email: 'user@example.com',
  username: 'username',
  password: 'password123',
);

// 2. Verify OTP
if (success) {
  final verified = await authController.verifyOtp(
    email: 'user@example.com',
    otp: '123456',
  );
}
```

### Sign In Flow
```dart
final authController = Get.put(AuthController());

final success = await authController.login(
  email: 'user@example.com',
  password: 'password123',
);
```

### Logout
```dart
await authController.logout();
```

### Forgot Password Flow
```dart
final authController = Get.put(AuthController());

// 1. Request password reset
final success = await authController.forgotPassword(
  email: 'user@example.com',
);

// 2. Verify OTP
if (success) {
  final verified = await authController.verifyForgotPasswordOtp(
    email: 'user@example.com',
    otp: '123456',
  );
  
  // 3. Set new password
  if (verified) {
    final reset = await authController.setNewPassword(
      email: 'user@example.com',
      newPassword: 'newPassword123',
      confirmPassword: 'newPassword123',
    );
  }
}
```

### Profile Management

#### Create Profile
```dart
final profileController = ProfileController();

final success = await profileController.createProfile(
  name: 'Mehedi',
  gender: "I'm a man",
  profileImage: 'https://example.com/image.jpg',
  avatarLogo: 'https://example.com/avatar.jpg',
  customNowliiName: 'fahad1',
  language: 'English',
  voice: 'Male',
);

if (success) {
  print('Profile created: ${profileController.profile?.name}');
} else {
  print('Error: ${profileController.errorMessage}');
}
```

#### Get Profile
```dart
final profileController = ProfileController();

final success = await profileController.fetchProfile();

if (success) {
  final profile = profileController.profile;
  print('Name: ${profile?.name}');
  print('Gender: ${profile?.gender}');
  print('Language: ${profile?.language}');
}
```

#### Update Profile
```dart
final profileController = ProfileController();

final success = await profileController.updateProfile(
  name: 'Updated Name',
  language: 'Bengali',
  // Only pass fields you want to update
);

if (success) {
  print('Profile updated successfully');
}
```

#### Load Cached Profile
```dart
final profileController = ProfileController();

// Load profile from local storage (offline access)
await profileController.loadCachedProfile();

if (profileController.profile != null) {
  print('Cached profile: ${profileController.profile?.name}');
}
```

## API Endpoints

### Authentication
- **POST** `/api/auth/register/` - Register new user
- **POST** `/api/auth/verify-otp/` - Verify OTP code
- **POST** `/api/auth/login/` - User login
- **POST** `/api/auth/forgot-password/` - Request password reset
- **POST** `/api/auth/verify-forgot-password-otp/` - Verify forgot password OTP
- **POST** `/api/auth/set-new-password/` - Set new password

### Profile
- **POST** `/api/profiles/` - Create user profile (requires auth token)
- **GET** `/api/profiles/` - Get user profile (requires auth token)
- **PATCH** `/api/profiles/` - Update user profile (requires auth token)

## Configuration

Update the base URL in `api_constant.dart`:
```dart
static const String baseUrl = 'http://127.0.0.1:8000';
```

For production, change to your production API URL.

## Error Handling

All API calls return a Map with:
- `success`: boolean indicating success/failure
- `message`: error message if failed
- `data`: response data if successful

Access errors via:
```dart
// Auth
authController.errorMessage.value

// Profile
profileController.errorMessage
```

## Loading State

Check loading state:
```dart
// Auth
authController.isLoading.value

// Profile
profileController.isLoading
```

## Profile Model

```dart
class ProfileModel {
  final int? id;
  final String name;
  final String gender;
  final String? profileImage;
  final String? avatarLogo;
  final String? nowliiName;
  final String? customNowliiName;
  final String language;
  final String voice;
}
```

### Gender Options
- "I'm a man"
- "I'm a woman"
- "I'm non-binary"
- "Prefer not to say"

### Language Options
- "English"
- "Bengali"
- "Spanish"
- etc.

### Voice Options
- "Male"
- "Female"

## Example: Complete Onboarding Flow

```dart
// 1. Register
await authController.register(...);

// 2. Verify OTP
await authController.verifyOtp(...);

// 3. Login (if needed)
await authController.login(...);

// 4. Create Profile
final profileController = ProfileController();
await profileController.createProfile(
  name: userName,
  gender: selectedGender,
  language: selectedLanguage,
  voice: selectedVoice,
);

// 5. Navigate to home
if (profileController.profile != null) {
  context.go('/homeScreen');
}
```
