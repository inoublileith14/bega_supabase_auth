# Bega Supabase Auth

A comprehensive Flutter package that provides Supabase authentication with BLoC state management, environment configuration, and reusable widgets.

## Features

- 🔐 **Complete Authentication Flow**: Email/password and social authentication
- 🏗️ **BLoC State Management**: Clean architecture with reactive state management
- 🌍 **Environment Configuration**: Easy setup with `.env` files
- 🎨 **Reusable Widgets**: Pre-built authentication components
- 🔧 **Customizable**: Flexible styling and configuration options
- 📱 **Cross-Platform**: Works on iOS, Android, Web, and Desktop
- 🧪 **Well Tested**: Comprehensive test coverage

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

### 🚀 Super Simple (Recommended)

Just one widget call and you're done! Uses pure `supabase_auth_ui` components.

```dart
import 'package:flutter/material.dart';
import 'package:bega_supabase_auth/bega_supabase_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BegaSupabaseAuth(
      supabaseUrl: "https://your-project.supabase.co",
      supabaseAnonKey: "your-anon-key-here",
      appTitle: "My Awesome App",
    );
  }
}
```

**That's it!** 🎉 You get:
- Complete authentication UI using pure `supabase_auth_ui`
- Email/password login with `SupaEmailAuth`
- Social login (Google, GitHub, Apple) with `SupaSocialsAuth`
- User management
- Automatic state handling
- Beautiful Material Design UI
- **NEW**: Success/error callbacks for custom redirection
- No customization needed - just works!

### 🎯 Callback Support (NEW!)

The `BegaSupabaseAuth` widget now supports callbacks for custom handling of authentication events:

```dart
BegaSupabaseAuth(
  supabaseUrl: "https://your-project.supabase.co",
  supabaseAnonKey: "your-anon-key-here",
  appTitle: "My App",
  
  // Success callbacks
  onSignInSuccess: (user, message) {
    print('User signed in: ${user.email}');
    // Navigate to dashboard, update state, etc.
  },
  onSignUpSuccess: (user, message) {
    print('User signed up: ${user.email}');
    // Navigate to onboarding, send welcome email, etc.
  },
  onSocialAuthSuccess: (user, provider, message) {
    print('Social auth success: $provider - ${user.email}');
    // Handle different providers, link accounts, etc.
  },
  onSignOutSuccess: (message) {
    print('User signed out');
    // Clear data, navigate to login, etc.
  },
  
  // Error callbacks
  onAuthError: (error, message) {
    print('Auth error: $error');
    // Show error dialog, retry logic, etc.
  },
  onSocialAuthError: (error, provider, message) {
    print('Social auth error: $provider - $error');
    // Provider-specific error handling, fallback options, etc.
  },
)
```

**Perfect for:**
- Custom navigation after authentication
- State management integration
- Error handling and retry logic
- Analytics and logging
- User onboarding flows
- Provider-specific logic

### 🔧 Advanced Usage (Optional)

If you need more control, you can use the individual components:

#### 1. Environment Setup

Create a `.env` file in your project root:

```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
```

#### 2. Initialize the Package

```dart
import 'package:bega_supabase_auth/bega_supabase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await EnvConfig.load();
  
  // Initialize Supabase
  await BegaSupabaseConfig.initialize(
    supabaseUrl: EnvConfig.supabaseUrl,
    supabaseAnonKey: EnvConfig.supabaseAnonKey,
  );
  
  runApp(MyApp());
}
```

#### 3. Setup BLoC Provider

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bega_supabase_auth/bega_supabase_auth.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(),
            socialAuthRepository: SocialAuthRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        home: AuthWrapper(),
      ),
    );
  }
}
```

#### 4. Use Individual Widgets

```dart
// Simple authentication form
AuthForm()

// Social authentication buttons
SocialAuthButtons()

// Complete authentication screen
BegaAuthScreen()

// Custom authentication wrapper
BegaAuthWrapper(
  authenticatedWidget: HomeScreen(),
  unauthenticatedWidget: LoginScreen(),
)
```

## Architecture

This package follows Clean Architecture principles:

```
lib/
├── src/
│   ├── config/          # Environment configuration
│   ├── data/            # Data layer (repositories)
│   ├── domain/          # Domain layer (entities, use cases)
│   └── presentation/    # Presentation layer (BLoC, widgets)
└── bega_supabase_auth.dart
```

### Key Components

- **EnvConfig**: Environment variable management
- **AuthBloc**: BLoC for authentication state management
- **AuthRepository**: Data access for authentication
- **AuthUser**: Domain entity for user data
- **AuthForm**: Email/password authentication widget
- **SocialAuthButtons**: Social authentication widget

## Usage Examples

### Basic Authentication

```dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          AuthForm(),
          SizedBox(height: 20),
          SocialAuthButtons(),
        ],
      ),
    );
  }
}
```

### Custom Authentication Flow

```dart
class CustomAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return CircularProgressIndicator();
        } else if (state is AuthAuthenticated) {
          return HomeScreen(user: state.user);
        } else if (state is AuthFailure) {
          return ErrorWidget(message: state.error.message);
        } else {
          return LoginForm();
        }
      },
    );
  }
}
```

### Manual Authentication

```dart
// Sign up
context.read<AuthBloc>().add(
  AuthSignUpRequested(
    email: 'user@example.com',
    password: 'password123',
    metadata: {'username': 'johndoe'},
  ),
);

// Sign in
context.read<AuthBloc>().add(
  AuthSignInRequested(
    email: 'user@example.com',
    password: 'password123',
  ),
);

// Social sign in
context.read<AuthBloc>().add(AuthGoogleSignInRequested());

// Sign out
context.read<AuthBloc>().add(LogoutRequested());
```

## Configuration

### Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `SUPABASE_URL` | Your Supabase project URL | Yes |
| `SUPABASE_ANON_KEY` | Your Supabase anonymous key | Yes |
| `GOOGLE_CLIENT_ID` | Google OAuth client ID | No |
| `GITHUB_CLIENT_ID` | GitHub OAuth client ID | No |

### Widget Customization

```dart
AuthForm(
  metadataFields: [
    MetaDataField(
      prefixIcon: Icon(Icons.person),
      label: 'Username',
      key: 'username',
    ),
  ],
  style: AuthFormStyle(
    padding: EdgeInsets.all(20),
  ),
)

SocialAuthButtons(
  providers: [
    SocialProvider.google,
    SocialProvider.github,
    SocialProvider.apple,
  ],
  style: SocialAuthButtonsStyle(
    showDivider: true,
    padding: EdgeInsets.all(16),
  ),
)
```

## Testing

Run the test suite:

```bash
flutter test
```

The package includes comprehensive tests for:
- BLoC state management
- Repository implementations
- Widget functionality
- Error handling

## Example App

Check out the `example/` directory for a complete working example that demonstrates:
- Environment configuration
- BLoC setup
- Authentication flows
- Widget usage

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions, please:
1. Check the [Issues](https://github.com/your-username/bega_supabase_auth/issues) page
2. Create a new issue with detailed information
3. Join our community discussions

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes and version history.