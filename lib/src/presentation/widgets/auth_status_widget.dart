import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_bloc.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_state.dart';

/// A widget that displays the current authentication status and handles state changes.
class AuthStatusWidget extends StatelessWidget {
  /// Widget to show when user is authenticated.
  final Widget authenticatedWidget;
  
  /// Widget to show when user is not authenticated.
  final Widget unauthenticatedWidget;
  
  /// Widget to show when loading.
  final Widget? loadingWidget;
  
  /// Widget to show when there's an error.
  final Widget? errorWidget;
  
  /// Callback when authentication state changes.
  final void Function(AuthState state)? onStateChanged;

  const AuthStatusWidget({
    super.key,
    required this.authenticatedWidget,
    required this.unauthenticatedWidget,
    this.loadingWidget,
    this.errorWidget,
    this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        onStateChanged?.call(state);
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return loadingWidget ?? const _DefaultLoadingWidget();
          } else if (state is AuthAuthenticated) {
            return authenticatedWidget;
          } else if (state is AuthFailure) {
            return errorWidget ?? _DefaultErrorWidget(error: state.error);
          } else {
            return unauthenticatedWidget;
          }
        },
      ),
    );
  }
}

/// A widget that shows a loading indicator with optional message.
class AuthLoadingWidget extends StatelessWidget {
  final String? message;
  final Color? color;

  const AuthLoadingWidget({
    super.key,
    this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: color),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ],
      ),
    );
  }
}

/// A widget that shows an error message with optional retry button.
class AuthErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final Color? backgroundColor;
  final Color? textColor;

  const AuthErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: textColor ?? Colors.red[700],
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              color: textColor ?? Colors.red[700],
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}

/// A widget that shows a success message.
class AuthSuccessWidget extends StatelessWidget {
  final String message;
  final Color? backgroundColor;
  final Color? textColor;

  const AuthSuccessWidget({
    super.key,
    required this.message,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: textColor ?? Colors.green[700],
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor ?? Colors.green[700],
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultLoadingWidget extends StatelessWidget {
  const _DefaultLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _DefaultErrorWidget extends StatelessWidget {
  final dynamic error;

  const _DefaultErrorWidget({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'An error occurred: ${error.toString()}',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
