import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nowlii/api/api_constant.dart';
import 'package:nowlii/models/insights_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsightsService {
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<InsightsResponse?> getInsights() async {
    try {
      final token = await _getAuthToken();
      if (token == null) {
        print('⚠️ No auth token found');
        return null;
      }

      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getInsights}');
      
      print('📊 Fetching insights from: $url');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.accept,
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
        },
      );

      print('📡 Insights response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Insights data received');
        return InsightsResponse.fromJson(data);
      } else {
        print('❌ Failed to fetch insights: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('❌ Error fetching insights: $e');
      return null;
    }
  }
}
