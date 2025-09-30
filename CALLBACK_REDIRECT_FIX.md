# 🚨 URGENT: Callback Redirect Issue Fix

## ❌ **Problem:**
After social login, you're being redirected to `https://admin.hitalerts.com/` instead of staying in your app.

## 🔍 **Root Cause:**
Your Supabase project's **Site URL** is set to `https://admin.hitalerts.com/` instead of your Supabase project URL.

## ✅ **Solution:**

### **Step 1: Fix Supabase Site URL**

1. Go to **Supabase Dashboard** → **Authentication** → **URL Configuration**
2. Find **Site URL** field
3. **CHANGE IT FROM:**
   ```
   https://admin.hitalerts.com/
   ```
4. **TO:**
   ```
   https://cgyutifkgihvrqbaodps.supabase.co
   ```

### **Step 2: Verify Redirect URLs**

Make sure these are set correctly:

**Redirect URLs:**
```
https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
io.supabase.begaauth://callback
```

**Additional Redirect URLs (if needed):**
```
https://admin.hitalerts.com/auth/callback
```

### **Step 3: Update OAuth Provider Settings**

#### **Google Cloud Console:**
- **Authorized redirect URIs:**
  ```
  https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
  https://admin.hitalerts.com/auth/callback
  ```

#### **GitHub Developer Settings:**
- **Authorization callback URL:**
  ```
  https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
  ```

#### **Facebook App Settings:**
- **Valid OAuth Redirect URIs:**
  ```
  https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
  ```

### **Step 4: Test the Fix**

```bash
cd example
flutter run lib/debug_example.dart
```

**Expected behavior:**
1. Click any social provider (Google/GitHub/Apple/Facebook)
2. Complete OAuth login
3. **Stay in the app** (not redirect to admin.hitalerts.com)
4. See home screen with user email

## 🔧 **Alternative Solution (If Step 1 doesn't work):**

If you need to keep `admin.hitalerts.com` as your Site URL, add this redirect URL to your Supabase project:

1. Go to **Supabase Dashboard** → **Authentication** → **URL Configuration**
2. Add to **Redirect URLs:**
   ```
   https://admin.hitalerts.com/auth/callback
   ```
3. Update your app to use this redirect URL:

```dart
BegaSupabaseAuth(
  supabaseUrl: "https://cgyutifkgihvrqbaodps.supabase.co",
  supabaseAnonKey: "your_anon_key",
  redirectUrl: "https://admin.hitalerts.com/auth/callback", // ← Use this
)
```

## 🎯 **Key Points:**

- **Site URL** determines where users go after OAuth
- **Redirect URLs** are where OAuth providers send users back
- The issue is that your Site URL is pointing to `admin.hitalerts.com`
- Change Site URL to your Supabase project URL for app-based auth

## ✅ **Expected Result:**

After fixing the Site URL:
1. Social login works
2. User stays in the app
3. Home screen appears
4. No redirect to admin.hitalerts.com

The redirect issue should be completely resolved! 🎉
