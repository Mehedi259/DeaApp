# API Integration Guide

## Overview
This directory contains all API-related code for authentication and user management.

## Files Structure

- `api_constant.dart` - API endpoints and constants
- `api_service.dart` - HTTP client wrapper for API calls
- `auth_model.dart` - Data models for authentication
- `auth_service.dart` - Authentication API service layer
- `auth_controller.dart` - GetX controller for auth state management
- `storage.dart` - Local storage for tokens and user data

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

## API Endpoints

- **POST** `/api/auth/register/` - Register new user
- **POST** `/api/auth/verify-otp/` - Verify OTP code
- **POST** `/api/auth/login/` - User login

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
authController.errorMessage.value
```

## Loading State

Check loading state:
```dart
authController.isLoading.value
```
