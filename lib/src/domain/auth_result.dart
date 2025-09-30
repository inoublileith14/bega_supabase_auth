import 'auth_user.dart';

/// Result of an authentication operation
class AuthResult {
  final bool isSuccess;
  final String? message;
  final AuthUser? user;
  final AuthError? error;

  const AuthResult._({
    required this.isSuccess,
    this.message,
    this.user,
    this.error,
  });

  /// Create a successful authentication result
  factory AuthResult.success({AuthUser? user, String? message}) {
    return AuthResult._(isSuccess: true, user: user, message: message);
  }

  /// Create a failed authentication result
  factory AuthResult.failure({required AuthError error, String? message}) {
    return AuthResult._(isSuccess: false, error: error, message: message);
  }

  /// Check if the result is successful
  bool get isFailure => !isSuccess;

  @override
  String toString() {
    if (isSuccess) {
      return 'AuthResult.success(user: $user, message: $message)';
    } else {
      return 'AuthResult.failure(error: $error, message: $message)';
    }
  }
}

/// Authentication error types
enum AuthErrorType {
  networkError,
  invalidCredentials,
  userNotFound,
  emailAlreadyExists,
  weakPassword,
  invalidEmail,
  tooManyRequests,
  userDisabled,
  operationNotAllowed,
  requiresRecentLogin,
  unknown,
}

/// Authentication error
class AuthError {
  final AuthErrorType type;
  final String message;
  final String? code;
  final dynamic originalError;

  const AuthError({
    required this.type,
    required this.message,
    this.code,
    this.originalError,
  });

  /// Create AuthError from Supabase AuthException
  factory AuthError.fromSupabaseException(dynamic exception) {
    final message = exception.toString();

    // Map common Supabase error messages to AuthErrorType
    AuthErrorType type = AuthErrorType.unknown;
    if (message.contains('Invalid login credentials') ||
        message.contains('Invalid email or password')) {
      type = AuthErrorType.invalidCredentials;
    } else if (message.contains('User not found')) {
      type = AuthErrorType.userNotFound;
    } else if (message.contains('User already registered')) {
      type = AuthErrorType.emailAlreadyExists;
    } else if (message.contains('Password should be at least')) {
      type = AuthErrorType.weakPassword;
    } else if (message.contains('Invalid email')) {
      type = AuthErrorType.invalidEmail;
    } else if (message.contains('Too many requests')) {
      type = AuthErrorType.tooManyRequests;
    } else if (message.contains('User is disabled')) {
      type = AuthErrorType.userDisabled;
    } else if (message.contains('Operation not allowed')) {
      type = AuthErrorType.operationNotAllowed;
    } else if (message.contains('Requires recent login')) {
      type = AuthErrorType.requiresRecentLogin;
    } else if (message.contains('Network error') ||
        message.contains('Connection failed')) {
      type = AuthErrorType.networkError;
    }

    return AuthError(type: type, message: message, originalError: exception);
  }

  /// Create AuthError from string message
  factory AuthError.fromMessage(String message, {AuthErrorType? type}) {
    return AuthError(type: type ?? AuthErrorType.unknown, message: message);
  }

  @override
  String toString() {
    return 'AuthError(type: $type, message: $message, code: $code)';
  }
}
