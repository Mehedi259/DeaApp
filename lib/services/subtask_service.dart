import 'dart:convert';
import 'package:http/http.dart' as http;

class SubtaskService {
  static const String baseUrl = 'http://16.170.191.239:8000/api';
  static const String authToken = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzgxMjA5MzEzLCJpYXQiOjE3Nzg1MzA5MTMsImp0aSI6ImVhODZhYjRjOTNkNTQ3Mzk5MjY0MDIwMGNmOWFjOWI5IiwidXNlcl9pZCI6IjQifQ.kiUF53Gi8VmPCT3li5Q-hCNU-qNDOIJJZQDNpJLLjko';

  /// Generate subtasks based on quest category/title
  /// 
  /// [category] - The quest title/category to generate subtasks for
  /// 
  /// Returns a list of generated subtask strings, or null if failed
  Future<List<String>?> generateSubtasks(String category) async {
    try {
      final url = Uri.parse('$baseUrl/subtasks/generate/');
      
      final response = await http.post(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': authToken,
          'Content-Type': 'application/json',
          'X-CSRFTOKEN': '1Fxw6IbR2hllTnDXOguKMXU3VL6P0Qc6',
        },
        body: jsonEncode({
          'category': category,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Extract tasks array from response
        if (data['tasks'] != null && data['tasks'] is List) {
          return List<String>.from(data['tasks']);
        }
        
        return null;
      } else {
        // Failed to generate subtasks
        return null;
      }
    } catch (e) {
      // Error generating subtasks
      return null;
    }
  }
}
