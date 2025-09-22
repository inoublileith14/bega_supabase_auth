import 'package:equatable/equatable.dart';
import '../../domain/auth_user.dart';
import '../../domain/auth_result.dart';

/// Base class for all authentication states
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial authentication state
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Authentication is loading
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// User is authenticated
class AuthAuthenticated extends AuthState {
  final AuthUser user;
  final String? message;

  const AuthAuthenticated({
    required this.user,
    this.message,
  });

  @override
  List<Object?> get props => [user, message];
}

/// User is not authenticated
class AuthUnauthenticated extends AuthState {
  final String? message;

  const AuthUnauthenticated({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

/// Authentication failed
class AuthFailure extends AuthState {
  final AuthError error;
  final String? message;

  const AuthFailure({
    required this.error,
    this.message,
  });

  @override
  List<Object?> get props => [error, message];
}

/// Authentication success (for operations that don't require user data)
class AuthSuccess extends AuthState {
  final String message;

  const AuthSuccess({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

/// Social authentication initiated
class AuthSocialSignInInitiated extends AuthState {
  final String provider;
  final String message;

  const AuthSocialSignInInitiated({
    required this.provider,
    required this.message,
  });

  @override
  List<Object?> get props => [provider, message];
}
