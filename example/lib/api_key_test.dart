import 'package:flutter/material.dart';
import 'package:bega_supabase_auth/bega_supabase_auth.dart';

/// Test different API key formats to identify the issue
void main() {
  runApp(const ApiKeyTestApp());
}

class ApiKeyTestApp extends StatelessWidget {
  const ApiKeyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('API Key Test')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Check console for API key validation results'),
              SizedBox(height: 20),
              Text('If you see "legacy API key" error, your project'),
              Text('has legacy keys disabled. Use the new format.'),
            ],
          ),
        ),
      ),
    );
  }
}

/// Test function to validate API key format
Future<void> testApiKey() async {
  const testUrl = 'https://cgyutifkgihvrqbaodps.supabase.co';
  const testKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNneXV0aWZrZ2lodnJxYmFvZHBzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ1NjIwMDEsImV4cCI6MjA3MDEzODAwMX0.nYuZRILJ1NSqlPoMBBViXiddj8789E5qPHFjEEkhmSo';
  
  print('🔍 Testing API key format...');
  print('📍 URL: $testUrl');
  print('🔑 Key: ${testKey.substring(0, 20)}...');
  
  try {
    await BegaSupabaseConfig.initialize(
      supabaseUrl: testUrl,
      supabaseAnonKey: testKey,
    );
    print('✅ API key is VALID and working!');
    print('📊 Key format: JWT (new format)');
  } catch (e) {
    print('❌ API key error: $e');
    if (e.toString().contains('legacy')) {
      print('🔧 Issue: Legacy API keys are disabled');
      print('💡 Solution: Use the new JWT format API key');
    }
  }
}
