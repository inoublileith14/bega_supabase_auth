import 'package:flutter/material.dart';
import 'package:bega_supabase_auth/bega_supabase_auth.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

/// Enhanced example showing how to use callbacks for custom redirection and error handling
void main() {
  runApp(const CallbackExampleApp());
}

class CallbackExampleApp extends StatelessWidget {
  const CallbackExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BegaSupabaseAuth(
      supabaseUrl: "https://cgyutifkgihvrqbaodps.supabase.co",
      supabaseAnonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNneXV0aWZrZ2lodnJxYmFvZHBzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ1NjIwMDEsImV4cCI6MjA3MDEzODAwMX0.nYuZRILJ1NSqlPoMBBViXiddj8789E5qPHFjEEkhmSo",
      appTitle: "Callback Example - Custom Redirection",
      redirectUrl: "https://Hit.Alerts.com/login-callback",
      
      // Success callbacks - handle successful authentication
      onSignInSuccess: _onSignInSuccess,
      onSignUpSuccess: _onSignUpSuccess,
      onSocialAuthSuccess: _onSocialAuthSuccess,
      onSignOutSuccess: _onSignOutSuccess,
      
      // Error callbacks - handle authentication errors
      onAuthError: _onAuthError,
      onSocialAuthError: _onSocialAuthError,
    );
  }

  /// Handle successful email/password sign in
  static void _onSignInSuccess(User user, String? message) {
    print('🎉 SIGN IN SUCCESS!');
    print('👤 User: ${user.email}');
    print('📊 User ID: ${user.id}');
    print('💬 Message: $message');
    
    // Here you can implement custom redirection logic
    // For example:
    // - Navigate to a specific screen
    // - Store user data
    // - Update app state
    // - Show success message
    // - Redirect to dashboard
    
    // Example: You could use a navigation service here
    // NavigationService.navigateTo('/dashboard');
    
    // Example: You could show a custom success dialog
    // showDialog(context: context, builder: (context) => SuccessDialog());
    
    // Example: You could store user preferences
    // UserPreferences.setUser(user);
  }

  /// Handle successful email/password sign up
  static void _onSignUpSuccess(User user, String? message) {
    print('🎉 SIGN UP SUCCESS!');
    print('👤 User: ${user.email}');
    print('📊 User ID: ${user.id}');
    print('💬 Message: $message');
    
    // Here you can implement custom redirection logic for new users
    // For example:
    // - Navigate to onboarding screen
    // - Send welcome email
    // - Set up user profile
    // - Show welcome tutorial
    
    // Example: Navigate to onboarding for new users
    // NavigationService.navigateTo('/onboarding');
    
    // Example: Send welcome email
    // EmailService.sendWelcomeEmail(user.email);
  }

  /// Handle successful social authentication
  static void _onSocialAuthSuccess(User user, String provider, String? message) {
    print('🎉 SOCIAL AUTH SUCCESS!');
    print('👤 User: ${user.email}');
    print('🔗 Provider: $provider');
    print('📊 User ID: ${user.id}');
    print('💬 Message: $message');
    
    // Here you can implement custom redirection logic for social auth
    // For example:
    // - Different flows for different providers
    // - Link social account to existing account
    // - Update user profile with social data
    
    // Example: Different handling per provider
    switch (provider.toLowerCase()) {
      case 'google':
        // Handle Google-specific logic
        print('🔍 Google user signed in');
        break;
      case 'github':
        // Handle GitHub-specific logic
        print('🔍 GitHub user signed in');
        break;
      case 'apple':
        // Handle Apple-specific logic
        print('🔍 Apple user signed in');
        break;
      case 'facebook':
        // Handle Facebook-specific logic
        print('🔍 Facebook user signed in');
        break;
      default:
        print('🔍 Unknown provider: $provider');
    }
    
    // Example: Navigate based on provider
    // NavigationService.navigateTo('/social-welcome?provider=$provider');
  }

  /// Handle successful sign out
  static void _onSignOutSuccess(String? message) {
    print('👋 SIGN OUT SUCCESS!');
    print('💬 Message: $message');
    
    // Here you can implement custom redirection logic for sign out
    // For example:
    // - Navigate to login screen
    // - Clear app data
    // - Show goodbye message
    // - Reset app state
    
    // Example: Navigate to login screen
    // NavigationService.navigateTo('/login');
    
    // Example: Clear user data
    // UserPreferences.clearUser();
    
    // Example: Show goodbye message
    // showSnackBar('Goodbye! Come back soon!');
  }

  /// Handle general authentication errors
  static void _onAuthError(String error, String? message) {
    print('❌ AUTH ERROR!');
    print('🚨 Error: $error');
    print('💬 Message: $message');
    
    // Here you can implement custom error handling
    // For example:
    // - Show custom error dialog
    // - Log error to analytics
    // - Retry logic
    // - Fallback authentication method
    
    // Example: Show custom error dialog
    // showDialog(context: context, builder: (context) => ErrorDialog(error));
    
    // Example: Log to analytics
    // AnalyticsService.logError('auth_error', error);
    
    // Example: Retry logic
    // if (shouldRetry(error)) {
    //   retryAuthentication();
    // }
  }

  /// Handle social authentication errors
  static void _onSocialAuthError(String error, String provider, String? message) {
    print('❌ SOCIAL AUTH ERROR!');
    print('🚨 Error: $error');
    print('🔗 Provider: $provider');
    print('💬 Message: $message');
    
    // Here you can implement custom error handling for social auth
    // For example:
    // - Provider-specific error handling
    // - Fallback to email/password
    // - Show provider-specific error messages
    
    // Example: Provider-specific error handling
    switch (provider.toLowerCase()) {
      case 'google':
        print('🔍 Google auth failed: $error');
        // Handle Google-specific error
        break;
      case 'github':
        print('🔍 GitHub auth failed: $error');
        // Handle GitHub-specific error
        break;
      case 'apple':
        print('🔍 Apple auth failed: $error');
        // Handle Apple-specific error
        break;
      case 'facebook':
        print('🔍 Facebook auth failed: $error');
        // Handle Facebook-specific error
        break;
      default:
        print('🔍 Unknown provider error: $provider - $error');
    }
    
    // Example: Show fallback option
    // showDialog(context: context, builder: (context) => 
    //   FallbackAuthDialog(provider: provider, error: error));
  }
}

/// Example of how you might implement custom navigation
class NavigationService {
  static void navigateTo(String route) {
    print('🧭 Navigating to: $route');
    // Implement your navigation logic here
    // For example, using GoRouter, Navigator, or any other navigation solution
  }
}

/// Example of how you might implement user preferences
class UserPreferences {
  static void setUser(User user) {
    print('💾 Saving user preferences for: ${user.email}');
    // Implement your user preferences storage here
  }
  
  static void clearUser() {
    print('🗑️ Clearing user preferences');
    // Implement your user preferences clearing here
  }
}

/// Example of how you might implement analytics
class AnalyticsService {
  static void logError(String event, String error) {
    print('📊 Analytics: $event - $error');
    // Implement your analytics logging here
  }
}

/// Example of how you might implement email service
class EmailService {
  static void sendWelcomeEmail(String email) {
    print('📧 Sending welcome email to: $email');
    // Implement your email service here
  }
}
