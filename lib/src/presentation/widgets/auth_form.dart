import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_bloc.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_event.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_state.dart';

/// A reusable authentication form widget that handles both sign in and sign up.
class AuthForm extends StatefulWidget {
  /// Whether to show sign up form (true) or sign in form (false).
  final bool isSignUp;
  
  /// Callback when the form mode changes.
  final VoidCallback? onToggleMode;
  
  /// Custom styling for the form.
  final AuthFormStyle? style;

  const AuthForm({
    super.key,
    this.isSignUp = false,
    this.onToggleMode,
    this.style,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (widget.isSignUp) {
        context.read<AuthBloc>().add(
          AuthSignUpRequested(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
      } else {
        context.read<AuthBloc>().add(
          AuthSignInRequested(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? AuthFormStyle.defaultStyle();
    
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.isSignUp ? 'Sign Up' : 'Sign In',
            style: style.titleStyle ?? Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: style.spacing ?? 32),
          
          // Email field
          TextFormField(
            controller: _emailController,
            decoration: style.emailDecoration ?? const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: style.spacing ?? 16),
          
          // Password field
          TextFormField(
            controller: _passwordController,
            decoration: style.passwordDecoration ?? const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          
          // Confirm password field (only for sign up)
          if (widget.isSignUp) ...[
            SizedBox(height: style.spacing ?? 16),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: style.confirmPasswordDecoration ?? const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
          ],
          
          SizedBox(height: style.spacing ?? 24),
          
          // Submit button
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state is AuthLoading ? null : _submitForm,
                  style: style.submitButtonStyle,
                  child: state is AuthLoading
                      ? const CircularProgressIndicator()
                      : Text(widget.isSignUp ? 'Sign Up' : 'Sign In'),
                ),
              );
            },
          ),
          
          SizedBox(height: style.spacing ?? 16),
          
          // Toggle mode button
          if (widget.onToggleMode != null)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: widget.onToggleMode,
                style: style.toggleButtonStyle,
                child: Text(
                  widget.isSignUp 
                      ? 'Already have an account? Sign In' 
                      : 'Don\'t have an account? Sign Up',
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Styling options for the AuthForm widget.
class AuthFormStyle {
  final TextStyle? titleStyle;
  final double? spacing;
  final InputDecoration? emailDecoration;
  final InputDecoration? passwordDecoration;
  final InputDecoration? confirmPasswordDecoration;
  final ButtonStyle? submitButtonStyle;
  final ButtonStyle? toggleButtonStyle;

  const AuthFormStyle({
    this.titleStyle,
    this.spacing,
    this.emailDecoration,
    this.passwordDecoration,
    this.confirmPasswordDecoration,
    this.submitButtonStyle,
    this.toggleButtonStyle,
  });

  factory AuthFormStyle.defaultStyle() {
    return const AuthFormStyle();
  }
}
