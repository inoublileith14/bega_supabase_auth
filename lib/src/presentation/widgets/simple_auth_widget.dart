import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../config/bega_supabase_config.dart';

/// Super simple authentication widget - just pass your keys and get everything!
class BegaSupabaseAuth extends StatefulWidget {
  /// Your Supabase project URL
  final String supabaseUrl;
  
  /// Your Supabase anonymous key
  final String supabaseAnonKey;
  
  /// Optional redirect URL for authentication callbacks
  final String? redirectUrl;
  
  /// Optional app title
  final String? appTitle;
  
  /// Optional theme
  final ThemeData? theme;

  /// Callback for successful sign in
  final void Function(User user, String? message)? onSignInSuccess;
  
  /// Callback for successful sign up
  final void Function(User user, String? message)? onSignUpSuccess;
  
  /// Callback for authentication errors
  final void Function(String error, String? message)? onAuthError;
  
  /// Callback for successful sign out
  final void Function(String? message)? onSignOutSuccess;
  
  /// Callback for social authentication success
  final void Function(User user, String provider, String? message)? onSocialAuthSuccess;
  
  /// Callback for social authentication errors
  final void Function(String error, String provider, String? message)? onSocialAuthError;

  const BegaSupabaseAuth({
    super.key,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    this.redirectUrl,
    this.appTitle,
    this.theme,
    this.onSignInSuccess,
    this.onSignUpSuccess,
    this.onAuthError,
    this.onSignOutSuccess,
    this.onSocialAuthSuccess,
    this.onSocialAuthError,
  });

  @override
  State<BegaSupabaseAuth> createState() => _BegaSupabaseAuthState();
}

class _BegaSupabaseAuthState extends State<BegaSupabaseAuth> {
  bool _isInitialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      print('🔧 Initializing BegaSupabaseAuth...');
      print('📍 Supabase URL: ${widget.supabaseUrl}');
      print('📍 Supabase Key: ${widget.supabaseAnonKey.substring(0, 10)}...');
      print('🌐 Redirect URL: ${widget.redirectUrl ?? 'Using Supabase callback'}');
      print('⚠️  IMPORTANT: Check Supabase Site URL is set to: https://Hit.Alerts.com');
      print('⚠️  NOT to: https://admin.hitalerts.com/');
      print('🔗 OAuth Flow: OAuth → Supabase → Your App');
      print('📱 Google OAuth: Use https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback');
      print('🌐 Supabase Redirects: Configure in Supabase Dashboard → Authentication → URL Configuration');
      
      // Initialize Supabase
      await BegaSupabaseConfig.initialize(
        supabaseUrl: widget.supabaseUrl,
        supabaseAnonKey: widget.supabaseAnonKey,
      );
      
      // Test connection
      await _testConnection();
      
      setState(() {
        _isInitialized = true;
      });
      
      print('✅ BegaSupabaseAuth initialized successfully!');
    } catch (e) {
      print('❌ Error initializing BegaSupabaseAuth: $e');
      setState(() {
        _error = e.toString();
      });
    }
  }

  Future<void> _testConnection() async {
    try {
      print('🔍 Testing Supabase connection...');
      
      // Test basic connection
      final client = BegaSupabaseConfig.client;
      print('✅ Supabase client created successfully');
      
      // Test auth service
      final auth = client.auth;
      print('✅ Auth service accessible');
      
      // Test current session
      final session = auth.currentSession;
      print('📊 Current session: ${session != null ? 'Active' : 'None'}');
      
      // Test auth state listener
      auth.onAuthStateChange.listen((data) {
        print('🔄 Auth state changed: ${data.event}');
        if (data.session?.user != null) {
          print('👤 User: ${data.session!.user!.email}');
        }
      });
      
      print('✅ Connection test passed!');
    } catch (e) {
      print('❌ Connection test failed: $e');
      throw Exception('Failed to connect to Supabase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return _ErrorScreen(error: _error!);
    }

    if (!_isInitialized) {
      return _LoadingScreen();
    }

    return MaterialApp(
      title: widget.appTitle ?? 'Bega Supabase Auth',
      theme: widget.theme ?? ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: _AuthScreen(
        redirectUrl: widget.redirectUrl,
        onSignInSuccess: widget.onSignInSuccess,
        onSignUpSuccess: widget.onSignUpSuccess,
        onAuthError: widget.onAuthError,
        onSignOutSuccess: widget.onSignOutSuccess,
        onSocialAuthSuccess: widget.onSocialAuthSuccess,
        onSocialAuthError: widget.onSocialAuthError,
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Initializing authentication...',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  final String error;

  const _ErrorScreen({required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Configuration Error'),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Authentication Setup Error',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                error,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To fix this:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('1. Check your Supabase URL and key'),
                      Text('2. Make sure your Supabase project is active'),
                      Text('3. Verify your internet connection'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthScreen extends StatefulWidget {
  final String? redirectUrl;
  final void Function(User user, String? message)? onSignInSuccess;
  final void Function(User user, String? message)? onSignUpSuccess;
  final void Function(String error, String? message)? onAuthError;
  final void Function(String? message)? onSignOutSuccess;
  final void Function(User user, String provider, String? message)? onSocialAuthSuccess;
  final void Function(String error, String provider, String? message)? onSocialAuthError;

  const _AuthScreen({
    this.redirectUrl,
    this.onSignInSuccess,
    this.onSignUpSuccess,
    this.onAuthError,
    this.onSignOutSuccess,
    this.onSocialAuthSuccess,
    this.onSocialAuthError,
  });

  @override
  State<_AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<_AuthScreen> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    // Listen to auth state changes
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      print('🔄 Auth state changed: ${data.event}');
      if (data.session?.user != null) {
        print('👤 User logged in: ${data.session!.user!.email}');
        // Call success callback if provided
        if (widget.onSignInSuccess != null) {
          widget.onSignInSuccess!(data.session!.user!, 'User signed in successfully');
        }
      } else if (data.event == AuthChangeEvent.signedOut) {
        // Call sign out callback if provided
        if (widget.onSignOutSuccess != null) {
          widget.onSignOutSuccess!('User signed out successfully');
        }
      }
      setState(() {
        _currentUser = data.session?.user;
      });
    });
  }

  void _getCurrentUser() {
    setState(() {
      _currentUser = Supabase.instance.client.auth.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    // If user is authenticated, show home screen
    if (_currentUser != null) {
      return _HomeScreen(
        user: _currentUser!,
        onSignOutSuccess: widget.onSignOutSuccess,
      );
    }

    // Otherwise show pure supabase_auth_ui components
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // DIRECT SupaEmailAuth - NO package wrappers
            SupaEmailAuth(
              redirectTo: widget.redirectUrl ?? 'https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback',
              onSignInComplete: (response) {
                print('✅ Email sign in successful: ${response.user?.email}');
                print('📊 User ID: ${response.user?.id}');
                print('📊 Session: ${response.session != null ? 'Active' : 'None'}');
                
                if (response.user != null && widget.onSignInSuccess != null) {
                  widget.onSignInSuccess!(response.user!, 'Email sign in successful');
                }
              },
              onSignUpComplete: (response) {
                print('✅ Email sign up successful: ${response.user?.email}');
                print('📊 User ID: ${response.user?.id}');
                print('📊 Session: ${response.session != null ? 'Active' : 'None'}');
                
                if (response.user != null && widget.onSignUpSuccess != null) {
                  widget.onSignUpSuccess!(response.user!, 'Email sign up successful');
                }
              },
              metadataFields: [
                MetaDataField(
                  prefixIcon: const Icon(Icons.person),
                  label: 'Username',
                  key: 'username',
                ),
              ],
            ),

            const SizedBox(height: 30),

            // DIRECT SupaSocialsAuth - NO package wrappers
            SupaSocialsAuth(
              socialProviders: [
                OAuthProvider.google,
                OAuthProvider.github,
                OAuthProvider.apple,
                OAuthProvider.facebook,
              ],
              colored: true,
              redirectUrl: widget.redirectUrl ?? 'https://cgyutifkgihvrqbaodps.supabase.co/auth/v1/callback',
              onSuccess: (session) {
                print('✅ Social auth successful!');
                print('👤 User: ${session.user.email}');
                print('🔑 Session: ${session.accessToken.substring(0, 20)}...');
                print('📊 User metadata: ${session.user.userMetadata}');
                print('🎉 User should now see the home screen!');
                
                // Call social auth success callback if provided
                if (widget.onSocialAuthSuccess != null) {
                  // Determine provider from user metadata or session
                  String provider = 'Unknown';
                  if (session.user.appMetadata?['provider'] != null) {
                    provider = session.user.appMetadata!['provider'];
                  } else if (session.user.userMetadata?['provider'] != null) {
                    provider = session.user.userMetadata!['provider'];
                  }
                  widget.onSocialAuthSuccess!(session.user, provider, 'Social authentication successful');
                }
              },
              onError: (error) {
                print('❌ Social auth error: $error');
                print('🔍 Error type: ${error.runtimeType}');
                
                // Call social auth error callback if provided
                if (widget.onSocialAuthError != null) {
                  widget.onSocialAuthError!(error.toString(), 'Unknown', 'Social authentication failed');
                }
                
                // Also call general auth error callback if provided
                if (widget.onAuthError != null) {
                  widget.onAuthError!(error.toString(), 'Social authentication failed');
                }
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Social auth error: $error'),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 5),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  final User user;
  final void Function(String? message)? onSignOutSuccess;

  const _HomeScreen({required this.user, this.onSignOutSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              if (onSignOutSuccess != null) {
                onSignOutSuccess!('User signed out successfully');
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome, ${user.email}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'You are successfully authenticated.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (user.userMetadata?['username'] != null) ...[
              const SizedBox(height: 8),
              Text(
                'Username: ${user.userMetadata?['username']}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();
                if (onSignOutSuccess != null) {
                  onSignOutSuccess!('User signed out successfully');
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
