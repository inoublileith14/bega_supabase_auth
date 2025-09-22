import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bega_supabase_auth/src/data/social_auth_repository.dart';
import 'package:bega_supabase_auth/src/config/env_config.dart';

void main() {
  group('SocialAuthRepository', () {
    late SocialAuthRepository socialAuthRepository;

    setUpAll(() async {
      await EnvConfig.initialize();
    });

    setUp(() {
      socialAuthRepository = SocialAuthRepository();
    });

    test('should be instantiable', () {
      expect(socialAuthRepository, isNotNull);
    });

    group('Provider Configuration', () {
      test('should check if Google is configured', () {
        expect(socialAuthRepository.isProviderConfigured('google'), isA<bool>());
      });

      test('should check if GitHub is configured', () {
        expect(socialAuthRepository.isProviderConfigured('github'), isA<bool>());
      });

      test('should return available providers', () {
        final providers = socialAuthRepository.getAvailableProviders();
        expect(providers, isA<List<String>>());
        expect(providers, contains('apple'));
        expect(providers, contains('facebook'));
        expect(providers, contains('twitter'));
        expect(providers, contains('discord'));
      });
    });

    group('Exception Handling', () {
      test('should throw SocialAuthException for Google sign in errors', () async {
        expect(
          () => socialAuthRepository.signInWithGoogle(),
          throwsA(isA<SocialAuthException>()),
        );
      });

      test('should throw SocialAuthException for GitHub sign in errors', () async {
        expect(
          () => socialAuthRepository.signInWithGitHub(),
          throwsA(isA<SocialAuthException>()),
        );
      });

      test('should throw SocialAuthException for Apple sign in errors', () async {
        expect(
          () => socialAuthRepository.signInWithApple(),
          throwsA(isA<SocialAuthException>()),
        );
      });

      test('should throw SocialAuthException for Facebook sign in errors', () async {
        expect(
          () => socialAuthRepository.signInWithFacebook(),
          throwsA(isA<SocialAuthException>()),
        );
      });

      test('should throw SocialAuthException for Twitter sign in errors', () async {
        expect(
          () => socialAuthRepository.signInWithTwitter(),
          throwsA(isA<SocialAuthException>()),
        );
      });

      test('should throw SocialAuthException for Discord sign in errors', () async {
        expect(
          () => socialAuthRepository.signInWithDiscord(),
          throwsA(isA<SocialAuthException>()),
        );
      });

      test('should throw SocialAuthException for custom provider sign in errors', () async {
        expect(
          () => socialAuthRepository.signInWithProvider(
            OAuthProvider.google,
          ),
          throwsA(isA<SocialAuthException>()),
        );
      });
    });
  });
}