# Quest Time & Date Selection Fix

## সমস্যা (Problems Fixed)

### 1. When Card - Today/Tomorrow Not Selectable
**আগে:** Today/Tomorrow buttons ছিল কিন্তু visually select হতো না  
**এখন:** Click করলে properly highlight হয় এবং date pass হয়

### 2. Time Picker - Time Backend এ যাচ্ছিল না
**আগে:** Time picker শুধু show করতো, কিন্তু backend এ `select_a_time` field এ pass হতো না  
**এখন:** User selected time automatically backend এ pass হয়

## পরিবর্তনসমূহ (Changes Made)

### 1. **WhenCard** - Today/Tomorrow Selectable করা হয়েছে

#### Visual Improvements:
```dart
// Selected state এর জন্য proper styling
Container(
  decoration: BoxDecoration(
    color: selected ? Color(0xFFBFDBFE) : Color(0xFFF8FAFC),
    border: Border.all(
      color: selected ? Color(0xFF3B82F6) : Colors.transparent,
      width: 2,
    ),
  ),
)
```

**Features:**
- ✅ Today button click করলে আজকের date select হয়
- ✅ Tomorrow button click করলে কালকের date select হয়
- ✅ Selected option blue background এ highlight হয়
- ✅ Border দিয়ে clearly বোঝা যায় কোনটা selected

### 2. **TimePickerCard** - Time Callback Added

#### New Callback:
```dart
class TimePickerCard extends StatefulWidget {
  final Function(String)? onTimeSelected; // NEW
  
  const TimePickerCard({
    this.onTimeSelected, // NEW
  });
}
```

#### Time Format:
- **Format:** `HH:MM` (24-hour format)
- **Example:** `14:30` (2:30 PM)
- **Auto-update:** Timer tick করলে automatically parent কে notify করে

#### Implementation:
```dart
void _notifyTimeChange() {
  final timeString = '${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')}';
  widget.onTimeSelected?.call(timeString);
}
```

### 3. **CreateQuestPage** - Time State Management

#### State Added:
```dart
String? selectedTime; // NEW - stores selected time
```

#### Time Capture:
```dart
TimePickerCard(
  onTimeSelected: (String time) {
    setState(() => selectedTime = time);
  },
)
```

#### Backend Pass:
```dart
final quest = await questService.createQuest(
  // ... other fields
  selectATime: selectedTime, // NEW - pass to backend
);
```

### 4. **EditQuestPage** - Same Time Support

#### Load Existing Time:
```dart
selectedTime = widget.taskData?['time']; // Load from existing quest
```

#### Update with Time:
```dart
final updatedQuest = await questService.updateQuest(
  questId: widget.taskId!,
  selectATime: selectedTime, // NEW - pass to backend
);
```

### 5. **QuestService** - Backend Integration

#### Create Quest:
```dart
Future<Quest?> createQuest({
  // ... existing parameters
  String? selectATime, // NEW parameter
}) async {
  final body = {
    // ... existing fields
    if (selectATime != null) 'select_a_time': selectATime, // NEW
  };
}
```

#### Update Quest:
```dart
Future<Quest?> updateQuest({
  // ... existing parameters
  String? selectATime, // NEW parameter
}) async {
  final body = <String, dynamic>{};
  // ... existing fields
  if (selectATime != null) body['select_a_time'] = selectATime; // NEW
}
```

## Backend API Format

### Request Body Example:
```json
{
  "subtasks": [
    {
      "title": "string",
      "task_done": true
    }
  ],
  "task": "string",
  "zone": "Soft steps",
  "select_a_time": "14:30",  // ← NEW FIELD (HH:MM format)
  "select_a_date": "2026-05-07",
  "enable_call": true,
  "repeat_quest": true,
  "set_alarm": true,
  "task_done": true
}
```

## User Flow

### Create Quest:
```
1. User opens Create Quest screen
2. Fills quest details
3. Clicks "WHEN?" section
   ├─ Clicks "Today" → Today's date selected (highlighted)
   ├─ Clicks "Tomorrow" → Tomorrow's date selected (highlighted)
   └─ Clicks "Select a date" → Custom date picker opens
4. Clicks "What time?" section
   └─ Time picker expands showing current time
   └─ Time automatically updates every second
   └─ User can toggle AM/PM
5. Clicks "Create Quest"
   └─ Both date AND time sent to backend
```

### Edit Quest:
```
1. User swipes quest → Clicks "Edit"
2. Edit screen opens with pre-filled data
   ├─ Existing date shown in When section
   └─ Existing time shown in Time picker
3. User can modify date/time
4. Clicks "Update Quest"
   └─ Updated date AND time sent to backend
```

## Visual Changes

### When Card - Before vs After:

**Before:**
```
┌─────────────────┐
│ Today           │  ← No visual feedback
│ Tomorrow        │  ← No visual feedback
│ Select a date   │
└─────────────────┘
```

**After:**
```
┌─────────────────┐
│ ┏━━━━━━━━━━━┓   │
│ ┃ Today     ┃   │  ← Blue border + background when selected
│ ┗━━━━━━━━━━━┛   │
│ Tomorrow        │
│ Select a date   │
└─────────────────┘
```

## Testing Checklist

### When Card:
- [ ] Click "Today" → Blue highlight দেখা যাচ্ছে
- [ ] Click "Tomorrow" → Blue highlight দেখা যাচ্ছে
- [ ] Click "Select a date" → Date picker খুলছে
- [ ] Selected date properly backend এ যাচ্ছে

### Time Picker:
- [ ] Time picker expand হচ্ছে
- [ ] Current time দেখাচ্ছে
- [ ] Time automatically update হচ্ছে (every second)
- [ ] AM/PM toggle কাজ করছে
- [ ] Selected time backend এ যাচ্ছে

### Create Quest:
- [ ] Today select করে quest create → আজকের date এ quest তৈরি হচ্ছে
- [ ] Tomorrow select করে quest create → কালকের date এ quest তৈরি হচ্ছে
- [ ] Time select করে quest create → Time সহ quest তৈরি হচ্ছে
- [ ] Backend response এ `select_a_time` field আছে

### Edit Quest:
- [ ] Existing quest edit করলে date pre-filled দেখাচ্ছে
- [ ] Existing quest edit করলে time pre-filled দেখাচ্ছে
- [ ] Date/Time modify করে update করলে properly update হচ্ছে

## Technical Details

### Time Format:
- **Frontend:** 24-hour format (`HH:MM`)
- **Backend:** Same format expected (`select_a_time: "14:30"`)
- **Display:** 12-hour format with AM/PM for user

### Date Format:
- **Frontend:** `DateTime` object
- **Backend:** ISO format (`YYYY-MM-DD`)
- **Example:** `2026-05-07`

### State Management:
- **Local State:** `setState()` used for UI updates
- **Callback Pattern:** Parent-child communication via callbacks
- **Optional Fields:** Time is optional, can be null

## Benefits

✅ **Better UX:** Clear visual feedback for date selection  
✅ **Complete Data:** Time now properly sent to backend  
✅ **Consistent:** Same pattern for create and edit  
✅ **Flexible:** Time is optional, not required  
✅ **Real-time:** Time updates automatically  
✅ **Editable:** Can modify both date and time when editing  

## Future Enhancements

### Possible Improvements:
1. **Manual Time Input:** Allow user to manually type time
2. **Time Validation:** Validate time is in future for today's quests
3. **Time Zones:** Handle different time zones
4. **Quick Time Presets:** Add buttons like "Now", "In 1 hour", etc.
5. **Date Range:** Allow selecting date range for recurring quests

## Notes

- Time picker automatically starts from current time
- Time updates every second (live clock)
- AM/PM toggle only works on selected (middle) row
- Time format is 24-hour for backend compatibility
- Date selection is limited to 7 days ahead (as per design)
