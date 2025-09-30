import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env_config.dart';

/// Repository for handling social authentication operations
class SocialAuthRepository {
  static SupabaseClient? _client;
  static SupabaseClient get _supabaseClient {
    _client ??= Supabase.instance.client;
    return _client!;
  }

  /// Sign in with Google
  Future<bool> signInWithGoogle({
    String? redirectTo,
    Map<String, String>? queryParams,
  }) async {
    try {
      await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: redirectTo,
        queryParams: queryParams,
      );
      return true;
    } catch (e) {
      throw SocialAuthException('Google sign in failed: $e');
    }
  }

  /// Sign in with GitHub
  Future<bool> signInWithGitHub({
    String? redirectTo,
    Map<String, String>? queryParams,
  }) async {
    try {
      await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.github,
        redirectTo: redirectTo,
        queryParams: queryParams,
      );
      return true;
    } catch (e) {
      throw SocialAuthException('GitHub sign in failed: $e');
    }
  }

  /// Sign in with Apple
  Future<bool> signInWithApple({
    String? redirectTo,
    Map<String, String>? queryParams,
  }) async {
    try {
      await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: redirectTo,
        queryParams: queryParams,
      );
      return true;
    } catch (e) {
      throw SocialAuthException('Apple sign in failed: $e');
    }
  }

  /// Sign in with Facebook
  Future<bool> signInWithFacebook({
    String? redirectTo,
    Map<String, String>? queryParams,
  }) async {
    try {
      await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.facebook,
        redirectTo: redirectTo,
        queryParams: queryParams,
      );
      return true;
    } catch (e) {
      throw SocialAuthException('Facebook sign in failed: $e');
    }
  }

  /// Sign in with Twitter
  Future<bool> signInWithTwitter({
    String? redirectTo,
    Map<String, String>? queryParams,
  }) async {
    try {
      await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.twitter,
        redirectTo: redirectTo,
        queryParams: queryParams,
      );
      return true;
    } catch (e) {
      throw SocialAuthException('Twitter sign in failed: $e');
    }
  }

  /// Sign in with Discord
  Future<bool> signInWithDiscord({
    String? redirectTo,
    Map<String, String>? queryParams,
  }) async {
    try {
      await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.discord,
        redirectTo: redirectTo,
        queryParams: queryParams,
      );
      return true;
    } catch (e) {
      throw SocialAuthException('Discord sign in failed: $e');
    }
  }

  /// Sign in with custom OAuth provider
  Future<bool> signInWithProvider(
    OAuthProvider provider, {
    String? redirectTo,
    Map<String, String>? queryParams,
  }) async {
    try {
      await _supabaseClient.auth.signInWithOAuth(
        provider,
        redirectTo: redirectTo,
        queryParams: queryParams,
      );
      return true;
    } catch (e) {
      throw SocialAuthException('${provider.name} sign in failed: $e');
    }
  }

  /// Check if a social provider is configured
  bool isProviderConfigured(String provider) {
    switch (provider.toLowerCase()) {
      case 'google':
        return EnvConfig.googleClientId != null;
      case 'github':
        return EnvConfig.githubClientId != null;
      default:
        return false;
    }
  }

  /// Get available social providers based on configuration
  List<String> getAvailableProviders() {
    final providers = <String>[];

    if (isProviderConfigured('google')) {
      providers.add('google');
    }
    if (isProviderConfigured('github')) {
      providers.add('github');
    }

    // Add other providers that don't require additional configuration
    providers.addAll(['apple', 'facebook', 'twitter', 'discord']);

    return providers;
  }
}

/// Exception thrown when social authentication operations fail
class SocialAuthException implements Exception {
  final String message;
  const SocialAuthException(this.message);

  @override
  String toString() => 'SocialAuthException: $message';
}
