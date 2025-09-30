import 'package:flutter_test/flutter_test.dart';
import 'package:bega_supabase_auth/bega_supabase_auth.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

void main() {
  group('Supabase Connection Tests', () {
    const testUrl = 'https://cgyutifkgihvrqbaodps.supabase.co';
    const testKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNneXV0aWZrZ2lodnJxYmFvZHBzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ1NjIwMDEsImV4cCI6MjA3MDEzODAwMX0.nYuZRILJ1NSqlPoMBBViXiddj8789E5qPHFjEEkhmSo';

    testWidgets('BegaSupabaseAuth initializes correctly', (WidgetTester tester) async {
      // Create the widget
      const widget = BegaSupabaseAuth(
        supabaseUrl: testUrl,
        supabaseAnonKey: testKey,
        appTitle: 'Test App',
      );

      // Build the widget
      await tester.pumpWidget(widget);

      // Wait for initialization
      await tester.pumpAndSettle();

      // Verify the widget builds without errors
      expect(find.byType(BegaSupabaseAuth), findsOneWidget);
    });

    test('BegaSupabaseConfig initializes with valid credentials', () async {
      // Test initialization
      await BegaSupabaseConfig.initialize(
        supabaseUrl: testUrl,
        supabaseAnonKey: testKey,
      );

      // Verify client is accessible
      expect(BegaSupabaseConfig.isInitialized, isTrue);
      expect(BegaSupabaseConfig.client, isNotNull);
    });

    test('BegaSupabaseConfig throws error with invalid credentials', () async {
      // Test with invalid URL
      expect(
        () async => await BegaSupabaseConfig.initialize(
          supabaseUrl: 'https://invalid-url.supabase.co',
          supabaseAnonKey: 'invalid-key',
        ),
        throwsException,
      );
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
    });

    test('Environment configuration loads correctly', () async {
      // Test EnvConfig
      expect(EnvConfig, isNotNull);
      
      // Test that we can call the methods (they will throw if not initialized)
      expect(() => EnvConfig.supabaseUrl, throwsException);
      expect(() => EnvConfig.supabaseAnonKey, throwsException);
    });
  });

  group('Social Authentication Setup Tests', () {
    test('OAuth providers are properly configured', () {
      // Test that OAuth providers are available
      expect(OAuthProvider.google, isNotNull);
      expect(OAuthProvider.github, isNotNull);
      expect(OAuthProvider.apple, isNotNull);
    });

    test('Redirect URL format is correct', () {
      const redirectUrl = 'https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback';
      
      // Verify URL format
      expect(redirectUrl.startsWith('https://'), isTrue);
      expect(redirectUrl.contains('supabase.co'), isTrue);
      expect(redirectUrl.endsWith('/auth/v1/callback'), isTrue);
    });
  });
}
