# 🔍 Debug Guide for Social Authentication Issues

## ✅ **Connection Test Results**

The tests show that your Supabase connection is working correctly:
- ✅ Supabase client created successfully
- ✅ Auth service accessible
- ✅ Environment configuration working

## 🚀 **How to Debug Social Authentication**

### 1. Run the Debug Example

```bash
cd example
flutter run lib/debug_example.dart
```

This will show detailed console logs with:
- 🔧 Initialization steps
- 📍 URL and key verification
- 🔍 Connection testing
- ✅/❌ Success/error messages

### 2. Check Console Output

Look for these key messages:
```
🔧 Initializing BegaSupabaseAuth...
📍 Supabase URL: https://cgyutifkgihvrqbaodps.supabase.co
📍 Supabase Key: eyJhbGciOi...
🔍 Testing Supabase connection...
✅ Supabase client created successfully
✅ Auth service accessible
✅ Connection test passed!
✅ BegaSupabaseAuth initialized successfully!
```

### 3. Test Social Authentication

When you try to sign in with Google/GitHub/Apple, look for:
```
✅ Social auth successful!
👤 User: user@example.com
🔑 Session: eyJhbGciOiJIUzI1NiIs...
📊 User metadata: {username: john_doe}
```

Or error messages:
```
❌ Social auth error: [error details]
🔍 Error type: [error type]
```

## 🔧 **Common Social Auth Issues & Solutions**

### Issue 1: "Provider not enabled"
**Solution:** Go to Supabase Dashboard → Authentication → Providers → Enable Google/GitHub/Apple

### Issue 2: "Invalid redirect URL"
**Solution:** Check your redirect URLs in Supabase Dashboard:
- Go to Authentication → URL Configuration
- Add: `https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback`
- For mobile: `io.supabase.begaauth://callback`

### Issue 3: "OAuth client not configured"
**Solution:** Set up OAuth providers:
- **Google:** Get client ID from Google Cloud Console
- **GitHub:** Get client ID from GitHub Developer Settings
- **Apple:** Get client ID from Apple Developer Console

### Issue 4: "Network error"
**Solution:** Check internet connection and Supabase project status

## 🧪 **Test Your Setup**

### Quick Test Commands:

```bash
# Test connection
flutter test test/simple_connection_test.dart

# Run debug example
cd example
flutter run lib/debug_example.dart

# Run simple example
flutter run lib/simple_example.dart
```

### Manual Testing Steps:

1. **Email/Password:** Try creating an account with email
2. **Social Auth:** Try each provider (Google, GitHub, Apple)
3. **Check Logs:** Look for success/error messages in console
4. **Verify Session:** Check if user stays logged in after app restart

## 📊 **Expected Behavior**

### ✅ **Working Correctly:**
- App loads without errors
- Email sign up/in works
- Social auth buttons appear
- Clicking social auth opens browser/redirect
- After successful auth, user sees welcome screen
- User stays logged in after app restart

### ❌ **Common Problems:**
- App crashes on startup
- Social auth buttons don't respond
- Browser opens but shows error
- User gets logged out immediately
- Console shows connection errors

## 🆘 **Still Having Issues?**

If social authentication still doesn't work:

1. **Check Supabase Dashboard:**
   - Authentication → Providers → Are they enabled?
   - Authentication → URL Configuration → Are redirect URLs correct?
   - Settings → API → Is the project active?

2. **Check OAuth Setup:**
   - Google: Client ID configured in Supabase?
   - GitHub: Client ID and secret configured?
   - Apple: Client ID and team ID configured?

3. **Check Console Logs:**
   - Look for specific error messages
   - Check network requests in browser dev tools
   - Verify redirect URLs are being called

4. **Test with Different Providers:**
   - Try email/password first (should work)
   - Try one social provider at a time
   - Check if it's provider-specific or general issue

The debug version will show you exactly what's happening and where the issue is!
