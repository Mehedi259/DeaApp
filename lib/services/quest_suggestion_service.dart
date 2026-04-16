import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nowlii/models/quest_suggestion_model.dart';
import 'package:nowlii/api/api_constant.dart';

class QuestSuggestionService {
  // Get quest suggestions from API
  Future<QuestSuggestionResponse?> getQuestSuggestions() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/api/v1/quests/suggestions');
      
      print('🔍 Fetching quest suggestions from: $url');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
      );

      print('📊 Quest suggestions response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('✅ Quest suggestions received: ${jsonData['weekly']['quest_suggestions'].length} suggestions');
        return QuestSuggestionResponse.fromJson(jsonData);
      } else {
        print('⚠️ Failed to fetch quest suggestions: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('❌ Error fetching quest suggestions: $e');
      return null;
    }
  }
}
