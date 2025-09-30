# 🔧 Google OAuth Redirect Fix

## ❌ **Problem:**
Google Cloud Console doesn't accept custom schemes like `hitapp://login` in redirect URIs.

## ✅ **Solution: Use Supabase Callback + Custom Scheme**

### **Step 1: Google Cloud Console Settings**

**Authorized redirect URIs (Google Cloud Console):**
```
https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
https://Hit.Alerts.com/login-callback
```

**DO NOT add:** `hitapp://login` (Google doesn't accept custom schemes)

### **Step 2: Supabase Configuration**

**Site URL:**
```
https://Hit.Alerts.com
```

**Redirect URLs:**
```
https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
https://Hit.Alerts.com/login-callback
hitapp://login
```

### **Step 3: How It Works**

1. **User clicks Google login** → Google OAuth page opens
2. **User completes login** → Google redirects to Supabase callback
3. **Supabase processes auth** → Redirects to your custom URL
4. **Your app opens** → Using custom scheme or App Links

### **Step 4: Update Code**

We need to modify the redirect flow to use Supabase as the intermediary:

```dart
// Use Supabase callback for OAuth providers
redirectUrl: widget.redirectUrl ?? 'https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback'
```

### **Step 5: Create Redirect Handler**

Create a web page at `https://Hit.Alerts.com/login-callback` that redirects to your app:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Login Callback</title>
</head>
<body>
    <script>
        // Redirect to app using custom scheme
        window.location.href = 'hitapp://login';
        
        // Fallback for web
        setTimeout(() => {
            window.location.href = 'https://Hit.Alerts.com/app';
        }, 1000);
    </script>
    <p>Redirecting to app...</p>
</body>
</html>
```

## 🎯 **Alternative: Use Supabase Auth Callback**

The simplest solution is to let Supabase handle the OAuth callback and then redirect to your app.

### **Updated Approach:**

1. **OAuth providers** → Redirect to Supabase callback
2. **Supabase** → Processes authentication
3. **Supabase** → Redirects to your app using custom scheme
4. **Your app** → Opens and shows home screen

This way, Google only needs to know about the Supabase callback URL, and Supabase handles the final redirect to your app.

## ✅ **Recommended Solution:**

Use the Supabase callback URL for all OAuth providers, and configure Supabase to redirect to your app after successful authentication.

**Google Cloud Console:**
```
https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback
```

**Supabase Redirect URLs:**
```
https://Hit.Alerts.com/login-callback
hitapp://login
```

This approach is more reliable and follows OAuth best practices! 🚀


