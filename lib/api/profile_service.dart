import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app_dea/api/api_constant.dart';
import 'package:mobile_app_dea/api/profile_model.dart';
import 'package:mobile_app_dea/api/storage.dart';

class ProfileService {
  // Create Profile (POST)
  static Future<Map<String, dynamic>> createProfile(
    CreateProfileRequest request,
  ) async {
    try {
      print('\n========== CREATE PROFILE API CALL ==========');
      
      // Get access token
      final token = await SecureStorage.getAccessToken();
      print('📱 Access Token: ${token ?? "NOT FOUND"}');
      
      if (token == null) {
        print('❌ ERROR: No access token found');
        return {
          'success': false,
          'message': 'No access token found. Please login again.',
        };
      }

      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.createProfile}');
      print('🌐 URL: $url');
      print('📤 Request Body: ${jsonEncode(request.toJson())}');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.accept,
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Profile created successfully
        final profile = ProfileModel.fromJson(responseData);
        
        // Save profile data to local storage
        await SecureStorage.saveProfileData(profile);
        
        print('✅ Profile created successfully!');
        print('👤 Profile Data: ${profile.toJson()}');
        print('=============================================\n');
        
        return {
          'success': true,
          'message': 'Profile created successfully',
          'profile': profile,
        };
      } else {
        print('❌ Profile creation failed');
        print('Error Details: $responseData');
        print('=============================================\n');
        
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to create profile',
          'errors': responseData,
        };
      }
    } catch (e) {
      print('❌ EXCEPTION: ${e.toString()}');
      print('=============================================\n');
      
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // Get Profile (GET)
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      print('\n========== GET PROFILE API CALL ==========');
      
      // Get access token
      final token = await SecureStorage.getAccessToken();
      print('📱 Access Token: ${token ?? "NOT FOUND"}');
      
      if (token == null) {
        print('❌ ERROR: No access token found');
        return {
          'success': false,
          'message': 'No access token found. Please login again.',
        };
      }

      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getProfile}');
      print('🌐 URL: $url');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.accept,
          'Authorization': 'Bearer $token',
        },
      );

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Profile fetched successfully
        final profile = ProfileModel.fromJson(responseData);
        
        // Save profile data to local storage
        await SecureStorage.saveProfileData(profile);
        
        print('✅ Profile fetched successfully!');
        print('👤 Profile Data: ${profile.toJson()}');
        print('==========================================\n');
        
        return {
          'success': true,
          'message': 'Profile fetched successfully',
          'profile': profile,
        };
      } else {
        print('❌ Profile fetch failed');
        print('Error Details: $responseData');
        print('==========================================\n');
        
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to fetch profile',
          'errors': responseData,
        };
      }
    } catch (e) {
      print('❌ EXCEPTION: ${e.toString()}');
      print('==========================================\n');
      
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // Update Profile (PATCH)
  static Future<Map<String, dynamic>> updateProfile(
    UpdateProfileRequest request,
  ) async {
    try {
      print('\n========== UPDATE PROFILE API CALL ==========');
      
      // Get access token
      final token = await SecureStorage.getAccessToken();
      print('📱 Access Token: ${token ?? "NOT FOUND"}');
      
      if (token == null) {
        print('❌ ERROR: No access token found');
        return {
          'success': false,
          'message': 'No access token found. Please login again.',
        };
      }

      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateProfile}');
      print('🌐 URL: $url');
      print('📤 Request Body: ${jsonEncode(request.toJson())}');
      
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.accept,
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Profile updated successfully
        final profile = ProfileModel.fromJson(responseData);
        
        // Update profile data in local storage
        await SecureStorage.saveProfileData(profile);
        
        print('✅ Profile updated successfully!');
        print('👤 Profile Data: ${profile.toJson()}');
        print('=============================================\n');
        
        return {
          'success': true,
          'message': 'Profile updated successfully',
          'profile': profile,
        };
      } else {
        print('❌ Profile update failed');
        print('Error Details: $responseData');
        print('=============================================\n');
        
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to update profile',
          'errors': responseData,
        };
      }
    } catch (e) {
      print('❌ EXCEPTION: ${e.toString()}');
      print('=============================================\n');
      
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // Get cached profile from local storage
  static Future<ProfileModel?> getCachedProfile() async {
    return await SecureStorage.getProfileData();
  }

  // Clear profile data from local storage
  static Future<void> clearProfile() async {
    await SecureStorage.clearProfileData();
  }
}
