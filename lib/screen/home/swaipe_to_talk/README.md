# Swipe to Talk - Emotion Detection Flow

## Overview
এই ফিচারটি দিনে একবার ইউজারের ইমোশন ডিটেক্ট করে এবং পরবর্তী সুইপগুলোতে সরাসরি কলিং স্ক্রিনে নিয়ে যায়।

## Flow Diagram

```
First Swipe Today:
Home Screen → Swipe Button → EmotionShareScreen → EmotionSpeakingScreen → EmotionProcessingScreen → Home Screen (with popup)

Subsequent Swipes (Same Day):
Home Screen → Swipe Button → PoupSpking (Calling Screen with timer and controls)
```

## Routes

### Emotion Detection Routes (Daily once)
- `/emotionShareScreen` - Share how you feel
- `/emotionSpeakingScreen` - Recording with animation
- `/emotionProcessingScreen` - Processing animation

### Calling Routes (After emotion detection)
- `/poupSpking` - Main calling screen with timer
- `/poupYourShareYou` - Alternative calling screen
- `/poupProssing` - Call processing
- `/poupError` - Error handling

## Files Structure

### Core Files
- `emotion_detection_helper.dart` - Manages daily emotion detection state
- `popup_share_how_you_feel.dart` - Initial screen asking user to share feelings
- `popup_speaking.dart` - Recording screen with pulsing animation
- `popup_processing.dart` - Processing screen with dot animation
- `voice_saved_popup.dart` - Success popup shown on home screen

### Logic Flow

1. **User swipes on home screen**
   - `_buildSwipeButton()` checks `EmotionDetectionHelper.shouldShowEmotionDetection()`
   - If true → Navigate to `PopupShareHowYouFeel`
   - If false → Navigate to `SwipeToTalkLoading` (calling screen)

2. **Emotion Detection Flow** (First time today)
   - `PopupShareHowYouFeel`: User holds to speak
   - `PopupSpeaking`: Records voice with pulsing animation (3 seconds)
   - `PopupProcessing`: Shows processing animation (2 seconds)
   - Marks emotion detection complete for today
   - Sets flag to show popup on home screen
   - Navigates to home screen

3. **Home Screen**
   - Checks for `show_voice_saved_popup` flag
   - If true, shows `VoiceSavedPopup` after 500ms delay
   - Clears the flag

## Key Features

### Responsive Design
- All screens use `MediaQuery` for responsive sizing
- No fixed `Positioned` widgets
- Adapts to different screen sizes

### Animations
- **PopupSpeaking**: Pulsing circles animation during recording
- **PopupProcessing**: Animated dots showing processing state

### State Management
- Uses `SharedPreferences` to track:
  - Last emotion detection date
  - Popup display flag
- Resets daily automatically

## Backend Integration (Future)

Currently, the voice recording is simulated. To integrate with backend:

1. **In `PopupSpeaking`**:
   ```dart
   // Replace simulation with actual recording
   // Send audio to backend API
   // Wait for emotion analysis response
   ```

2. **In `PopupProcessing`**:
   ```dart
   // Show actual processing status
   // Handle backend response
   // Store emotion data
   ```

## Testing

To test the flow multiple times in a day:
```dart
// Call this to reset the daily check
await EmotionDetectionHelper.reset();
```

## Design Notes

- Background color: `#91BBF9` (light blue)
- Primary color: `#4542EB` (purple)
- Secondary color: `#FF8F26` (orange)
- Font: Wosker (headings), Work Sans (body)
- All animations are smooth and non-blocking
- User can navigate away at any time
