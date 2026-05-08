# Monthly Overview API Data Fix

## Problem
The Monthly Overview section in the Insights screen was using hardcoded values instead of dynamic API data:
1. "66/100" quests completed was hardcoded
2. Progress bar width (0.66) was hardcoded
3. Month name "January" was hardcoded

## Solution Implemented

### 1. Dynamic Quest Completion Data
**Location**: `lib/screen/progress/insights/insights.dart` - `_buildMonthlyOverview()` method

Added variables at the start of the method to extract API data:
```dart
final monthly = _insightsData!.monthly;
final questsCompleted = monthly.questsCompleted;
final completionRate = questsCompleted.assigned > 0
    ? questsCompleted.completed / questsCompleted.assigned
    : 0.0;
```

**Changes**:
- Replaced hardcoded `"66/100"` with `"${questsCompleted.completed}/${questsCompleted.assigned}"`
- Replaced hardcoded `widthFactor: 0.66` with `widthFactor: completionRate`

### 2. Dynamic Month Name
**Location**: `lib/screen/progress/insights/insights.dart` - Line 1122

Added logic to extract current month from API calendar data:
```dart
String currentMonth = 'This month';
if (monthly.calendar.isNotEmpty) {
  try {
    final firstDate = DateTime.parse(monthly.calendar.first.date);
    currentMonth = DateFormat('MMMM').format(firstDate);
  } catch (e) {
    print('Error parsing date: $e');
  }
}
```

**Changes**:
- Replaced hardcoded `'January'` with `currentMonth` variable
- Added `import 'package:intl/intl.dart';` for DateFormat support
- Falls back to "This month" if date parsing fails

### 3. Calendar Grid Verification
**Location**: `lib/screen/progress/insights/insights.dart` - `_buildCalendarGrid()` method

Verified that calendar grid already uses API data correctly:
- Uses `monthly.calendar` array for calendar days
- Extracts day numbers from API date strings (format: "2026-05-01")
- Displays proper day status (skipped, consistent, streak, empty)

## API Data Structure Used

```json
{
  "monthly": {
    "quests_completed": {
      "assigned": 2,
      "completed": 2
    },
    "calendar": [
      {
        "date": "2026-05-01",
        "status": "skipped"
      },
      ...
    ]
  }
}
```

## Files Modified
1. `lib/screen/progress/insights/insights.dart`
   - Added `intl` package import
   - Modified `_buildMonthlyOverview()` method to use API data
   - Replaced hardcoded values with dynamic calculations

## Testing Notes
- Completion rate calculation handles division by zero (when assigned = 0)
- Month name extraction has error handling with fallback
- Calendar grid properly parses date strings from API
- All changes maintain existing UI styling and layout

## Result
✅ Monthly Overview now displays:
- Real-time quest completion data from API
- Accurate progress bar based on completion rate
- Current month name from calendar data
- Dynamic calendar grid with proper day statuses
