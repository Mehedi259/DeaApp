# Insights API Integration

## Overview
এই ডকুমেন্টে Insights স্ক্রিনে API ইন্টিগ্রেশন সম্পর্কে বিস্তারিত তথ্য দেওয়া হয়েছে।

## API Endpoint
```
GET https://partnerless-rochel-however.ngrok-free.dev/api/insights/
```

## Service File
**Location:** `lib/services/insights_service.dart`

এই ফাইলে নিম্নলিখিত ক্লাস এবং মডেল রয়েছে:
- `InsightsService` - API কল করার জন্য মূল সার্ভিস ক্লাস
- `InsightsData` - মূল ডেটা মডেল
- `WeeklyInsights` - সাপ্তাহিক ইনসাইট ডেটা
- `MonthlyInsights` - মাসিক ইনসাইট ডেটা
- `CompletedQuest`, `PreferredQuestTypes`, `CalendarDay`, `Milestones` - অন্যান্য মডেল

## Changes Made in insights.dart

### 1. Import Statement
```dart
import 'package:mobile_app_dea/services/insights_service.dart';
```

### 2. State Variables
```dart
final InsightsService _insightsService = InsightsService();
InsightsData? _insightsData;
bool _isLoading = true;
```

### 3. initState Method
```dart
@override
void initState() {
  super.initState();
  _loadInsights();
}

Future<void> _loadInsights() async {
  setState(() => _isLoading = true);
  final data = await _insightsService.fetchInsights();
  setState(() {
    _insightsData = data;
    _isLoading = false;
  });
}
```

### 4. Updated Methods

#### _buildAIInsights()
- `mostCompletedQuests` থেকে ডেটা দেখায়
- `mostProductiveDay` দেখায়
- `preferredQuestTypes` এর percentage এবং summary দেখায়

#### _buildWeeklyReflection()
- `weekly.questsCompleted` এবং `weekly.totalQuests` দেখায়
- `weekly.aiReflections` লিস্ট থেকে AI reflections দেখায়
- Progress bar এর জন্য completion rate calculate করে

#### _buildMilestonesAndAchievements()
- `milestones.questsCompletedThisMonth` দেখায়
- `milestones.longestStreakDays` দেখায়

## API Response Structure
```json
{
  "weekly": {
    "quests_completed": 0,
    "total_quests": 7,
    "ai_reflections": ["reflection 1", "reflection 2"],
    "zone_progress": [...],
    "skipped_days": [...]
  },
  "monthly": {
    "most_completed_quests": [...],
    "most_productive_day": "Wednesday",
    "preferred_quest_types": {
      "soft_steps_pct": 44.4,
      "power_moves_pct": 55.6,
      "summary": "..."
    },
    "quests_completed": {
      "assigned": 34,
      "completed": 1
    },
    "calendar": [...],
    "milestones": {
      "quests_completed_this_month": 1,
      "longest_streak_days": 1
    }
  }
}
```

## Testing
1. API endpoint টি সঠিকভাবে কাজ করছে কিনা চেক করুন
2. Token সঠিকভাবে পাস হচ্ছে কিনা verify করুন
3. Loading state এবং error handling চেক করুন

## Next Steps
- Monthly Overview এর calendar view API ডেটা দিয়ে আপডেট করতে হবে
- Recent Sessions API থেকে ডেটা fetch করতে হবে (যদি endpoint থাকে)
- Error handling improve করতে হবে
- Refresh functionality যোগ করতে হবে
