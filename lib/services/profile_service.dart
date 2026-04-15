import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_constant.dart';

class ProfileData {
  final String profileImage;
  final String avatarLogo;
  final String name;

  ProfileData({
    required this.profileImage,
    required this.avatarLogo,
    required this.name,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      profileImage: json['profile_image'] ?? '',
      avatarLogo: json['avatar_logo'] ?? '',
      name: json['name'] ?? 'User',
    );
  }
}

class ProfileService {
  static String get baseUrl => '${ApiConstants.baseUrl}/api';

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? 
           'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc4MzY5OTEwLCJpYXQiOjE3NzU2OTE1MTAsImp0aSI6IjRmMWFhMjI1YTdhOTQ2ODdhN2ZmNGViMjk4YWFhYTBkIiwidXNlcl9pZCI6IjEyIn0.YYif8HWk-o0oI190vYnyUgScqR7pg_LcPjHkxcNWsR0';
  }

  Future<ProfileData?> fetchProfile() async {
    try {
      final token = await _getToken();

      final response = await http.get(
        Uri.parse('$baseUrl/profiles/'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ProfileData.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }

  Future<int> fetchStreak() async {
    try {
      final token = await _getToken();

      final response = await http.get(
        Uri.parse('$baseUrl/quests/streak/'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['streak'] ?? 0;
      }
      return 0;
    } catch (e) {
      print('Error fetching streak: $e');
      return 0;
    }
  }
}
