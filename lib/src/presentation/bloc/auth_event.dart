import 'package:equatable/equatable.dart';

/// Base class for all authentication events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to check authentication status
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// Event to sign up with email and password
class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final Map<String, dynamic>? metadata;

  const AuthSignUpRequested({
    required this.email,
    required this.password,
    this.metadata,
  });

  @override
  List<Object?> get props => [email, password, metadata];
}

/// Event to sign in with email and password
class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Event to sign in with Google
class AuthGoogleSignInRequested extends AuthEvent {
  const AuthGoogleSignInRequested();
}

/// Event to sign in with GitHub
class AuthGitHubSignInRequested extends AuthEvent {
  const AuthGitHubSignInRequested();
}

/// Event to sign in with Apple
class AuthAppleSignInRequested extends AuthEvent {
  const AuthAppleSignInRequested();
}

/// Event to sign in with Facebook
class AuthFacebookSignInRequested extends AuthEvent {
  const AuthFacebookSignInRequested();
}

/// Event to sign in with Twitter
class AuthTwitterSignInRequested extends AuthEvent {
  const AuthTwitterSignInRequested();
}

/// Event to sign in with Discord
class AuthDiscordSignInRequested extends AuthEvent {
  const AuthDiscordSignInRequested();
}

/// Event to sign out
class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

/// Event to logout (alias for sign out)
class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

/// Event to reset password
class AuthPasswordResetRequested extends AuthEvent {
  final String email;

  const AuthPasswordResetRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

/// Event to update password
class AuthPasswordUpdateRequested extends AuthEvent {
  final String newPassword;

  const AuthPasswordUpdateRequested({required this.newPassword});

  @override
  List<Object?> get props => [newPassword];
}

/// Event to update user profile
class AuthProfileUpdateRequested extends AuthEvent {
  final String? email;
  final String? password;
  final Map<String, dynamic>? metadata;

  const AuthProfileUpdateRequested({this.email, this.password, this.metadata});

  @override
  List<Object?> get props => [email, password, metadata];
}

/// Event to delete user account
class AuthAccountDeletionRequested extends AuthEvent {
  const AuthAccountDeletionRequested();
}

/// Event to refresh session
class AuthSessionRefreshRequested extends AuthEvent {
  const AuthSessionRefreshRequested();
}

/// Event to clear authentication state
class AuthStateCleared extends AuthEvent {
  const AuthStateCleared();
}
