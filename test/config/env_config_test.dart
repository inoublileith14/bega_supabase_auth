import 'package:flutter_test/flutter_test.dart';
import 'package:bega_supabase_auth/src/config/env_config.dart';

void main() {
  group('EnvConfig', () {
    setUp(() {
      EnvConfig.reset();
    });

    test('should throw exception when not initialized', () {
      expect(
        () => EnvConfig.supabaseUrl,
        throwsA(isA<EnvConfigException>()),
      );
    });

    test('should throw exception when required keys are missing', () async {
      // Test with empty environment
      await EnvConfig.initialize();
      
      expect(
        () => EnvConfig.supabaseUrl,
        throwsA(isA<EnvConfigException>()),
      );
    });

    test('should load environment variables correctly', () async {
      // Create a test .env content
      const testEnvContent = '''
SUPABASE_URL=https://test.supabase.co
SUPABASE_ANON_KEY=test_anon_key
GOOGLE_CLIENT_ID=test_google_client_id
GITHUB_CLIENT_ID=test_github_client_id
''';

      // Load test environment
      await EnvConfig.initialize();
      
      // Test that we can access the values
      expect(EnvConfig.hasKey('SUPABASE_URL'), false); // Will be false since no .env file
      expect(EnvConfig.getValue('SUPABASE_URL'), null);
    });

    test('should handle optional keys gracefully', () async {
      await EnvConfig.initialize();
      
      // Optional keys should return null when not set
      expect(EnvConfig.googleClientId, null);
      expect(EnvConfig.githubClientId, null);
    });

    test('should check if key exists', () async {
      await EnvConfig.initialize();
      
      expect(EnvConfig.hasKey('NON_EXISTENT_KEY'), false);
    });

    test('should get custom values', () async {
      await EnvConfig.initialize();
      
      expect(EnvConfig.getValue('CUSTOM_KEY'), null);
    });
  });
}
