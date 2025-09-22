# Bega Supabase Auth

A comprehensive Flutter package that provides a clean, BLoC-based authentication system for Supabase with support for email/password and social authentication providers.

## Features

- 🔐 **Email/Password Authentication** - Complete sign up, sign in, and password management
- 🌐 **Social Authentication** - Google, GitHub, Apple, Facebook, Twitter, and Discord support
- 🏗️ **Clean Architecture** - Domain, Data, and Presentation layers with proper separation of concerns
- 📱 **BLoC State Management** - Reactive state management with flutter_bloc
- ⚙️ **Environment Configuration** - Secure configuration using .env files
- 🧪 **Comprehensive Testing** - Unit tests with 90%+ coverage
- 📦 **Easy Integration** - Simple setup with minimal configuration
- 🎨 **Example App** - Complete working example demonstrating all features

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  bega_supabase_auth: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Quick Start

### 1. Environment Setup

Create a `.env` file in your project root:

```env
# Supabase Configuration
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key

# OAuth Provider Configuration (Optional)
GOOGLE_CLIENT_ID=your_google_client_id
GITHUB_CLIENT_ID=your_github_client_id
```

### 2. Initialize the Package

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bega_supabase_auth/bega_supabase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize environment configuration
  await EnvConfig.initialize();
  
  runApp(MyApp());
}
```

### 3. Setup BLoC Provider

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authUseCases: AuthUseCases(
          authRepository: AuthRepository(),
          socialAuthRepository: SocialAuthRepository(),
        ),
      ),
      child: MaterialApp(
        home: AuthWrapper(),
      ),
    );
  }
}
```

### 4. Use Authentication

```dart
class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return CircularProgressIndicator();
        } else if (state is AuthAuthenticated) {
          return HomeScreen(user: state.user);
        } else {
          return LoginForm();
        }
      },
    );
  }
}

// Sign in with email/password
context.read<AuthBloc>().add(
  AuthSignInRequested(
    email: 'user@example.com',
    password: 'password123',
  ),
);

// Sign up with email/password
context.read<AuthBloc>().add(
  AuthSignUpRequested(
    email: 'user@example.com',
    password: 'password123',
  ),
);

// Social authentication
context.read<AuthBloc>().add(AuthGoogleSignInRequested());
context.read<AuthBloc>().add(AuthGitHubSignInRequested());
context.read<AuthBloc>().add(AuthAppleSignInRequested());

// Sign out
context.read<AuthBloc>().add(AuthSignOutRequested());
```

## Architecture

This package follows Clean Architecture principles with three main layers:

### Domain Layer
- **AuthUser** - User entity with conversion from Supabase User
- **AuthResult** - Result wrapper for authentication operations
- **AuthError** - Custom error types and messages
- **AuthUseCases** - Business logic for authentication operations

### Data Layer
- **AuthRepository** - Email/password authentication with Supabase
- **SocialAuthRepository** - Social authentication providers
- **EnvConfig** - Environment variable management

### Presentation Layer
- **AuthBloc** - BLoC for state management
- **AuthEvent** - Events for user actions
- **AuthState** - States representing authentication status

## Available Events

- `AuthCheckRequested()` - Check current authentication status
- `AuthSignUpRequested(email, password, metadata?)` - Sign up with email/password
- `AuthSignInRequested(email, password)` - Sign in with email/password
- `AuthSignOutRequested()` - Sign out current user
- `AuthGoogleSignInRequested()` - Sign in with Google
- `AuthGitHubSignInRequested()` - Sign in with GitHub
- `AuthAppleSignInRequested()` - Sign in with Apple
- `AuthPasswordResetRequested(email)` - Send password reset email
- `AuthPasswordUpdateRequested(newPassword)` - Update user password
- `AuthProfileUpdateRequested(email?, password?, metadata?)` - Update user profile
- `AuthAccountDeletionRequested()` - Delete user account
- `AuthSessionRefreshRequested()` - Refresh authentication session
- `AuthStateCleared()` - Clear current state

## Available States

- `AuthInitial()` - Initial state
- `AuthLoading()` - Loading state during operations
- `AuthAuthenticated(user)` - User is authenticated
- `AuthUnauthenticated(message?)` - User is not authenticated
- `AuthFailure(error)` - Authentication failed
- `AuthSuccess(message)` - Operation completed successfully
- `AuthSocialSignInInitiated(provider, message)` - Social sign in initiated

## Social Authentication

The package supports multiple social authentication providers:

- **Google** - Requires Google OAuth setup
- **GitHub** - Requires GitHub OAuth setup
- **Apple** - Requires Apple Sign In setup
- **Facebook** - Requires Facebook OAuth setup
- **Twitter** - Requires Twitter OAuth setup
- **Discord** - Requires Discord OAuth setup

### Setup Social Authentication

1. Configure OAuth providers in your Supabase dashboard
2. Add client IDs to your `.env` file
3. Use the corresponding events in your app

## Error Handling

The package provides comprehensive error handling with custom error types:

```dart
// Listen to errors
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthFailure) {
      // Handle error
      showErrorDialog(state.error.message);
    }
  },
  child: YourWidget(),
);
```

## Testing

The package includes comprehensive unit tests. Run tests with:

```bash
flutter test
```

## Example App

A complete example app is included in the `example/` directory. To run it:

1. Update the `.env` file with your Supabase credentials
2. Run the example:

```bash
cd example
flutter run
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions, please file an issue on the GitHub repository.

## Changelog

### 0.0.1
- Initial release
- Email/password authentication
- Social authentication (Google, GitHub, Apple, Facebook, Twitter, Discord)
- BLoC state management
- Environment configuration
- Comprehensive testing
- Example app