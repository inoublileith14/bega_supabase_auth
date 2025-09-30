import 'package:flutter_test/flutter_test.dart';

import 'package:bega_supabase_auth/bega_supabase_auth.dart';

void main() {
  group('BegaSupabaseUI', () {
    test('should export EnvConfig', () {
      expect(EnvConfig, isNotNull);
    });

    test('should export AuthWidget', () {
      expect(AuthWidget, isNotNull);
    });

    test('should export necessary types from supabase_auth_ui', () {
      expect(MetaDataField, isNotNull);
      expect(OAuthProvider, isNotNull);
    });
  });
}
