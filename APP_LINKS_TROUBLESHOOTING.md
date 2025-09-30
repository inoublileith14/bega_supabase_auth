# 🔧 App Links Troubleshooting Guide

## ❌ **Problem: App not opening after OAuth redirect**

Even with correct `assetlinks.json` and OAuth settings, the app doesn't open automatically after social login.

## 🔍 **Step-by-Step Fix:**

### **Step 1: Verify assetlinks.json is hosted correctly**

**Check if the file is accessible:**
```bash
curl https://Hit.Alerts.com/.well-known/assetlinks.json
```

**Expected response:**
```json
[{
  "relation": ["delegate_permission/common.handle_all_urls"],
  "target": {
    "namespace": "android_app",
    "package_name": "com.example.example",
    "sha256_cert_fingerprints": ["E3:FB:8E:A7:FF:D6:DF:CC:56:48:F4:E7:8D:64:F9:FA:7C:86:19:AD:CF:80:27:9E:07:01:2F:06:32:04:E0:4B"]
  }
}]
```

### **Step 2: Fix AndroidManifest.xml**

The current manifest might have issues. Let's update it:

```xml
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTop"
    android:taskAffinity=""
    android:theme="@style/LaunchTheme"
    android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
    android:hardwareAccelerated="true"
    android:windowSoftInputMode="adjustResize">

    <!-- Main launcher -->
    <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
    </intent-filter>

    <!-- App Links intent filter -->
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="https"
              android:host="Hit.Alerts.com"
              android:path="/login-callback" />
    </intent-filter>

    <!-- Fallback intent filter (without autoVerify) -->
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="https"
              android:host="Hit.Alerts.com"
              android:path="/login-callback" />
    </intent-filter>
</activity>
```

### **Step 3: Test App Links manually**

**Test deep link:**
```bash
adb shell am start -W -a android.intent.action.VIEW -d "https://Hit.Alerts.com/login-callback" com.example.example
```

**Expected result:** App should open

### **Step 4: Check App Links verification**

**On Android device:**
1. Go to **Settings** → **Apps** → **Your App**
2. Tap **Open by default**
3. Check if **"Open supported links"** is enabled
4. Look for **"Verified links"** section

### **Step 5: Alternative Solution - Use Custom Scheme**

If App Links don't work, use a custom scheme as fallback:

**Update AndroidManifest.xml:**
```xml
<!-- Custom scheme intent filter -->
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="hitapp"
          android:host="login" />
</intent-filter>
```

**Update redirect URL in code:**
```dart
redirectUrl: widget.redirectUrl ?? (kIsWeb ? 'https://Hit.Alerts.com/login-callback' : 'hitapp://login'),
```

**Update Supabase redirect URLs:**
```
https://Hit.Alerts.com/login-callback
hitapp://login
```

### **Step 6: Debug App Links**

**Enable App Links debugging:**
```bash
adb shell pm set-app-links --package com.example.example 1
```

**Check App Links status:**
```bash
adb shell pm get-app-links com.example.example
```

**Reset App Links:**
```bash
adb shell pm set-app-links --package com.example.example 0
adb shell pm set-app-links --package com.example.example 1
```

## 🎯 **Quick Fix Options:**

### **Option 1: Use Custom Scheme (Recommended)**
- More reliable than App Links
- Works immediately
- No domain verification needed

### **Option 2: Fix App Links**
- Requires proper domain hosting
- More complex setup
- Better user experience when working

### **Option 3: Hybrid Approach**
- Use App Links for web
- Use custom scheme for mobile
- Best of both worlds

## ✅ **Expected Results:**

After implementing the fix:
1. **Social login** → OAuth page opens
2. **After login** → App opens automatically
3. **Home screen** appears with user email
4. **No browser redirect** to website

## 🔍 **Common Issues:**

1. **assetlinks.json not accessible** → Fix domain hosting
2. **App Links not verified** → Check Android settings
3. **Wrong package name** → Update in assetlinks.json
4. **Wrong SHA256 fingerprint** → Regenerate and update
5. **Intent filter issues** → Update AndroidManifest.xml

Choose the approach that works best for your setup! 🚀
