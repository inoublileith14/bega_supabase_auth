# 🔧 Fix Redirect URL Mismatch Error

## ❌ **Error: "redirect url mismatch" (400)**

This error occurs when the redirect URL in your Supabase project doesn't match what the app is sending.

## ✅ **Solution Steps:**

### 1. **Update Supabase Dashboard Settings**

Go to your Supabase Dashboard → Authentication → URL Configuration and add these URLs:

#### **For Web/Desktop:**
```
https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
```

#### **For Mobile (Android/iOS):**
```
io.supabase.begaauth://callback
```

#### **For Development (if needed):**
```
http://localhost:3000/auth/callback
http://localhost:3000
```

### 2. **Verify Your Project URL**

Make sure your project URL is exactly:
```
https://cgyutifkgihvrqbaodps.supabase.co
```

### 3. **Check OAuth Provider Settings**

For each social provider (Google, GitHub, Apple), make sure:

#### **Google OAuth:**
- Go to Google Cloud Console
- OAuth 2.0 Client IDs
- Add authorized redirect URI: `https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback`

#### **GitHub OAuth:**
- Go to GitHub Settings → Developer settings → OAuth Apps
- Add callback URL: `https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback`

#### **Apple OAuth:**
- Go to Apple Developer Console
- Add redirect URI: `https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback`

### 4. **Test the Fix**

Run the debug example to test:

```bash
cd example
flutter run lib/debug_example.dart
```

Look for these success messages:
```
✅ Social auth successful!
👤 User: user@example.com
🔑 Session: eyJhbGciOiJIUzI1NiIs...
```

## 🔍 **Common Issues & Solutions:**

### Issue 1: "Invalid redirect_uri"
**Solution:** Make sure the URL in Supabase matches exactly (including https://)

### Issue 2: "redirect_uri_mismatch"
**Solution:** Check both Supabase and OAuth provider settings

### Issue 3: "unauthorized_client"
**Solution:** Verify OAuth client ID is correct in Supabase

### Issue 4: "access_denied"
**Solution:** User cancelled the OAuth flow (not an error)

## 📱 **Platform-Specific URLs:**

### **Web:**
```
https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
```

### **Android:**
```
io.supabase.begaauth://callback
```

### **iOS:**
```
io.supabase.begaauth://callback
```

### **Desktop (Windows/Mac/Linux):**
```
https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
```

## 🧪 **Test Your Setup:**

1. **Update Supabase URLs** (as shown above)
2. **Update OAuth Provider URLs** (as shown above)
3. **Run the app** and try social login
4. **Check console** for success/error messages

The redirect URL mismatch should be fixed now! 🎉
