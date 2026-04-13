# Edit Profile API Integration

## Overview
এই ফোল্ডারে তিনটি স্ক্রিন আছে যেগুলো PATCH API দিয়ে প্রোফাইল আপডেট করে।

## Files

### 1. edit_profile.dart
**Purpose:** User এর নাম এবং gender আপডেট করে

**API Fields:**
- `name` - User এর নাম
- `gender` - "I'm a woman", "I'm a man", বা "Another gender"
- `profile_image` - Profile picture (file upload)

**Features:**
- ✅ Profile load করে initState-এ এবং existing data show করে
- ✅ Profile image network থেকে load করে (fallback সহ)
- ✅ Profile picture ক্লিক করলে Camera/Gallery option আসে
- ✅ Selected image preview দেখায়
- ✅ Avatar logo এবং name Fizzy card-এ show করে
- ✅ Username TextField এ pre-filled থাকে
- ✅ Gender dropdown এ pre-selected থাকে
- Save button ক্লিক করলে API call হয় (image সহ)
- Loading state দেখায়
- Success/Error dialog দেখায়

**Image Picker:**
- Bottom sheet দিয়ে Camera/Gallery select করা যায়
- Image quality optimize করা হয় (max 1024x1024, 85% quality)
- Selected image local preview দেখায়
- File upload করে API তে

### 2. efit_name.dart
**Purpose:** Avatar এর custom name আপডেট করে

**API Fields:**
- `custom_nowlii_name` - Avatar এর কাস্টম নাম (2-12 characters)

**Features:**
- ✅ Profile load করে এবং existing avatar name show করে
- ✅ Preset name হলে সেই avatar auto-select করে
- ✅ Custom name হলে TextField-এ show করে
- ✅ Avatar image network থেকে load করে (fallback সহ)
- 6টি preset নাম (KNOTTY, BLOOBY, FIZZY, BOUNCY, ZIPPY, MELON)
- Rotate button দিয়ে নাম পরিবর্তন
- Custom name input করা যায়
- Update button ক্লিক করলে API call হয়
- Loading state এবং dialogs

### 3. edit_from.dart
**Purpose:** Avatar logo/image আপডেট করে

**API Fields:**
- `avatar_logo` - Avatar এর image path

**Features:**
- ✅ Profile load করে এবং existing avatar match করে
- ✅ Match হলে সেই avatar pre-select করে (blue border)
- 6টি avatar option (A-F) grid-এ দেখায়
- Select করলে blue border দেখায়
- Update button ক্লিক করলে confirmation dialog
- "Yes, update" ক্লিক করলে API call হয়
- Avatar path mapping:
  - 0: assets/svg_images/A.png
  - 1: assets/svg_images/B.png
  - 2: assets/svg_images/C.png
  - 3: assets/svg_images/D.png
  - 4: assets/svg_images/E.png
  - 5: assets/svg_images/F.png

## Data Loading

সব স্ক্রিনে `initState()` তে profile data load করা হয়:

```dart
@override
void initState() {
  super.initState();
  _loadProfile();
}

Future<void> _loadProfile() async {
  setState(() => _isLoading = true);
  await _profileController.fetchProfile();
  
  if (_profileController.profile != null) {
    setState(() {
      _currentProfile = _profileController.profile;
      // Load existing data into UI
      _usernameController.text = _currentProfile?.name ?? '';
      _selectedGender = _currentProfile?.gender ?? "I'm a woman";
      _isLoading = false;
    });
  }
}
```

### Network Image Loading

Profile image এবং avatar logo network থেকে load করা হয় error handling সহ:

```dart
Image.network(
  _currentProfile!.profileImage!,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return Image.asset(fallbackAsset);
  },
)
```

## API Response Example

```json
{
  "profile_image": "https://partnerless-rochel-however.ngrok-free.dev/media/profiles/profile_images/ujkh_Fq5owwE.jpeg",
  "avatar_logo": "https://partnerless-rochel-however.ngrok-free.dev/media/profiles/avatar_logos/three_VXAQgZ3.png",
  "name": "Mehedi",
  "gender": "I'm a man",
  "nowlii_name": "MELON",
  "custom_nowlii_name": "MELON",
  "language": "English",
  "voice": "Female"
}
```

### ProfileController
সব স্ক্রিনে `ProfileController` ব্যবহার করা হয়েছে যা:
- `fetchProfile()` - Profile data load করে
- `updateProfile()` - Profile update করে
- Loading state manage করে
- Error handling করে

### API Endpoint
```
PATCH https://partnerless-rochel-however.ngrok-free.dev/api/profiles/
```

### Headers
```dart
{
  'Authorization': 'Bearer <access_token>',
  'Accept': 'application/json'
}
```

### Request Format
Multipart/form-data (যদি file upload থাকে) অথবা JSON

### Response
```json
{
  "id": 12,
  "name": "Mehedi",
  "gender": "I'm a man",
  "custom_nowlii_name": "MELON",
  "avatar_logo": "path/to/avatar.png",
  "profile_image": "path/to/profile.png",
  "language": "English",
  "voice": "Female"
}
```

## Usage Flow

1. **Edit Profile Screen:**
   - User নাম এবং gender edit করে
   - Save button ক্লিক করে
   - API call হয় এবং profile update হয়

2. **Edit Name Screen:**
   - Fizzy card এর edit icon ক্লিক করে এই screen-এ আসে
   - Avatar name select/type করে
   - Update button ক্লিক করে
   - API call হয় এবং custom_nowlii_name update হয়

3. **Edit From Screen:**
   - Edit Name screen থেকে avatar edit icon ক্লিক করে আসে
   - Avatar select করে
   - Update button → Confirmation dialog → Yes, update
   - API call হয় এবং avatar_logo update হয়

## Error Handling

সব স্ক্রিনে:
- Loading indicator দেখায় API call এর সময়
- Success dialog দেখায় সফল হলে
- Error dialog দেখায় ব্যর্থ হলে
- Validation করে (empty check, length check)

## Navigation

```
EditProfileScreen
  └─> EditNameScreen (Fizzy card edit icon)
       └─> EditFrom (Avatar edit icon)
```

## Notes

- সব API call multipart/form-data support করে
- Access token automatically SecureStorage থেকে নেয়
- Profile data update হলে local storage-এ save হয়
- Gender values backend এর সাথে match করতে হবে
- Image picker package: `image_picker: ^1.1.2`
- Camera এবং Gallery permission configure করা আছে (Android & iOS)

## Permissions

### Android (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" 
                 android:maxSdkVersion="32" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
```

### iOS (Info.plist)
```xml
<key>NSCameraUsageDescription</key>
<string>Nowlii needs access to your camera to take profile pictures.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Nowlii needs access to your photo library to select profile pictures.</string>
```
