import 'package:flutter/material.dart';
import 'package:bega_supabase_auth/bega_supabase_auth.dart';

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
    );
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
