import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Configuration class for initializing Bega Supabase UI
class BegaSupabaseConfig {
  static bool _isInitialized = false;

  /// Initialize Bega Supabase UI with your project credentials
  ///
  /// [supabaseUrl] - Your Supabase project URL
  /// [supabaseAnonKey] - Your Supabase anonymous key
  /// [redirectUrl] - Optional redirect URL for authentication callbacks
  static Future<void> initialize({
    required String supabaseUrl,
    required String supabaseAnonKey,
    String? redirectUrl,
  }) async {
    if (_isInitialized) {
      if (kDebugMode) {
        print('BegaSupabaseConfig is already initialized');
      }
      return;
    }

    try {
      // Initialize Supabase
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );

      _isInitialized = true;

      if (kDebugMode) {
        print('BegaSupabaseConfig initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to initialize BegaSupabaseConfig: $e');
      }
      rethrow;
    }
  }

  /// Check if Bega Supabase UI is initialized
  static bool get isInitialized => _isInitialized;

  /// Get the Supabase client instance
  static SupabaseClient get client {
    if (!_isInitialized) {
      throw Exception(
        'BegaSupabaseConfig is not initialized. '
        'Call BegaSupabaseConfig.initialize() first.',
      );
    }
    return Supabase.instance.client;
  }
}