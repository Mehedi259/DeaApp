import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Subtask {
  final int id;
  final String title;
  final bool taskDone;

  Subtask({
    required this.id,
    required this.title,
    required this.taskDone,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) {
    return Subtask(
      id: json['id'],
      title: json['title'],
      taskDone: json['task_done'],
    );
  }
}

class Quest {
  final int id;
  final List<Subtask> subtasks;
  final String task;
  final String zone;
  final String selectADate;
  final bool enableCall;
  final bool repeatQuest;
  final bool setAlarm;
  bool taskDone;

  Quest({
    required this.id,
    required this.subtasks,
    required this.task,
    required this.zone,
    required this.selectADate,
    required this.enableCall,
    required this.repeatQuest,
    required this.setAlarm,
    required this.taskDone,
  });

  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      id: json['id'],
      subtasks: (json['subtasks'] as List)
          .map((subtask) => Subtask.fromJson(subtask))
          .toList(),
      task: json['task'],
      zone: json['zone'],
      selectADate: json['select_a_date'],
      enableCall: json['enable_call'],
      repeatQuest: json['repeat_quest'],
      setAlarm: json['set_alarm'],
      taskDone: json['task_done'],
    );
  }
}

class QuestService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? 
           'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc4MzY5OTEwLCJpYXQiOjE3NzU2OTE1MTAsImp0aSI6IjRmMWFhMjI1YTdhOTQ2ODdhN2ZmNGViMjk4YWFhYTBkIiwidXNlcl9pZCI6IjEyIn0.YYif8HWk-o0oI190vYnyUgScqR7pg_LcPjHkxcNWsR0';
  }

  Future<List<Quest>> fetchQuestsByDate(DateTime date) async {
    try {
      final token = await _getToken();
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);

      final response = await http.get(
        Uri.parse('$baseUrl/quests/?due_date=$formattedDate'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((quest) => Quest.fromJson(quest)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching quests: $e');
      return [];
    }
  }

  Future<List<Quest>> fetchTodayQuests() async {
    return fetchQuestsByDate(DateTime.now());
  }

  Future<bool> updateQuestStatus(int questId, bool taskDone) async {
    try {
      final token = await _getToken();

      final response = await http.patch(
        Uri.parse('$baseUrl/quests/$questId/'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'task_done': taskDone}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error updating quest status: $e');
      return false;
    }
  }

  Future<bool> deleteQuest(int questId) async {
    try {
      final token = await _getToken();

      final response = await http.delete(
        Uri.parse('$baseUrl/quests/$questId/'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return response.statusCode == 204 || response.statusCode == 200;
    } catch (e) {
      print('Error deleting quest: $e');
      return false;
    }
  }
}
