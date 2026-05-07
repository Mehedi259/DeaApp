# Quest Display - Show Time Instead of Zone

## পরিবর্তন (Change)

Home Screen এ quest card এ এখন **zone** এর জায়গায় **time** দেখাবে।

### Before:
```
┌─────────────────────────┐
│ ✓  Morning Exercise     │
│    Stretch zone    ←─── │  Zone দেখাতো
└─────────────────────────┘
```

### After:
```
┌─────────────────────────┐
│ ✓  Morning Exercise     │
│    06:30 AM       ←───  │  Time দেখাচ্ছে
└─────────────────────────┘
```

---

## Implementation

### 1. Quest Model Update

**File:** `lib/services/quest_service.dart`

#### Added Field:
```dart
class Quest {
  final int id;
  final List<Subtask> subtasks;
  final String task;
  final String zone;
  final String selectADate;
  final String? selectATime; // ← NEW: Time field added
  final bool enableCall;
  final bool repeatQuest;
  final bool setAlarm;
  bool taskDone;
}
```

#### JSON Parsing:
```dart
factory Quest.fromJson(Map<String, dynamic> json) {
  return Quest(
    // ... other fields
    selectATime: json['select_a_time'], // ← Parse time from API
  );
}
```

### 2. Home Screen Display Logic

**File:** `lib/screen/home/home_screen.dart`

#### Time Formatting:
```dart
// Format time for display (convert 24-hour to 12-hour format)
String displayTime = quest.zone; // Default to zone if no time

if (quest.selectATime != null && quest.selectATime!.isNotEmpty) {
  try {
    // Parse time (format: "06:11:00" or "06:11")
    final timeParts = quest.selectATime!.split(':');
    if (timeParts.length >= 2) {
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);
      
      // Convert to 12-hour format
      String period = hour >= 12 ? 'PM' : 'AM';
      int displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
      
      displayTime = '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
    }
  } catch (e) {
    print('Error parsing time: $e');
    displayTime = quest.zone; // Fallback to zone
  }
}
```

#### Display in TaskItem:
```dart
TaskItem(
  quest.task,      // Title
  displayTime,     // Time (instead of zone)
  quest.taskDone,  // Completion status
  questId: quest.id,
)
```

---

## Time Format Conversion

### API Response Format:
```json
{
  "select_a_time": "06:11:00"  // 24-hour format with seconds
}
```

### Display Format Examples:

| API Time    | Display Time |
|-------------|--------------|
| `06:11:00`  | `06:11 AM`   |
| `14:30:00`  | `02:30 PM`   |
| `00:00:00`  | `12:00 AM`   |
| `12:00:00`  | `12:00 PM`   |
| `23:59:00`  | `11:59 PM`   |

### Conversion Logic:

1. **Parse Time:** Split by `:` to get hour and minute
2. **Determine Period:** `hour >= 12` → PM, else AM
3. **Convert Hour:**
   - `0` → `12` (midnight)
   - `1-11` → same (AM)
   - `12` → `12` (noon)
   - `13-23` → subtract 12 (PM)
4. **Format:** `HH:MM AM/PM`

---

## Fallback Behavior

### If Time is Not Available:
```dart
String displayTime = quest.zone; // Fallback to zone
```

**Scenarios:**
- `select_a_time` is `null` → Show zone
- `select_a_time` is empty string → Show zone
- Time parsing fails → Show zone
- Old quests without time → Show zone

This ensures backward compatibility with existing quests.

---

## Edit Quest Integration

### Passing Time to Edit Screen:
```dart
'taskData': {
  'title': quest.task,
  'zone': quest.zone,
  'selectADate': quest.selectADate,
  'time': quest.selectATime, // ← Pass time for editing
  // ... other fields
}
```

When user edits a quest, the existing time is pre-filled in the time picker.

---

## Visual Examples

### Quest with Time:
```
┌─────────────────────────────────┐
│ ☐  Clean kitchen                │
│    08:00 AM                      │
└─────────────────────────────────┘
```

### Quest without Time (Fallback):
```
┌─────────────────────────────────┐
│ ☐  Read a book                  │
│    Soft steps                    │
└─────────────────────────────────┘
```

### Completed Quest with Time:
```
┌─────────────────────────────────┐
│ ✓  Morning Exercise              │
│    06:30 AM                      │
└─────────────────────────────────┘
```

---

## API Response Example

### Complete Quest Object:
```json
{
  "id": 12,
  "subtasks": [
    {
      "id": 16,
      "title": "Clean kitchen",
      "task_done": false
    }
  ],
  "task": "Morning Routine",
  "zone": "Stretch zone",
  "select_a_time": "06:11:00",  ← Time field
  "select_a_date": "2026-05-08",
  "enable_call": true,
  "repeat_quest": true,
  "set_alarm": true,
  "task_done": false
}
```

### Display Result:
```
Title: Morning Routine
Time:  06:11 AM  ← Converted from "06:11:00"
```

---

## Benefits

✅ **User-Friendly:** 12-hour format easier to read  
✅ **Relevant Info:** Time more useful than zone for scheduling  
✅ **Backward Compatible:** Falls back to zone if time not available  
✅ **Consistent:** Same format across create/edit/display  
✅ **Error Handling:** Graceful fallback on parsing errors  

---

## Testing Checklist

### Display Tests:
- [ ] Quest with time shows formatted time (e.g., "06:30 AM")
- [ ] Quest without time shows zone (fallback)
- [ ] Morning times show AM correctly (00:00-11:59)
- [ ] Afternoon times show PM correctly (12:00-23:59)
- [ ] Midnight (00:00) shows as "12:00 AM"
- [ ] Noon (12:00) shows as "12:00 PM"

### Edge Cases:
- [ ] Time with seconds ("06:11:00") parses correctly
- [ ] Time without seconds ("06:11") parses correctly
- [ ] Invalid time format falls back to zone
- [ ] Null time falls back to zone
- [ ] Empty time string falls back to zone

### Integration:
- [ ] Create quest with time → Shows time on home screen
- [ ] Edit quest → Time pre-filled correctly
- [ ] Update quest time → New time displays
- [ ] Old quests without time → Show zone (no crash)

---

## Notes

- Time parsing is defensive with try-catch
- Fallback to zone ensures no blank displays
- 12-hour format matches user expectations
- Seconds are ignored in display (not needed)
- Zone data is still stored in backend (not lost)
