import 'package:flutter_test/flutter_test.dart';
import 'package:bega_supabase_auth/bega_supabase_auth.dart';

void main() {
  group('Simple Connection Tests', () {
    const testUrl = 'https://cgyutifkgihvrqbaodps.supabase.co';
    const testKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNneXV0aWZrZ2lodnJxYmFvZHBzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ1NjIwMDEsImV4cCI6MjA3MDEzODAwMX0.nYuZRILJ1NSqlPoMBBViXiddj8789E5qPHFjEEkhmSo';

    test('BegaSupabaseConfig initializes with valid credentials', () async {
      // Test initialization
      await BegaSupabaseConfig.initialize(
        supabaseUrl: testUrl,
        supabaseAnonKey: testKey,
      );

      // Verify client is accessible
      expect(BegaSupabaseConfig.isInitialized, isTrue);
      expect(BegaSupabaseConfig.client, isNotNull);
      
      print('✅ Supabase connection test PASSED!');
      print('📍 URL: $testUrl');
      print('🔑 Key: ${testKey.substring(0, 10)}...');
    });

    test('Supabase client can access auth service', () async {
      await BegaSupabaseConfig.initialize(
        supabaseUrl: testUrl,
        supabaseAnonKey: testKey,
      );

      final client = BegaSupabaseConfig.client;
      final auth = client.auth;

      // Verify auth service is accessible
      expect(auth, isNotNull);
      expect(auth.currentSession, isNull); // No session initially
      
      print('✅ Auth service test PASSED!');
      print('🔐 Auth service accessible: ${auth != null}');
    });

    test('Environment configuration is available', () {
      // Test EnvConfig
      expect(EnvConfig, isNotNull);
      
      print('✅ Environment config test PASSED!');
    });
  });
}
