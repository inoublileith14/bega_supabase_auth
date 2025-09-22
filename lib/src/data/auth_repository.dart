import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env_config.dart';

/// Repository for handling authentication operations with Supabase
class AuthRepository {
  static SupabaseClient? _client;
  static SupabaseClient get _supabaseClient {
    _client ??= Supabase.instance.client;
    return _client!;
  }

  /// Initialize Supabase with environment configuration
  static Future<void> initialize() async {
    await EnvConfig.initialize();
    
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );
  }

  /// Get the current user session
  User? get currentUser => _supabaseClient.auth.currentUser;

  /// Get the current session
  Session? get currentSession => _supabaseClient.auth.currentSession;

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Stream of authentication state changes
  Stream<AuthState> get authStateChanges => _supabaseClient.auth.onAuthStateChange;

  /// Sign up with email and password
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: data,
      );
      return response;
    } catch (e) {
      throw AuthException('Sign up failed: $e');
    }
  }

  /// Sign in with email and password
  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      throw AuthException('Sign in failed: $e');
    }
  }

  /// Sign in with OAuth provider
  Future<bool> signInWithOAuth(OAuthProvider provider, {
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
      throw AuthException('OAuth sign in failed: $e');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (e) {
      throw AuthException('Sign out failed: $e');
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _supabaseClient.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw AuthException('Password reset failed: $e');
    }
  }

  /// Update user password
  Future<UserResponse> updatePassword(String newPassword) async {
    try {
      final response = await _supabaseClient.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      return response;
    } catch (e) {
      throw AuthException('Password update failed: $e');
    }
  }

  /// Update user profile data
  Future<UserResponse> updateUser({
    String? email,
    String? password,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _supabaseClient.auth.updateUser(
        UserAttributes(
          email: email,
          password: password,
          data: data,
        ),
      );
      return response;
    } catch (e) {
      throw AuthException('User update failed: $e');
    }
  }

  /// Delete user account
  Future<void> deleteUser() async {
    try {
      await _supabaseClient.auth.admin.deleteUser(currentUser!.id);
    } catch (e) {
      throw AuthException('User deletion failed: $e');
    }
  }

  /// Refresh the current session
  Future<AuthResponse> refreshSession() async {
    try {
      final response = await _supabaseClient.auth.refreshSession();
      return response;
    } catch (e) {
      throw AuthException('Session refresh failed: $e');
    }
  }
}

/// Exception thrown when authentication operations fail
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}
