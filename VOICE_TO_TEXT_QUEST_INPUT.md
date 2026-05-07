# Voice-to-Text Quest Input Feature

## বৈশিষ্ট্য (Feature)

Create Quest screen এ microphone icon এ click করলে voice-to-text feature activate হবে এবং user যা বলবে তা "Write down your quest..." field এ automatically লেখা হবে।

---

## User Flow

### 1. Initial State:
```
┌─────────────────────────────────┐
│ ← CREATE QUEST        🎤        │
│   Small steps big progress      │
│                                 │
│ Write down your quest...        │
└─────────────────────────────────┘
```

### 2. Click Microphone:
```
┌─────────────────────────────────┐
│ ← CREATE QUEST        🔴        │  ← Red, glowing
│   Small steps big progress      │
│                                 │
│ Listening...                    │  ← User speaks
└─────────────────────────────────┘
```

### 3. Voice Recognized:
```
┌─────────────────────────────────┐
│ ← CREATE QUEST        🎤        │
│   Small steps big progress      │
│                                 │
│ Morning exercise routine        │  ← Text appears
└─────────────────────────────────┘
```

---

## Implementation

### 1. Speech Recognition Setup

**File:** `lib/screen/quests/create_quets/create_quets_default.dart`

#### State Variables:
```dart
late stt.SpeechToText _speech;
bool _isListening = false;
bool _speechAvailable = false;
```

#### Initialize Speech:
```dart
Future<void> _initSpeech() async {
  _speech = stt.SpeechToText();
  _speechAvailable = await _speech.initialize(
    onError: (error) {
      print('Speech recognition error: $error');
      setState(() => _isListening = false);
    },
    onStatus: (status) {
      print('Speech recognition status: $status');
      if (status == 'done' || status == 'notListening') {
        setState(() => _isListening = false);
      }
    },
  );
}
```

### 2. Start Listening

```dart
Future<void> _startListening() async {
  // Request microphone permission
  final status = await Permission.microphone.request();
  
  if (!status.isGranted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Microphone permission is required'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }
  
  setState(() => _isListening = true);
  
  await _speech.listen(
    onResult: (result) {
      setState(() {
        _taskController.text = result.recognizedWords;
      });
    },
    listenFor: const Duration(seconds: 30),
    pauseFor: const Duration(seconds: 3),
    partialResults: true,
    cancelOnError: true,
  );
}
```

### 3. Stop Listening

```dart
Future<void> _stopListening() async {
  await _speech.stop();
  setState(() => _isListening = false);
}
```

### 4. Toggle Function

```dart
void _toggleListening() {
  if (_isListening) {
    _stopListening();
  } else {
    _startListening();
  }
}
```

---

## Visual Feedback

### Microphone Icon States

**File:** `lib/screen/quests/create_quets/buildTitle/title_widget.dart`

#### Not Listening (Default):
```dart
Container(
  decoration: BoxDecoration(
    color: Colors.transparent,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 6,
      ),
    ],
  ),
  child: Image.asset(Assets.svgIcons.voice.path),
)
```

#### Listening (Active):
```dart
Container(
  decoration: BoxDecoration(
    color: Color(0xFFFF4444), // Red background
    boxShadow: [
      BoxShadow(
        color: Color(0xFFFF4444).withOpacity(0.3),
        blurRadius: 12, // Larger glow
      ),
    ],
  ),
  child: Icon(
    Icons.mic,
    color: Colors.white,
    size: 24,
  ),
)
```

---

## Permissions

### Android (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.INTERNET"/>
```

### iOS (`ios/Runner/Info.plist`):
```xml
<key>NSMicrophoneUsageDescription</key>
<string>This app needs microphone access to convert your voice to text for quest creation</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>This app needs speech recognition to convert your voice to text</string>
```

---

## Features

### 1. **Real-time Recognition**
```dart
partialResults: true,
```
- Text appears as user speaks
- No need to wait until finished
- Immediate feedback

### 2. **Auto-stop**
```dart
listenFor: const Duration(seconds: 30),
pauseFor: const Duration(seconds: 3),
```
- Stops after 30 seconds max
- Auto-stops after 3 seconds of silence
- Prevents battery drain

### 3. **Error Handling**
```dart
cancelOnError: true,
onError: (error) {
  print('Speech recognition error: $error');
  setState(() => _isListening = false);
}
```
- Graceful error handling
- User-friendly error messages
- Automatic state reset

### 4. **Permission Request**
```dart
final status = await Permission.microphone.request();
if (!status.isGranted) {
  // Show error message
}
```
- Requests permission before starting
- Shows clear error if denied
- Follows platform guidelines

---

## User Experience

### Success Flow:
```
1. User clicks microphone icon
   ↓
2. Permission requested (first time only)
   ↓
3. Icon turns red with glow
   ↓
4. User speaks: "Morning exercise routine"
   ↓
5. Text appears in input field in real-time
   ↓
6. User stops speaking (3 sec pause)
   ↓
7. Icon returns to normal
   ↓
8. Text ready for editing/submission
```

### Error Scenarios:

#### Permission Denied:
```
User clicks mic → Permission denied
↓
Show SnackBar: "Microphone permission is required"
↓
Icon stays normal (not listening)
```

#### Speech Not Available:
```
User clicks mic → Speech recognition unavailable
↓
Show SnackBar: "Speech recognition not available"
↓
Icon stays normal
```

#### Network Error:
```
Listening → Network error
↓
Auto-stop listening
↓
Icon returns to normal
↓
Partial text saved (if any)
```

---

## Visual States

### State 1: Idle
```
🎤  ← Gray microphone icon
    Normal shadow
```

### State 2: Listening
```
🔴  ← Red background
    White mic icon
    Glowing shadow
```

### State 3: Processing
```
🎤  ← Returns to normal
    Text appears in field
```

---

## Dependencies

### Required Packages:
```yaml
dependencies:
  speech_to_text: ^7.3.0
  permission_handler: ^11.3.1
```

Already installed in `pubspec.yaml` ✅

---

## Testing Checklist

### Functionality:
- [ ] Click mic icon → Starts listening
- [ ] Speak → Text appears in real-time
- [ ] Stop speaking → Auto-stops after 3 seconds
- [ ] Click mic while listening → Stops listening
- [ ] Permission denied → Shows error message
- [ ] No internet → Shows error message

### Visual Feedback:
- [ ] Icon turns red when listening
- [ ] Icon has glow effect when listening
- [ ] Icon returns to normal when stopped
- [ ] Smooth transition between states

### Text Input:
- [ ] Text appears in input field
- [ ] Text is editable after voice input
- [ ] Can continue typing after voice input
- [ ] Text persists when switching fields

### Edge Cases:
- [ ] Very long speech (30+ seconds) → Auto-stops
- [ ] Background noise → Still recognizes speech
- [ ] Multiple languages → Works correctly
- [ ] Accent variations → Recognizes accurately

---

## Supported Languages

Speech recognition supports multiple languages:
- English (US, UK, AU, etc.)
- Spanish
- French
- German
- Chinese
- Japanese
- And many more...

Language is auto-detected based on device settings.

---

## Benefits

✅ **Hands-free Input:** No typing needed  
✅ **Faster:** Speak faster than type  
✅ **Accessible:** Helps users with typing difficulties  
✅ **Real-time:** See text as you speak  
✅ **Accurate:** Modern speech recognition  
✅ **User-friendly:** Clear visual feedback  
✅ **Permission-aware:** Proper permission handling  

---

## Limitations

⚠️ **Internet Required:** Speech recognition needs internet  
⚠️ **Microphone Required:** Device must have working microphone  
⚠️ **Quiet Environment:** Background noise may affect accuracy  
⚠️ **Language Support:** Limited to supported languages  
⚠️ **Battery Usage:** Uses more battery than typing  

---

## Future Enhancements

### Possible Improvements:
1. **Offline Mode:** Add offline speech recognition
2. **Language Selector:** Let user choose language
3. **Voice Commands:** "Add subtask", "Set time", etc.
4. **Punctuation:** Auto-add punctuation marks
5. **Editing Commands:** "Delete last word", "Capitalize", etc.
6. **Multiple Inputs:** Voice input for other fields too

---

## Notes

- Speech recognition accuracy depends on:
  - Microphone quality
  - Background noise level
  - Speaker's accent and clarity
  - Internet connection speed
  
- First-time users will see permission dialog
- Permission is remembered after first grant
- User can revoke permission in device settings
- App handles permission denial gracefully
