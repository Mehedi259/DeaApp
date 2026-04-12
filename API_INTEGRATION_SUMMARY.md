# Insights API Integration - সারাংশ

## সম্পন্ন কাজ

### ১. API Constants আপডেট
**ফাইল:** `lib/api/api_constant.dart`

- Base URL আপডেট করা হয়েছে: `http://127.0.0.1:8000`
- Insights endpoint যোগ করা হয়েছে: `getInsights = '/api/insights/'`
- এখন সব API একই centralized configuration ব্যবহার করে

### ২. Service File তৈরি
**ফাইল:** `lib/services/insights_service.dart`

এই ফাইলে তৈরি করা হয়েছে:
- `InsightsService` ক্লাস - API call করার জন্য (এখন `ApiConstants` ব্যবহার করে)
- সব প্রয়োজনীয় data model classes:
  - `InsightsData` - মূল ডেটা
  - `WeeklyInsights` - সাপ্তাহিক ডেটা
  - `MonthlyInsights` - মাসিক ডেটা
  - `CompletedQuest`, `PreferredQuestTypes`, `CalendarDay`, `Milestones` ইত্যাদি

### ২. Insights Screen আপডেট
**ফাইল:** `lib/screen/progress/insights/insights.dart`

#### যোগ করা হয়েছে:
- `InsightsService` import
- State variables: `_insightsService`, `_insightsData`, `_isLoading`
- `initState()` এবং `_loadInsights()` method
- Loading এবং error state handling

#### আপডেট করা methods:

**_buildAIInsights():**
- Most completed quests - API থেকে ডেটা দেখায়
- Most productive day - API থেকে দিন দেখায়
- Preferred quest types - API থেকে percentage এবং summary দেখায়

**_buildWeeklyReflection():**
- Quests completed count - API থেকে `${weekly.questsCompleted}/${weekly.totalQuests}`
- Progress bar - dynamic completion rate
- AI reflections - API থেকে সব reflections দেখায়

**_buildMilestonesAndAchievements():**
- Quest completed this month - API থেকে count
- Longest streak days - API থেকে days count

**_buildCalendarGrid():**
- Calendar statuses - API থেকে ডেটা ব্যবহার করে

## API Configuration
**Base URL:** `http://127.0.0.1:8000` (configured in `lib/api/api_constant.dart`)

**Endpoint:** `GET /api/insights/`

**Full URL:** `${ApiConstants.baseUrl}${ApiConstants.getInsights}`

**Headers:**
```dart
{
  'accept': 'application/json',
  'Authorization': 'Bearer {token}'
}
```

## Response Structure
```json
{
  "weekly": {
    "quests_completed": 0,
    "total_quests": 7,
    "ai_reflections": [...],
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
    "quests_completed": {...},
    "calendar": [...],
    "milestones": {
      "quests_completed_this_month": 1,
      "longest_streak_days": 1
    }
  }
}
```

## Features
✅ Loading state দেখায়
✅ Error handling আছে
✅ Retry button আছে
✅ Dynamic data rendering
✅ No syntax errors
✅ All diagnostics passed

## পরবর্তী ধাপ
1. Token management improve করা
2. Pull-to-refresh functionality যোগ করা
3. Caching implement করা
4. Recent Sessions API integration (যদি endpoint থাকে)
5. Monthly Overview calendar এর জন্য আরো বিস্তারিত ডেটা

## Important Notes
⚠️ **Base URL Management:**
- সব API endpoints এখন `lib/api/api_constant.dart` থেকে manage হয়
- Base URL পরিবর্তন করতে শুধু `ApiConstants.baseUrl` আপডেট করুন
- Development এবং Production এর জন্য আলাদা configuration সহজেই করা যাবে

## Testing
এখন আপনি app run করে দেখতে পারবেন:
```bash
flutter run
```

Progress screen এ গিয়ে Insights ট্যাবে API থেকে আসা real data দেখতে পারবেন।
