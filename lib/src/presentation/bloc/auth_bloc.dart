import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState, AuthUser;
import 'package:gotrue/gotrue.dart' as gotrue;
import '../../domain/use_cases/auth_use_cases.dart';
import '../../domain/auth_user.dart';
import '../../domain/auth_result.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC for managing authentication state and operations
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCases _authUseCases;
  StreamSubscription<gotrue.AuthState>? _authStateSubscription;

  AuthBloc({
    required AuthUseCases authUseCases,
  }) : _authUseCases = authUseCases,
       super(const AuthInitial()) {
    
    // Register event handlers
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthSignInRequested>(_onAuthSignInRequested);
    on<AuthGoogleSignInRequested>(_onAuthGoogleSignInRequested);
    on<AuthGitHubSignInRequested>(_onAuthGitHubSignInRequested);
    on<AuthAppleSignInRequested>(_onAuthAppleSignInRequested);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
    on<AuthPasswordResetRequested>(_onAuthPasswordResetRequested);
    on<AuthPasswordUpdateRequested>(_onAuthPasswordUpdateRequested);
    on<AuthProfileUpdateRequested>(_onAuthProfileUpdateRequested);
    on<AuthAccountDeletionRequested>(_onAuthAccountDeletionRequested);
    on<AuthSessionRefreshRequested>(_onAuthSessionRefreshRequested);
    on<AuthStateCleared>(_onAuthStateCleared);

    // Listen to authentication state changes
    _listenToAuthStateChanges();
  }

  /// Listen to authentication state changes from Supabase
  void _listenToAuthStateChanges() {
    _authStateSubscription = Supabase.instance.client.auth.onAuthStateChange.listen(
      (gotrue.AuthState authState) {
        if (authState.event == AuthChangeEvent.signedIn && authState.session?.user != null) {
          final user = AuthUser.fromSupabaseUser(authState.session!.user!);
          emit(AuthAuthenticated(user: user));
        } else if (authState.event == AuthChangeEvent.signedOut) {
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  /// Handle authentication check request
  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      if (_authUseCases.isAuthenticated()) {
        final user = _authUseCases.getCurrentUser();
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(const AuthUnauthenticated());
        }
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(
        error: AuthError.fromSupabaseException(e),
        message: 'Failed to check authentication status',
      ));
    }
  }

  /// Handle sign up request
  Future<void> _onAuthSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final result = await _authUseCases.signUp(
        email: event.email,
        password: event.password,
        metadata: event.metadata,
      );

      if (result.isSuccess) {
        if (result.user != null) {
          emit(AuthAuthenticated(
            user: result.user!,
            message: result.message,
          ));
        } else {
          emit(AuthSuccess(message: result.message ?? 'Sign up successful'));
        }
      } else {
        emit(AuthFailure(
          error: result.error!,
          message: result.message,
        ));
      }
    } catch (e) {
      emit(AuthFailure(
        error: AuthError.fromSupabaseException(e),
        message: 'Sign up failed',
      ));
    }
  }

  /// Handle sign in request
  Future<void> _onAuthSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final result = await _authUseCases.signInWithPassword(
        email: event.email,
        password: event.password,
      );

      if (result.isSuccess && result.user != null) {
        emit(AuthAuthenticated(
          user: result.user!,
          message: result.message,
        ));
      } else {
        emit(AuthFailure(
          error: result.error!,
          message: result.message,
        ));
      }
    } catch (e) {
      emit(AuthFailure(
        error: AuthError.fromSupabaseException(e),
        message: 'Sign in failed',
      ));
    }
  }

  /// Handle Google sign in request
  Future<void> _onAuthGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final result = await _authUseCases.signInWithGoogle();

      if (result.isSuccess) {
        emit(AuthSocialSignInInitiated(
          provider: 'Google',
          message: result.message ?? 'Google sign in initiated',
        ));
      } else {
        emit(AuthFailure(
          error: result.error!,
          message: result.message,
        ));
      }
    } catch (e) {
      emit(AuthFailure(
        error: AuthError.fromSupabaseException(e),
        message: 'Google sign in failed',
      ));
    }
  }

  /// Handle GitHub sign in request
  Future<void> _onAuthGitHubSignInRequested(
    AuthGitHubSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final result = await _authUseCases.signInWithGitHub();

      if (result.isSuccess) {
        emit(AuthSocialSignInInitiated(
          provider: 'GitHub',
          message: result.message ?? 'GitHub sign in initiated',
        ));
      } else {
        emit(AuthFailure(
          error: result.error!,
          message: result.message,
        ));
      }
    } catch (e) {
      emit(AuthFailure(
        error: AuthError.fromSupabaseException(e),
        message: 'GitHub sign in failed',
      ));
    }
  }

  /// Handle Apple sign in request
  Future<void> _onAuthAppleSignInRequested(
    AuthAppleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final result = await _authUseCases.signInWithApple();

      if (result.isSuccess) {
        emit(AuthSocialSignInInitiated(
          provider: 'Apple',
          message: result.message ?? 'Apple sign in initiated',
        ));
      } else {
        emit(AuthFailure(
          error: result.error!,
          message: result.message,
        ));
      }
    } catch (e) {
      emit(AuthFailure(
        error: AuthError.fromSupabaseException(e),
        message: 'Apple sign in failed',
      ));
    }
  }

  /// Handle sign out request
  Future<void> _onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final result = await _authUseCases.signOut();

      if (result.isSuccess) {
        emit(AuthUnauthenticated(message: result.message));
      } else {
        emit(AuthFailure(
          error: result.error!,
          message: result.message,
        ));
      }
    } catch (e) {
      emit(AuthFailure(
        error: AuthError.fromSupabaseException(e),
        message: 'Sign out failed',
      ));
    }
  }

  /// Handle password reset request
  Future<void> _onAuthPasswordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final result = await _authUseCases.resetPassword(event.email);

      if (result.isSuccess) {
        emit(AuthSuccess(message: result.message ?? 'Password reset email sent'));
      } else {
        emit(AuthFailure(
          error: result.error!,
          message: result.message,
        ));
      }
    } catch (e) {
      emit(AuthFailure(
        error: AuthError.fromSupabaseException(e),
        message: 'Password reset failed',
      ));
    }
  }

  /// Handle password update request
  Future<void> _onAuthPasswordUpdateRequested(
    AuthPasswordUpdateRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final result = await _authUseCases.updatePassword(event.newPassword);

      if (result.isSuccess) {
        if (result.user != null) {
          emit(AuthAuthenticated(
            user: result.user!,
            message: result.message,
          ));
        } else {
          emit(AuthSuccess(message: result.message ?? 'Password updated successfully'));
        }
      } else {
        emit(AuthFailure(
          error: result.error!,
          message: result.message,
        ));
      }
    } catch (e) {
      emit(AuthFailure(
        error: AuthError.fromSupabaseException(e),
        message: 'Password update failed',
      ));
    }
  }

  /// Handle profile update request
  Future<void> _onAuthProfileUpdateRequested(
    AuthProfileUpdateRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final result = await _authUseCases.updateProfile(
        email: event.email,
        password: event.password,
        metadata: event.metadata,
      );

      if (result.isSuccess && result.user != null) {
        emit(AuthAuthenticated(
          user: result.user!,
          message: result.message,
        ));
      } else {
        emit(AuthFailure(
          error: result.error!,
          message: result.message,
        ));
      }
    } catch (e) {
      emit(AuthFailure(
        error: AuthError.fromSupabaseException(e),
        message: 'Profile update failed',
      ));
    }
  }

  /// Handle account deletion request
  Future<void> _onAuthAccountDeletionRequested(
    AuthAccountDeletionRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final result = await _authUseCases.deleteAccount();

      if (result.isSuccess) {
        emit(AuthUnauthenticated(message: result.message));
      } else {
        emit(AuthFailure(
          error: result.error!,
          message: result.message,
        ));
      }
    } catch (e) {
      emit(AuthFailure(
        error: AuthError.fromSupabaseException(e),
        message: 'Account deletion failed',
      ));
    }
  }

  /// Handle session refresh request
  Future<void> _onAuthSessionRefreshRequested(
    AuthSessionRefreshRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final result = await _authUseCases.refreshSession();

      if (result.isSuccess && result.user != null) {
        emit(AuthAuthenticated(
          user: result.user!,
          message: result.message,
        ));
      } else {
        emit(AuthFailure(
          error: result.error!,
          message: result.message,
        ));
      }
    } catch (e) {
      emit(AuthFailure(
        error: AuthError.fromSupabaseException(e),
        message: 'Session refresh failed',
      ));
    }
  }

  /// Handle state clear request
  void _onAuthStateCleared(
    AuthStateCleared event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthInitial());
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
