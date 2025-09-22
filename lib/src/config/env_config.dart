import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration service for loading .env variables
class EnvConfig {
  static const String _supabaseUrlKey = 'SUPABASE_URL';
  static const String _supabaseAnonKeyKey = 'SUPABASE_ANON_KEY';
  static const String _googleClientIdKey = 'GOOGLE_CLIENT_ID';
  static const String _githubClientIdKey = 'GITHUB_CLIENT_ID';

  static bool _isInitialized = false;

  /// Initialize the environment configuration by loading .env file
  static Future<void> initialize({String? envFilePath}) async {
    if (_isInitialized) return;

    try {
      await dotenv.load(fileName: envFilePath ?? '.env');
      _isInitialized = true;
    } catch (e) {
      // If .env file doesn't exist, initialize with empty environment
      // This allows the app to work without .env file (useful for testing)
      dotenv.testLoad(fileInput: '');
      _isInitialized = true;
    }
  }

  /// Get Supabase URL from environment variables
  static String get supabaseUrl {
    _ensureInitialized();
    final url = dotenv.env[_supabaseUrlKey];
    if (url == null || url.isEmpty) {
      throw EnvConfigException('SUPABASE_URL is not set in environment variables');
    }
    return url;
  }

  /// Get Supabase anonymous key from environment variables
  static String get supabaseAnonKey {
    _ensureInitialized();
    final key = dotenv.env[_supabaseAnonKeyKey];
    if (key == null || key.isEmpty) {
      throw EnvConfigException('SUPABASE_ANON_KEY is not set in environment variables');
    }
    return key;
  }

  /// Get Google Client ID from environment variables (optional)
  static String? get googleClientId {
    _ensureInitialized();
    return dotenv.env[_googleClientIdKey];
  }

  /// Get GitHub Client ID from environment variables (optional)
  static String? get githubClientId {
    _ensureInitialized();
    return dotenv.env[_githubClientIdKey];
  }

  /// Check if a specific key exists in environment variables
  static bool hasKey(String key) {
    _ensureInitialized();
    return dotenv.env.containsKey(key) && dotenv.env[key]!.isNotEmpty;
  }

  /// Get a custom environment variable value
  static String? getValue(String key) {
    _ensureInitialized();
    return dotenv.env[key];
  }

  /// Ensure the configuration is initialized
  static void _ensureInitialized() {
    if (!_isInitialized) {
      throw EnvConfigException('EnvConfig must be initialized before use. Call EnvConfig.initialize() first.');
    }
  }

  /// Reset the configuration (useful for testing)
  static void reset() {
    _isInitialized = false;
    dotenv.testLoad(fileInput: '');
  }
}

/// Exception thrown when environment configuration fails
class EnvConfigException implements Exception {
  final String message;
  const EnvConfigException(this.message);

  @override
  String toString() => 'EnvConfigException: $message';
}
