# Call Summary API Integration

## Overview
Call Summary screen এ AI conversation এর summary দেখায় - mood, focus topic, energy shift, এবং next step।

## API Endpoint
```
POST https://apricot-rhyme-humming.ngrok-free.dev/api/v1/chat/summary
```

## Request
```json
{
  "session_id": "79eafde4-3996-409c-a1bb-63f362178b56"
}
```

## Response
```json
{
  "session_id": "79eafde4-3996-409c-a1bb-63f362178b56",
  "user_name": "User",
  "system_name": "Aria",
  "language": "en",
  "language_name": "English",
  "total_turns": 1,
  "mood_detected": "You sounded pretty calm and steady throughout our chat.",
  "focus_topic": "We talked a lot about just catching up and saying hi.",
  "energy_shift": "You started out neutral and stayed that way, which was nice and consistent.",
  "next_step": "Keep reaching out to chat more often!",
  "dominant_emotion": "neutral",
  "emotion_counts": {
    "neutral": 1
  },
  "emotion_timeline": [...],
  "processing_ms": 2450.8
}
```

## Files Created/Modified

### New Files:
1. **lib/models/call_summary_model.dart** - Response model
2. **lib/services/call_summary_service.dart** - API service

### Modified Files:
1. **lib/screen/ai_call/call_summary_screen.dart** - UI with API integration
2. **lib/screen/ai_call/ai_voice.dart** - Pass session ID to summary screen
3. **lib/core /app_routes/app_pages.dart** - Router configuration

## How It Works

1. **AI Voice Screen** (`ai_voice.dart`):
   - User talks with AI
   - Session ID stored in `_currentSession`
   - When call ends, navigates to summary with session ID

2. **Call Summary Screen** (`call_summary_screen.dart`):
   - Receives session ID from route parameter
   - Calls API to get summary
   - Shows loading state while fetching
   - Displays summary data or error message

3. **Navigation Flow**:
   ```
   AI Voice Screen → Quest Complete → Call Summary Screen
                                    ↓
                              (with sessionId parameter)
   ```

## Usage

### From AI Voice Screen:
```dart
// Automatic navigation after quest complete
context.go('${AppRoutespath.callSummary}?sessionId=${sessionId}');
```

### Direct Navigation:
```dart
// With session ID
context.go('/callSummary?sessionId=your-session-id');

// Without session ID (will show error)
context.go('/callSummary');
```

## Testing

1. Start AI call in `ai_voice.dart`
2. Talk with AI (session will be created)
3. Click "Mark as done" or wait for timer to complete
4. Summary screen will load with API data

## Error Handling

- **No Session ID**: Shows error message with "Go to Home" button
- **API Error**: Shows error message with details
- **Network Error**: Shows connection error message
- **Loading State**: Shows spinner with "Analyzing your conversation..." text

## Features

- ✅ Real-time API integration
- ✅ Loading state
- ✅ Error handling
- ✅ Session ID parameter passing
- ✅ Personal note saving
- ✅ Fallback to default text if API fails
- ✅ ngrok header support

## Configuration

API base URL configured in `lib/api/api_constant.dart`:
```dart
static const String aiBaseUrl = 'https://apricot-rhyme-humming.ngrok-free.dev';
```

## Notes

- Summary API requires valid session ID from AI call
- API timeout set to 15 seconds
- ngrok-skip-browser-warning header included for ngrok compatibility
- Personal notes can be saved (TODO: implement backend storage)
