import 'package:flutter_test/flutter_test.dart';

import 'package:bega_supabase_auth/bega_supabase_auth.dart';

void main() {
  group('BegaSupabaseAuth', () {
    test('should export EnvConfig', () {
      expect(EnvConfig, isNotNull);
    });
  });
}
