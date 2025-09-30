import 'package:flutter/material.dart';
import 'package:bega_supabase_auth/bega_supabase_auth.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

/// Super simple example - just one widget call!
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BegaSupabaseAuth(
      supabaseUrl: "https://cgyutifkgihvrqbaodps.supabase.co",
      supabaseAnonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNneXV0aWZrZ2lodnJxYmFvZHBzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ1NjIwMDEsImV4cCI6MjA3MDEzODAwMX0.nYuZRILJ1NSqlPoMBBViXiddj8789E5qPHFjEEkhmSo",
      appTitle: "Bega Supabase Auth Demo",
      redirectUrl: "https://Hit.Alerts.com/login-callback",
      
      // Optional: Add callbacks for custom handling
      onSignInSuccess: _onSignInSuccess,
      onSignUpSuccess: _onSignUpSuccess,
      onSignOutSuccess: _onSignOutSuccess,
      onAuthError: _onAuthError,
    );
  }

  /// Handle successful sign in
  static void _onSignInSuccess(User user, String? message) {
    print('🎉 Sign in successful: ${user.email}');
    // Add your custom logic here (navigation, state management, etc.)
  }

  /// Handle successful sign up
  static void _onSignUpSuccess(User user, String? message) {
    print('🎉 Sign up successful: ${user.email}');
    // Add your custom logic here (onboarding, welcome flow, etc.)
  }

  /// Handle successful sign out
  static void _onSignOutSuccess(String? message) {
    print('👋 Sign out successful');
    // Add your custom logic here (clear data, navigate to login, etc.)
  }

  /// Handle authentication errors
  static void _onAuthError(String error, String? message) {
    print('❌ Auth error: $error');
    // Add your custom error handling here (show dialog, retry logic, etc.)
  }
}

/// That's it! 🎉
/// 
/// This single widget gives you:
/// - Complete authentication UI using pure supabase_auth_ui
/// - Email/password login
/// - Social login (Google, GitHub, Apple)
/// - User management
/// - Automatic state handling
/// - Beautiful Material Design UI
/// 
/// Just replace the URL and key with your actual Supabase credentials!
