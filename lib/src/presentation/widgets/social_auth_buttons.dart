import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_bloc.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_event.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_state.dart';

/// A widget that displays social authentication buttons.
class SocialAuthButtons extends StatelessWidget {
  /// List of social providers to show buttons for.
  final List<SocialProvider> providers;
  
  /// Custom styling for the buttons.
  final SocialAuthButtonsStyle? style;

  const SocialAuthButtons({
    super.key,
    this.providers = const [
      SocialProvider.google,
      SocialProvider.github,
      SocialProvider.apple,
    ],
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? SocialAuthButtonsStyle.defaultStyle();
    
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            if (style.showDivider) ...[
              Row(
                children: [
                  Expanded(child: Divider(color: style.dividerColor)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: style.dividerSpacing ?? 16),
                    child: Text(
                      'Or sign in with:',
                      style: style.dividerTextStyle,
                    ),
                  ),
                  Expanded(child: Divider(color: style.dividerColor)),
                ],
              ),
              SizedBox(height: style.spacing ?? 16),
            ],
            
            Wrap(
              spacing: style.buttonSpacing ?? 8,
              runSpacing: style.buttonSpacing ?? 8,
              children: providers.map((provider) {
                return _buildSocialButton(
                  context,
                  provider,
                  state is AuthLoading,
                  style,
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    SocialProvider provider,
    bool isLoading,
    SocialAuthButtonsStyle style,
  ) {
    final buttonConfig = _getButtonConfig(provider, style);
    
    return SizedBox(
      width: style.buttonWidth,
      height: style.buttonHeight,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : () => _handleSocialAuth(context, provider),
        style: buttonConfig.buttonStyle,
        icon: buttonConfig.icon,
        label: Text(buttonConfig.label),
      ),
    );
  }

  void _handleSocialAuth(BuildContext context, SocialProvider provider) {
    switch (provider) {
      case SocialProvider.google:
        context.read<AuthBloc>().add(const AuthGoogleSignInRequested());
        break;
      case SocialProvider.github:
        context.read<AuthBloc>().add(const AuthGitHubSignInRequested());
        break;
      case SocialProvider.apple:
        context.read<AuthBloc>().add(const AuthAppleSignInRequested());
        break;
      case SocialProvider.facebook:
        context.read<AuthBloc>().add(AuthFacebookSignInRequested());
        break;
      case SocialProvider.twitter:
        context.read<AuthBloc>().add(AuthTwitterSignInRequested());
        break;
      case SocialProvider.discord:
        context.read<AuthBloc>().add(AuthDiscordSignInRequested());
        break;
    }
  }

  _ButtonConfig _getButtonConfig(SocialProvider provider, SocialAuthButtonsStyle style) {
    switch (provider) {
      case SocialProvider.google:
        return _ButtonConfig(
          icon: const Icon(Icons.login, color: Colors.white),
          label: 'Google',
          buttonStyle: style.googleButtonStyle ?? ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        );
      case SocialProvider.github:
        return _ButtonConfig(
          icon: const Icon(Icons.code, color: Colors.white),
          label: 'GitHub',
          buttonStyle: style.githubButtonStyle ?? ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        );
      case SocialProvider.apple:
        return _ButtonConfig(
          icon: const Icon(Icons.apple, color: Colors.white),
          label: 'Apple',
          buttonStyle: style.appleButtonStyle ?? ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        );
      case SocialProvider.facebook:
        return _ButtonConfig(
          icon: const Icon(Icons.facebook, color: Colors.white),
          label: 'Facebook',
          buttonStyle: style.facebookButtonStyle ?? ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[800],
            foregroundColor: Colors.white,
          ),
        );
      case SocialProvider.twitter:
        return _ButtonConfig(
          icon: const Icon(Icons.alternate_email, color: Colors.white),
          label: 'Twitter',
          buttonStyle: style.twitterButtonStyle ?? ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[400],
            foregroundColor: Colors.white,
          ),
        );
      case SocialProvider.discord:
        return _ButtonConfig(
          icon: const Icon(Icons.chat, color: Colors.white),
          label: 'Discord',
          buttonStyle: style.discordButtonStyle ?? ElevatedButton.styleFrom(
            backgroundColor: Colors.purple[600],
            foregroundColor: Colors.white,
          ),
        );
    }
  }
}

/// Available social authentication providers.
enum SocialProvider {
  google,
  github,
  apple,
  facebook,
  twitter,
  discord,
}

/// Styling options for the SocialAuthButtons widget.
class SocialAuthButtonsStyle {
  final bool showDivider;
  final double? dividerSpacing;
  final Color? dividerColor;
  final TextStyle? dividerTextStyle;
  final double? spacing;
  final double? buttonSpacing;
  final double? buttonWidth;
  final double? buttonHeight;
  final ButtonStyle? googleButtonStyle;
  final ButtonStyle? githubButtonStyle;
  final ButtonStyle? appleButtonStyle;
  final ButtonStyle? facebookButtonStyle;
  final ButtonStyle? twitterButtonStyle;
  final ButtonStyle? discordButtonStyle;

  const SocialAuthButtonsStyle({
    this.showDivider = true,
    this.dividerSpacing,
    this.dividerColor,
    this.dividerTextStyle,
    this.spacing,
    this.buttonSpacing,
    this.buttonWidth,
    this.buttonHeight,
    this.googleButtonStyle,
    this.githubButtonStyle,
    this.appleButtonStyle,
    this.facebookButtonStyle,
    this.twitterButtonStyle,
    this.discordButtonStyle,
  });

  factory SocialAuthButtonsStyle.defaultStyle() {
    return const SocialAuthButtonsStyle();
  }
}

class _ButtonConfig {
  final Widget icon;
  final String label;
  final ButtonStyle buttonStyle;

  _ButtonConfig({
    required this.icon,
    required this.label,
    required this.buttonStyle,
  });
}
