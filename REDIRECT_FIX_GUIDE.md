# 🔧 Fix Social Auth Redirect Issue

## ❌ **Problem: Social auth redirects to website instead of home page**

After successful Google/GitHub/Apple login, the user gets redirected to your website instead of staying in the app and seeing the home screen.

## ✅ **Solution: Fix Redirect URL Configuration**

### **Step 1: Update Supabase Dashboard**

Go to **Supabase Dashboard** → **Authentication** → **URL Configuration** and set:

#### **Site URL (Important!):**
```
https://cgyutifkgihvrqbaodps.supabase.co
```

#### **Redirect URLs:**
```
https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
io.supabase.begaauth://callback
```

### **Step 2: Update OAuth Provider Settings**

#### **Google Cloud Console:**
1. Go to OAuth 2.0 Client IDs
2. Set **Authorized redirect URIs:**
   ```
   https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
   ```
3. Set **Authorized JavaScript origins:**
   ```
   https://cgyutifkgihvrqbaodps.supabase.co
   ```

#### **GitHub Developer Settings:**
1. Go to OAuth Apps
2. Set **Authorization callback URL:**
   ```
   https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
   ```
3. Set **Homepage URL:**
   ```
   https://cgyutifkgihvrqbaodps.supabase.co
   ```

#### **Apple Developer Console:**
1. Go to App IDs → Services
2. Set **Return URLs:**
   ```
   https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
   ```

### **Step 3: Test the Fix**

Run the debug example:

```bash
cd example
flutter run lib/debug_example.dart
```

**Expected behavior:**
1. Click Google/GitHub/Apple button
2. Browser opens for OAuth
3. User completes login
4. **App automatically shows home screen** (not website)
5. Console shows: `🎉 User should now see the home screen!`

## 🔍 **Debug Steps:**

### **Check Console Output:**
Look for these messages:
```
✅ Social auth successful!
👤 User: user@example.com
🔄 Auth state changed: signedIn
👤 User logged in: user@example.com
🎉 User should now see the home screen!
```

### **If Still Redirecting to Website:**

1. **Check Supabase Site URL:**
   - Must be: `https://cgyutifkgihvrqbaodps.supabase.co`
   - NOT your website URL

2. **Check OAuth Provider Settings:**
   - Redirect URI must be: `https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback`
   - NOT your website URL

3. **Check App Configuration:**
   - Make sure you're using the correct Supabase project
   - Verify the URL and key are correct

## 🎯 **Key Points:**

- **Site URL** in Supabase should be your Supabase project URL, not your website
- **Redirect URLs** should point to Supabase, not your website
- The app will automatically handle the redirect and show the home screen
- The auth state listener will detect the successful login and update the UI

## ✅ **Expected Result:**

After successful social login:
1. User completes OAuth in browser
2. Browser redirects to Supabase callback
3. Supabase processes the auth
4. **App automatically shows home screen**
5. User sees welcome message with their email

The redirect should now work correctly! 🎉
