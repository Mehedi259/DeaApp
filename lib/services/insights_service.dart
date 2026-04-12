import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app_dea/api/api_constant.dart';

class ZoneProgress {
  final String zone;
  final int assigned;
  final int completed;
  final String ratio;

  ZoneProgress({
    required this.zone,
    required this.assigned,
    required this.completed,
    required this.ratio,
  });

  factory ZoneProgress.fromJson(Map<String, dynamic> json) {
    return ZoneProgress(
      zone: json['zone'],
      assigned: json['assigned'],
      completed: json['completed'],
      ratio: json['ratio'],
    );
  }
}

class WeeklyInsights {
  final int questsCompleted;
  final int totalQuests;
  final List<String> aiReflections;
  final List<ZoneProgress> zoneProgress;
  final List<String> skippedDays;

  WeeklyInsights({
    required this.questsCompleted,
    required this.totalQuests,
    required this.aiReflections,
    required this.zoneProgress,
    required this.skippedDays,
  });

  factory WeeklyInsights.fromJson(Map<String, dynamic> json) {
    return WeeklyInsights(
      questsCompleted: json['quests_completed'],
      totalQuests: json['total_quests'],
      aiReflections: List<String>.from(json['ai_reflections']),
      zoneProgress: (json['zone_progress'] as List)
          .map((z) => ZoneProgress.fromJson(z))
          .toList(),
      skippedDays: List<String>.from(json['skipped_days']),
    );
  }
}

class CompletedQuest {
  final String task;
  final int completedCount;
  final bool repeatQuest;

  CompletedQuest({
    required this.task,
    required this.completedCount,
    required this.repeatQuest,
  });

  factory CompletedQuest.fromJson(Map<String, dynamic> json) {
    return CompletedQuest(
      task: json['task'],
      completedCount: json['completed_count'],
      repeatQuest: json['repeat_quest'],
    );
  }
}

class PreferredQuestTypes {
  final double softStepsPct;
  final double powerMovesPct;
  final String summary;

  PreferredQuestTypes({
    required this.softStepsPct,
    required this.powerMovesPct,
    required this.summary,
  });

  factory PreferredQuestTypes.fromJson(Map<String, dynamic> json) {
    return PreferredQuestTypes(
      softStepsPct: (json['soft_steps_pct'] as num).toDouble(),
      powerMovesPct: (json['power_moves_pct'] as num).toDouble(),
      summary: json['summary'],
    );
  }
}

class QuestsCompleted {
  final int assigned;
  final int completed;

  QuestsCompleted({
    required this.assigned,
    required this.completed,
  });

  factory QuestsCompleted.fromJson(Map<String, dynamic> json) {
    return QuestsCompleted(
      assigned: json['assigned'],
      completed: json['completed'],
    );
  }
}

class CalendarDay {
  final String date;
  final String status;

  CalendarDay({
    required this.date,
    required this.status,
  });

  factory CalendarDay.fromJson(Map<String, dynamic> json) {
    return CalendarDay(
      date: json['date'],
      status: json['status'],
    );
  }
}

class Milestones {
  final int questsCompletedThisMonth;
  final int longestStreakDays;

  Milestones({
    required this.questsCompletedThisMonth,
    required this.longestStreakDays,
  });

  factory Milestones.fromJson(Map<String, dynamic> json) {
    return Milestones(
      questsCompletedThisMonth: json['quests_completed_this_month'],
      longestStreakDays: json['longest_streak_days'],
    );
  }
}

class MonthlyInsights {
  final List<CompletedQuest> mostCompletedQuests;
  final String mostProductiveDay;
  final PreferredQuestTypes preferredQuestTypes;
  final QuestsCompleted questsCompleted;
  final List<CalendarDay> calendar;
  final Milestones milestones;

  MonthlyInsights({
    required this.mostCompletedQuests,
    required this.mostProductiveDay,
    required this.preferredQuestTypes,
    required this.questsCompleted,
    required this.calendar,
    required this.milestones,
  });

  factory MonthlyInsights.fromJson(Map<String, dynamic> json) {
    return MonthlyInsights(
      mostCompletedQuests: (json['most_completed_quests'] as List)
          .map((q) => CompletedQuest.fromJson(q))
          .toList(),
      mostProductiveDay: json['most_productive_day'],
      preferredQuestTypes:
          PreferredQuestTypes.fromJson(json['preferred_quest_types']),
      questsCompleted: QuestsCompleted.fromJson(json['quests_completed']),
      calendar: (json['calendar'] as List)
          .map((c) => CalendarDay.fromJson(c))
          .toList(),
      milestones: Milestones.fromJson(json['milestones']),
    );
  }
}

class InsightsData {
  final WeeklyInsights weekly;
  final MonthlyInsights monthly;

  InsightsData({
    required this.weekly,
    required this.monthly,
  });

  factory InsightsData.fromJson(Map<String, dynamic> json) {
    return InsightsData(
      weekly: WeeklyInsights.fromJson(json['weekly']),
      monthly: MonthlyInsights.fromJson(json['monthly']),
    );
  }
}

class InsightsService {
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ??
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc4NjI0NDA4LCJpYXQiOjE3NzU5NDYwMDgsImp0aSI6IjFmOTRjM2M3MWM3NDQ0MTVhYTljZjViOWI5MWMyZDc0IiwidXNlcl9pZCI6IjEifQ.5iKEJQ2a5zYEOZ-Qus-q4BUktCbpi1Dk3gOpc9GQHoI';
  }

  Future<InsightsData?> fetchInsights() async {
    try {
      final token = await _getToken();

      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getInsights}'),
        headers: {
          'accept': ApiConstants.accept,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return InsightsData.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Error fetching insights: $e');
      return null;
    }
  }
}
