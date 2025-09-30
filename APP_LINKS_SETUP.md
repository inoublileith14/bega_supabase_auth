# 🔗 App Links Setup for Hit.Alerts.com

## ✅ **App Links Configuration Complete!**

I've set up the complete App Links configuration for your redirect URL `https://Hit.Alerts.com/login-callback`.

## 📱 **Android Configuration (Already Done):**

### **1. AndroidManifest.xml Updated:**
```xml
<intent-filter android:label="login" android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data
        android:scheme="https"
        android:host="Hit.Alerts.com"
        android:path="/login-callback" />
</intent-filter>
```

### **2. Package Name:**
```
com.example.example
```

### **3. SHA256 Fingerprint:**
```
E3:FB:8E:A7:FF:D6:DF:CC:56:48:F4:E7:8D:64:F9:FA:7C:86:19:AD:CF:80:27:9E:07:01:2F:06:32:04:E0:4B
```

## 🌐 **Domain Configuration Required:**

### **Step 1: Host assetlinks.json**

You need to host this file at: `https://Hit.Alerts.com/.well-known/assetlinks.json`

**File content:**
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

### **Step 2: Update Supabase Settings**

1. **Go to Supabase Dashboard** → **Authentication** → **URL Configuration**
2. **Set Site URL:**
   ```
   https://Hit.Alerts.com
   ```
3. **Add Redirect URLs:**
   ```
   https://Hit.Alerts.com/login-callback
   https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
   ```

### **Step 3: Update OAuth Provider Settings**

#### **Google Cloud Console:**
- **Authorized redirect URIs:**
  ```
  https://Hit.Alerts.com/login-callback
  https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
  ```

#### **GitHub Developer Settings:**
- **Authorization callback URL:**
  ```
  https://Hit.Alerts.com/login-callback
  ```

#### **Facebook App Settings:**
- **Valid OAuth Redirect URIs:**
  ```
  https://Hit.Alerts.com/login-callback
  ```

## 🔧 **How It Works:**

1. **User clicks social login** (Google/GitHub/Apple/Facebook)
2. **OAuth provider redirects to:** `https://Hit.Alerts.com/login-callback`
3. **Android detects the URL** and checks `/.well-known/assetlinks.json`
4. **App opens automatically** (no browser redirect)
5. **Supabase processes the auth** and shows home screen

## 🧪 **Test the Setup:**

### **1. Deploy assetlinks.json:**
```bash
# Upload the file to your server
scp public/assetlinks.json user@hit.alerts.com:/var/www/html/.well-known/assetlinks.json
```

### **2. Verify the file is accessible:**
```bash
curl https://Hit.Alerts.com/.well-known/assetlinks.json
```

### **3. Test App Links:**
```bash
# Test the deep link
adb shell am start -W -a android.intent.action.VIEW -d "https://Hit.Alerts.com/login-callback" com.example.example
```

### **4. Run the app:**
```bash
cd example
flutter run lib/debug_example.dart
```

## ✅ **Expected Behavior:**

1. **Click social login button**
2. **OAuth page opens in browser**
3. **Complete login**
4. **App automatically opens** (no redirect to website)
5. **Home screen appears** with user email

## 🔍 **Troubleshooting:**

### **If App Doesn't Open Automatically:**

1. **Check assetlinks.json is accessible:**
   ```bash
   curl https://Hit.Alerts.com/.well-known/assetlinks.json
   ```

2. **Verify Android App Links:**
   - Go to Android Settings → Apps → Your App → Open by default
   - Check "Open supported links" is enabled

3. **Test deep link manually:**
   ```bash
   adb shell am start -W -a android.intent.action.VIEW -d "https://Hit.Alerts.com/login-callback" com.example.example
   ```

### **If Still Redirecting to Website:**

1. **Check Supabase Site URL** is set to `https://Hit.Alerts.com`
2. **Verify OAuth provider redirect URLs** include `https://Hit.Alerts.com/login-callback`
3. **Ensure assetlinks.json** is properly hosted and accessible

## 🎯 **Key Files Created:**

- ✅ `android/app/src/main/res/raw/assetlinks.json` (for app)
- ✅ `public/assetlinks.json` (to host on domain)
- ✅ AndroidManifest.xml (already configured)
- ✅ App Links setup complete

## 🚀 **Ready to Deploy!**

Once you host the `assetlinks.json` file on your domain, the App Links will work automatically! 🎉
