# 📘 Facebook Social Authentication Setup Guide

## ✅ **Facebook Connector Added!**

Facebook social authentication has been added to your `BegaSupabaseAuth` widget. You'll now see a Facebook button alongside Google, GitHub, and Apple.

## 🔧 **Setup Steps:**

### **Step 1: Create Facebook App**

1. Go to [Facebook Developers](https://developers.facebook.com/)
2. Click **"My Apps"** → **"Create App"**
3. Choose **"Consumer"** or **"Business"** app type
4. Fill in app details:
   - **App Name:** Your app name
   - **App Contact Email:** Your email
   - **App Purpose:** Authentication

### **Step 2: Configure Facebook App**

1. In your Facebook App dashboard, go to **"Settings"** → **"Basic"**
2. Note down:
   - **App ID**
   - **App Secret**

3. Go to **"Products"** → **"Facebook Login"** → **"Settings"**
4. Add **Valid OAuth Redirect URIs:**
   ```
   https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
   ```

### **Step 3: Configure Supabase**

1. Go to **Supabase Dashboard** → **Authentication** → **Providers**
2. Find **Facebook** and click **"Enable"**
3. Enter your Facebook credentials:
   - **Client ID:** Your Facebook App ID
   - **Client Secret:** Your Facebook App Secret
4. Set **Redirect URL:**
   ```
   https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
   ```

### **Step 4: Test Facebook Authentication**

Run the debug example:

```bash
cd example
flutter run lib/debug_example.dart
```

**Expected behavior:**
1. You'll see a **Facebook button** (blue with Facebook logo)
2. Click the Facebook button
3. Facebook login page opens
4. Complete Facebook login
5. **App shows home screen** with your Facebook email

## 🔍 **Facebook-Specific Settings:**

### **Facebook App Settings:**
- **App Domains:** `cgyutifkgihvrqbaodps.supabase.co`
- **Privacy Policy URL:** Your privacy policy
- **Terms of Service URL:** Your terms of service
- **App Icon:** Upload your app icon

### **Facebook Login Settings:**
- **Client OAuth Login:** Enabled
- **Web OAuth Login:** Enabled
- **Enforce HTTPS:** Enabled
- **Use Strict Mode for Redirect URIs:** Enabled

## 🎯 **Available Social Providers:**

Your app now supports:
- ✅ **Google** (Red button)
- ✅ **GitHub** (Dark button)
- ✅ **Apple** (Black button)
- ✅ **Facebook** (Blue button)

## 🐛 **Troubleshooting Facebook:**

### **Common Issues:**

1. **"App Not Setup" Error:**
   - Make sure Facebook App is in **Live** mode
   - Check that Facebook Login product is added

2. **"Invalid Redirect URI" Error:**
   - Verify redirect URI in Facebook App settings
   - Must be: `https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback`

3. **"App Secret Mismatch" Error:**
   - Double-check App Secret in Supabase
   - Make sure there are no extra spaces

4. **"Permissions Error":**
   - Facebook App needs `email` permission
   - Check Facebook App permissions

### **Debug Steps:**

1. **Check Console Output:**
   ```
   ✅ Social auth successful!
   👤 User: user@facebook.com
   🔄 Auth state changed: signedIn
   ```

2. **Verify Facebook App Status:**
   - App must be in **Live** mode for production
   - **Development** mode only works for app admins

3. **Check Supabase Logs:**
   - Go to Supabase Dashboard → Logs
   - Look for Facebook authentication errors

## ✅ **Success Indicators:**

When Facebook auth works correctly, you'll see:
- Facebook button appears in the app
- Clicking opens Facebook login
- After login, app shows home screen
- Console shows success messages
- User email is displayed

## 🚀 **Ready to Use!**

Facebook social authentication is now fully integrated! Users can sign in with their Facebook accounts just like Google, GitHub, and Apple.

The Facebook button will appear automatically in your `BegaSupabaseAuth` widget - no additional code changes needed! 🎉
