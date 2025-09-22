import '../auth_user.dart';
import '../auth_result.dart';
import '../../data/auth_repository.dart';
import '../../data/social_auth_repository.dart';

/// Use case for user authentication operations
class AuthUseCases {
  final AuthRepository _authRepository;
  final SocialAuthRepository _socialAuthRepository;

  const AuthUseCases({
    required AuthRepository authRepository,
    required SocialAuthRepository socialAuthRepository,
  }) : _authRepository = authRepository,
       _socialAuthRepository = socialAuthRepository;

  /// Sign up with email and password
  Future<AuthResult> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await _authRepository.signUp(
        email: email,
        password: password,
        data: metadata,
      );

      if (response.user != null) {
        final user = AuthUser.fromSupabaseUser(response.user!);
        return AuthResult.success(
          user: user,
          message: 'Account created successfully. Please check your email to verify your account.',
        );
      } else {
        return AuthResult.failure(
          error: AuthError.fromMessage('Failed to create account'),
        );
      }
    } catch (e) {
      return AuthResult.failure(
        error: AuthError.fromSupabaseException(e),
      );
    }
  }

  /// Sign in with email and password
  Future<AuthResult> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authRepository.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final user = AuthUser.fromSupabaseUser(response.user!);
        return AuthResult.success(
          user: user,
          message: 'Signed in successfully',
        );
      } else {
        return AuthResult.failure(
          error: AuthError.fromMessage('Failed to sign in'),
        );
      }
    } catch (e) {
      return AuthResult.failure(
        error: AuthError.fromSupabaseException(e),
      );
    }
  }

  /// Sign in with Google
  Future<AuthResult> signInWithGoogle() async {
    try {
      final success = await _socialAuthRepository.signInWithGoogle();
      if (success) {
        // Note: In a real implementation, you would need to wait for the auth state change
        // and get the user from the current session
        return AuthResult.success(
          user: const AuthUser(id: 'temp'), // Placeholder
          message: 'Google sign in initiated',
        );
      } else {
        return AuthResult.failure(
          error: AuthError.fromMessage('Failed to initiate Google sign in'),
        );
      }
    } catch (e) {
      return AuthResult.failure(
        error: AuthError.fromSupabaseException(e),
      );
    }
  }

  /// Sign in with GitHub
  Future<AuthResult> signInWithGitHub() async {
    try {
      final success = await _socialAuthRepository.signInWithGitHub();
      if (success) {
        return AuthResult.success(
          user: const AuthUser(id: 'temp'), // Placeholder
          message: 'GitHub sign in initiated',
        );
      } else {
        return AuthResult.failure(
          error: AuthError.fromMessage('Failed to initiate GitHub sign in'),
        );
      }
    } catch (e) {
      return AuthResult.failure(
        error: AuthError.fromSupabaseException(e),
      );
    }
  }

  /// Sign in with Apple
  Future<AuthResult> signInWithApple() async {
    try {
      final success = await _socialAuthRepository.signInWithApple();
      if (success) {
        return AuthResult.success(
          user: const AuthUser(id: 'temp'), // Placeholder
          message: 'Apple sign in initiated',
        );
      } else {
        return AuthResult.failure(
          error: AuthError.fromMessage('Failed to initiate Apple sign in'),
        );
      }
    } catch (e) {
      return AuthResult.failure(
        error: AuthError.fromSupabaseException(e),
      );
    }
  }

  /// Sign out
  Future<AuthResult> signOut() async {
    try {
      await _authRepository.signOut();
      return AuthResult.success(
        message: 'Signed out successfully',
      );
    } catch (e) {
      return AuthResult.failure(
        error: AuthError.fromSupabaseException(e),
      );
    }
  }

  /// Get current user
  AuthUser? getCurrentUser() {
    final user = _authRepository.currentUser;
    return user != null ? AuthUser.fromSupabaseUser(user) : null;
  }

  /// Check if user is authenticated
  bool isAuthenticated() {
    return _authRepository.isAuthenticated;
  }

  /// Reset password
  Future<AuthResult> resetPassword(String email) async {
    try {
      await _authRepository.resetPassword(email);
      return AuthResult.success(
        message: 'Password reset email sent. Please check your inbox.',
      );
    } catch (e) {
      return AuthResult.failure(
        error: AuthError.fromSupabaseException(e),
      );
    }
  }

  /// Update user password
  Future<AuthResult> updatePassword(String newPassword) async {
    try {
      final response = await _authRepository.updatePassword(newPassword);
      if (response.user != null) {
        final user = AuthUser.fromSupabaseUser(response.user!);
        return AuthResult.success(
          user: user,
          message: 'Password updated successfully',
        );
      } else {
        return AuthResult.failure(
          error: AuthError.fromMessage('Failed to update password'),
        );
      }
    } catch (e) {
      return AuthResult.failure(
        error: AuthError.fromSupabaseException(e),
      );
    }
  }

  /// Update user profile
  Future<AuthResult> updateProfile({
    String? email,
    String? password,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await _authRepository.updateUser(
        email: email,
        password: password,
        data: metadata,
      );
      if (response.user != null) {
        final user = AuthUser.fromSupabaseUser(response.user!);
        return AuthResult.success(
          user: user,
          message: 'Profile updated successfully',
        );
      } else {
        return AuthResult.failure(
          error: AuthError.fromMessage('Failed to update profile'),
        );
      }
    } catch (e) {
      return AuthResult.failure(
        error: AuthError.fromSupabaseException(e),
      );
    }
  }

  /// Delete user account
  Future<AuthResult> deleteAccount() async {
    try {
      await _authRepository.deleteUser();
      return AuthResult.success(
        message: 'Account deleted successfully',
      );
    } catch (e) {
      return AuthResult.failure(
        error: AuthError.fromSupabaseException(e),
      );
    }
  }

  /// Refresh session
  Future<AuthResult> refreshSession() async {
    try {
      final response = await _authRepository.refreshSession();
      if (response.user != null) {
        final user = AuthUser.fromSupabaseUser(response.user!);
        return AuthResult.success(
          user: user,
          message: 'Session refreshed successfully',
        );
      } else {
        return AuthResult.failure(
          error: AuthError.fromMessage('Failed to refresh session'),
        );
      }
    } catch (e) {
      return AuthResult.failure(
        error: AuthError.fromSupabaseException(e),
      );
    }
  }
}
