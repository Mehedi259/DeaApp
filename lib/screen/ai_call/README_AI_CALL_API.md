# AI Call API Integration

## Overview
AI calling system এর সম্পূর্ণ integration যা real-time voice conversation, emotion detection এবং streaming response support করে।

## API Endpoints

### 1. Create Session
**Endpoint:** `POST /api/v1/session/new`

**Request:**
```json
{
  "user_name": "User",
  "system_name": "Fizzy",
  "language": "en"
}
```

**Response:**
```json
{
  "session_id": "beb01a68-5725-4630-985f-733678c5f55a",
  "user_name": "User",
  "system_name": "Fizzy",
  "language": "en",
  "language_name": "English",
  "created_at": 1776036541.0296397
}
```

### 2. Chat Stream
**Endpoint:** `POST /api/v1/chat-stream`

**Request:**
```json
{
  "message": "i want to kill someone",
  "session_id": "beb01a68-5725-4630-985f-733678c5f55a"
}
```

**Response (Server-Sent Events):**
```
event: emotion
data: {"name": "anger", "emotion_key": "angry", "score": 0.95, ...}

event: word
data: That

event: word
data: sounds

event: done
data: {"turn": 1, "words": 31, "language": "en", "emotion_key": "angry"}
```

## Features Implemented

### 1. Session Management
- Session তৈরি করা হয় app start এ
- Session ID সংরক্ষণ করা হয় পুরো conversation এর জন্য

### 2. Voice Input (Speech-to-Text)
- Microphone button long press করলে listening শুরু হয়
- Release করলে বন্ধ হয় এবং message send হয়
- Real-time speech recognition
- Mute functionality

### 3. AI Response (Text-to-Speech)
- Streaming response word by word
- প্রতিটি word speak করা হয় real-time এ
- Response display করা হয় UI তে

### 4. Emotion Detection
- Real-time emotion analysis
- Emotion display with icon এবং score
- Color-coded emotions:
  - Happy/Joy: Green
  - Sad/Sadness: Blue
  - Angry/Anger: Red
  - Fear/Scared: Orange
  - Surprise: Purple
  - Calm/Neutral: Grey

### 5. UI Indicators
- Listening indicator (red pulsing)
- Processing indicator
- Emotion badge
- AI response text display

## Usage

### Starting a Call
1. Screen load হলে automatically session তৈরি হয়
2. Timer শুরু হয় (5 minutes initial)
3. Speech recognition initialize হয়

### Talking to AI
1. Microphone button long press করুন
2. কথা বলুন
3. Release করুন
4. AI response শুনুন এবং দেখুন

### Controls
- **Microphone (Long Press):** Voice input
- **Microphone (Tap):** Mute/Unmute
- **Volume:** TTS volume control
- **Pause:** Timer pause
- **Mark as Done:** Quest complete করুন

## Configuration

### API Base URL
`lib/api/api_constant.dart` এ base URL পরিবর্তন করুন:
```dart
static const String baseUrl = 'https://partnerless-rochel-however.ngrok-free.dev';
```

### Language Settings
Session তৈরির সময় language পরিবর্তন করতে পারেন:
```dart
await _aiCallService.createSession(
  userName: 'User',
  systemName: 'Fizzy',
  language: 'bn', // Bengali
);
```

## Dependencies
- `speech_to_text: ^7.3.0` - Voice input
- `flutter_tts: ^4.2.0` - Voice output
- `http: ^1.2.2` - API calls
- `permission_handler: ^11.3.1` - Microphone permission

## Permissions Required

### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.INTERNET"/>
```

### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSMicrophoneUsageDescription</key>
<string>This app needs microphone access for voice calls</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>This app needs speech recognition for voice calls</string>
```

## Error Handling
- Session creation failure: Retry mechanism
- Network errors: User notification
- Speech recognition errors: Console logging
- TTS errors: Fallback to text display

## Future Enhancements
- Volume control implementation
- Background noise cancellation
- Multi-language support UI
- Conversation history
- Emotion-based UI themes
