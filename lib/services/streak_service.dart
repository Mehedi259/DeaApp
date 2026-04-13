import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app_dea/api/api_constant.dart';
import 'package:mobile_app_dea/models/streak_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakService {
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<StreakResponse?> getStreak() async {
    try {
      final token = await _getAuthToken();
      if (token == null) {
        print('⚠️ No auth token found');
        return null;
      }

      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getStreak}');
      
      print('🔥 Fetching streak from: $url');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.accept,
          'Authorization': 'Bearer $token',
        },
      );

      print('📡 Streak response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Streak data received: ${data['streak']}');
        return StreakResponse.fromJson(data);
      } else {
        print('❌ Failed to fetch streak: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('❌ Error fetching streak: $e');
      return null;
    }
  }
}
