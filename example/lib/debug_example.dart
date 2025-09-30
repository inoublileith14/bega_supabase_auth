import 'package:flutter/material.dart';
import 'package:bega_supabase_auth/bega_supabase_auth.dart';

/// Debug example with detailed logging and connection testing
void main() {
  runApp(const DebugApp());
}

class DebugApp extends StatelessWidget {
  const DebugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BegaSupabaseAuth(
      supabaseUrl: "https://cgyutifkgihvrqbaodps.supabase.co",
      supabaseAnonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNneXV0aWZrZ2lodnJxYmFvZHBzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ1NjIwMDEsImV4cCI6MjA3MDEzODAwMX0.nYuZRILJ1NSqlPoMBBViXiddj8789E5qPHFjEEkhmSo",
      appTitle: "Debug Supabase Auth",
      redirectUrl: "https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback",
    );
  }
}

/// Debug information:
/// 
/// 1. Check the console output for detailed logs
/// 2. Look for these key messages:
///    - "🔧 Initializing BegaSupabaseAuth..."
///    - "✅ BegaSupabaseAuth initialized successfully!"
///    - "🔍 Testing Supabase connection..."
///    - "✅ Connection test passed!"
/// 
/// 3. For social auth issues, check:
///    - Supabase project settings > Authentication > Providers
///    - Make sure Google/GitHub/Apple/Facebook are enabled
///    - Check redirect URLs are configured correctly
///    - Verify OAuth client IDs are set up
/// 
/// 4. Common issues:
///    - Missing OAuth provider configuration in Supabase
///    - Incorrect redirect URL
///    - Missing OAuth client IDs
///    - Network connectivity issues
