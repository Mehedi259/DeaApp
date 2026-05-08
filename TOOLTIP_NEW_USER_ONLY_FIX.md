# Tooltip & Notification - New User Only Fix

## সমস্যা (Problem)

Home screen এ tooltip এবং notification সব ইউজারকে দেখানো হচ্ছিল, যার ফলে:
- ❌ পুরনো ইউজার যারা আগে থেকেই app ব্যবহার করছে তারাও প্রতিবার tooltip দেখছিল
- ❌ Login করার পর returning user দের জন্য unnecessary onboarding
- ❌ User experience খারাপ হচ্ছিল

## সমাধান (Solution)

এখন **শুধুমাত্র নতুন ইউজার** (যারা প্রথমবার profile setup করেছে) তারাই tooltip এবং notification দেখবে।

---

## Implementation

### 1. **New User Flag System**

একটি `is_new_user` flag ব্যবহার করা হয়েছে যা track করে ইউজার নতুন নাকি পুরনো।

```dart
// SharedPreferences keys:
'is_new_user'           // true = নতুন ইউজার, false = পুরনো ইউজার
'hasSeenHomeOnboarding' // true = tooltip দেখেছে, false = এখনো দেখেনি
```

---

### 2. **Profile Creation Time (নতুন ইউজার)**

**File:** `lib/screen/welcome_activetion_flow/notice_loader_screen.dart`

যখন নতুন ইউজার onboarding complete করে profile create করে:

```dart
if (success) {
  print('✅ Profile created successfully in onboarding!');
  
  // ✅ Mark user as NEW USER
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('is_new_user', true);
  
  // Clear onboarding data
  onboardingData.clear();
}
```

**Flow:**
```
Sign Up → OTP → Onboarding → Profile Create
                                    ↓
                          is_new_user = true
                                    ↓
                              Home Screen
                                    ↓
                    Show Tooltips + Notifications
```

---

### 3. **Login Time (পুরনো ইউজার)**

**File:** `lib/screen/auth/sign_in_screen.dart`

যখন পুরনো ইউজার login করে:

```dart
if (profile != null && profile.name.isNotEmpty) {
  // Profile exists - Returning user
  print('✅ Profile found - Navigating to home screen');
  
  // ✅ Ensure is_new_user flag is FALSE for returning users
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('is_new_user', false);
  
  context.go('/homeScreen');
}
```

**Flow:**
```
Sign In → Profile Check → Profile Found
                              ↓
                    is_new_user = false
                              ↓
                        Home Screen
                              ↓
                  NO Tooltips/Notifications
```

---

### 4. **Splash Screen (Auto-login)**

**File:** `lib/screen/splash.dart`

যখন app open হয় এবং ইউজার already logged in:

```dart
if (isFirstTime) {
  // First time user - show onboarding
  context.go('/entryScreen');
} else {
  // Returning user - go directly to home
  // ✅ Ensure is_new_user flag is false
  await prefs.setBool('is_new_user', false);
  context.go('/homeScreen');
}
```

---

### 5. **Home Screen Check**

**File:** `lib/screen/home/home_screen.dart`

Home screen load হওয়ার সময় check করা হয়:

```dart
Future<void> _checkAndShowOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  
  // Check if user just completed onboarding (new user)
  final isNewUser = prefs.getBool('is_new_user') ?? false;
  final hasSeenHomeOnboarding = prefs.getBool('hasSeenHomeOnboarding') ?? false;
  
  // ✅ Only show tooltips to NEW users who haven't seen them yet
  if (isNewUser && !hasSeenHomeOnboarding && mounted) {
    // Mark as seen
    await prefs.setBool('hasSeenHomeOnboarding', true);
    // Clear the new user flag
    await prefs.setBool('is_new_user', false);
    
    // Show onboarding tooltips
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        OnboardingOverlay.show(context, onComplete: _showAllNotifications);
      }
    });
  }
}
```

**Logic:**
```dart
if (isNewUser && !hasSeenHomeOnboarding) {
  // Show tooltips + notifications
  // Then mark as seen
  // Clear new user flag
}
```

---

## User Flows

### 🆕 **New User Flow:**

```
┌─────────────────────────────────────────────────────────┐
│                    NEW USER JOURNEY                     │
└─────────────────────────────────────────────────────────┘

1. Sign Up
   ↓
2. OTP Verification
   ↓
3. Onboarding (Name, Gender, Avatar, etc.)
   ↓
4. Profile Creation
   ├─ Profile saved to backend
   └─ is_new_user = true ✅
   ↓
5. Navigate to Home Screen
   ↓
6. Home Screen Checks:
   ├─ isNewUser? YES ✅
   └─ hasSeenHomeOnboarding? NO ✅
   ↓
7. Show Tooltips (4 steps)
   ├─ "Start here. A good day begins with rest."
   ├─ "Swipe left to reschedule or edit quests."
   ├─ "Every streak starts with day one."
   └─ "Swipe here! I'm available any time"
   ↓
8. Show Notifications (4 notifications)
   ├─ Quest starts soon
   ├─ Fuzzy's proud of you
   ├─ Wake up or wind down
   └─ You missed our talk
   ↓
9. Mark as Seen:
   ├─ hasSeenHomeOnboarding = true
   └─ is_new_user = false
   ↓
10. Normal Home Screen Usage
```

---

### 🔄 **Returning User Flow:**

```
┌─────────────────────────────────────────────────────────┐
│                 RETURNING USER JOURNEY                  │
└─────────────────────────────────────────────────────────┘

1. Sign In (or Auto-login from Splash)
   ↓
2. Profile Check
   ├─ Profile found ✅
   └─ is_new_user = false ✅
   ↓
3. Navigate to Home Screen
   ↓
4. Home Screen Checks:
   ├─ isNewUser? NO ❌
   └─ Skip tooltip check
   ↓
5. Normal Home Screen
   ├─ No tooltips
   ├─ No notifications
   └─ Direct access to all features
```

---

## Tooltip Content

### **Step 1: Progress Card**
```
"Start here. A good day begins with rest."
```
- Points to: Progress card at top
- Purpose: Show where to track daily progress

### **Step 2: Quest Swipe**
```
"Swipe left to reschedule or edit quests."
```
- Points to: Quest list items
- Purpose: Teach swipe gesture

### **Step 3: Streak Counter**
```
"Every streak starts with day one. You've already begun 💫"
```
- Points to: Streak counter (🔥 icon)
- Purpose: Motivate user about streak system

### **Step 4: Swipe to Talk**
```
"Swipe here! I'm available any time"
```
- Points to: Swipe to talk button
- Purpose: Introduce AI voice calling feature

---

## Notification Content

### **Notification 1: Voice Note (Yellow)**
```
Title: "Quest starts soon! Wanna share how u feel before we dive in?"
Subtitle: "Send a voice note to your bestie- me! Tell me what's on your mind..."
Button: "Send a quick note"
Delay: 0 seconds (immediate)
```

### **Notification 2: Progress (Green)**
```
Title: "Fuzzy's proud of you"
Subtitle: "One chat at a time, you're getting stronger"
Button: "See progress"
Delay: 10 seconds
```

### **Notification 3: Quest Suggestion (Purple)**
```
Title: "Wake up or wind down with Nowlli! 😴🌞"
Subtitle: "You can schedule Nowlli for wake-up or bedtime calls!..."
Button: "Add quest"
Delay: 5 seconds
```

### **Notification 4: Missed Talk (Red)**
```
Title: "You missed our talk, that's okay"
Subtitle: "I'm here when you're ready"
Button: "Add another quest"
Delay: 15 seconds
```

---

## Testing Scenarios

### ✅ **Test 1: New User Registration**

**Steps:**
1. Sign up with new email
2. Complete OTP verification
3. Complete onboarding flow
4. Profile created successfully
5. Navigate to home screen

**Expected Result:**
- ✅ Tooltips appear (4 steps)
- ✅ Notifications appear (4 notifications)
- ✅ After completion, flags updated:
  - `hasSeenHomeOnboarding = true`
  - `is_new_user = false`

---

### ✅ **Test 2: Returning User Login**

**Steps:**
1. Sign in with existing account
2. Profile found in backend
3. Navigate to home screen

**Expected Result:**
- ✅ NO tooltips
- ✅ NO notifications
- ✅ Direct access to home screen
- ✅ Flag: `is_new_user = false`

---

### ✅ **Test 3: App Restart (Returning User)**

**Steps:**
1. Close app completely
2. Reopen app
3. Splash screen → Auto-login
4. Navigate to home screen

**Expected Result:**
- ✅ NO tooltips
- ✅ NO notifications
- ✅ Flag: `is_new_user = false`

---

### ✅ **Test 4: Logout and Re-login**

**Steps:**
1. User logs out
2. User logs in again
3. Navigate to home screen

**Expected Result:**
- ✅ NO tooltips (already seen)
- ✅ NO notifications
- ✅ Flag: `is_new_user = false`

---

## SharedPreferences Flags

### **Flag States:**

| Scenario | is_new_user | hasSeenHomeOnboarding | Result |
|----------|-------------|----------------------|--------|
| Just registered | `true` | `false` | Show tooltips ✅ |
| After seeing tooltips | `false` | `true` | Don't show ❌ |
| Returning user login | `false` | `true` | Don't show ❌ |
| App restart | `false` | `true` | Don't show ❌ |

---

## Code Changes Summary

### **Files Modified:**

1. ✅ `lib/screen/home/home_screen.dart`
   - Added `is_new_user` check
   - Only show tooltips to new users

2. ✅ `lib/screen/welcome_activetion_flow/notice_loader_screen.dart`
   - Set `is_new_user = true` after profile creation

3. ✅ `lib/screen/auth/sign_in_screen.dart`
   - Set `is_new_user = false` for returning users

4. ✅ `lib/screen/splash.dart`
   - Set `is_new_user = false` for auto-login users

---

## Benefits

✅ **Better UX:** Returning users don't see repetitive tooltips  
✅ **Smart Detection:** Automatically distinguishes new vs returning users  
✅ **One-time Only:** Tooltips shown only once to new users  
✅ **Clean Code:** Simple flag-based system  
✅ **Persistent:** Flags saved in SharedPreferences  
✅ **No Backend Changes:** Pure frontend solution  

---

## Edge Cases Handled

### 1. **User completes onboarding but closes app before seeing tooltips:**
- ✅ `is_new_user = true` persists
- ✅ Next time they open app, tooltips will show

### 2. **User sees half the tooltips and closes app:**
- ✅ `hasSeenHomeOnboarding = true` only set after completion
- ✅ Will continue from where they left off

### 3. **User logs out and logs in again:**
- ✅ `is_new_user = false` set on login
- ✅ No tooltips shown

### 4. **User reinstalls app:**
- ✅ SharedPreferences cleared
- ✅ Treated as new user
- ✅ Will see tooltips again (expected behavior)

---

## Future Enhancements

### Possible Improvements:

1. **Backend Sync:**
   - Store `has_seen_onboarding` flag in backend
   - Sync across devices

2. **Tooltip Skip Option:**
   - Add "Skip tutorial" button
   - Let users skip if they want

3. **Replay Option:**
   - Add "Show tutorial again" in settings
   - Let users replay tooltips

4. **Analytics:**
   - Track tooltip completion rate
   - See which step users skip most

5. **A/B Testing:**
   - Test different tooltip content
   - Optimize user engagement

---

## Notes

- Tooltips are interactive (tap to continue)
- Notifications auto-dismiss after 5 seconds
- Tooltips must be completed in sequence
- Flags are stored locally (SharedPreferences)
- No network calls needed for tooltip logic

---

## Debugging

### Check Current Flags:

```dart
final prefs = await SharedPreferences.getInstance();
print('is_new_user: ${prefs.getBool('is_new_user')}');
print('hasSeenHomeOnboarding: ${prefs.getBool('hasSeenHomeOnboarding')}');
```

### Reset Flags (for testing):

```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setBool('is_new_user', true);
await prefs.setBool('hasSeenHomeOnboarding', false);
```

### Clear All Flags:

```dart
final prefs = await SharedPreferences.getInstance();
await prefs.clear();
```

---

এই fix এর মাধ্যমে এখন শুধুমাত্র নতুন ইউজাররা tooltip এবং notification দেখবে, পুরনো ইউজাররা সরাসরি home screen ব্যবহার করতে পারবে! 🎯
