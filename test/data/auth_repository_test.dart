import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bega_supabase_auth/src/data/auth_repository.dart';

void main() {
  group('AuthRepository', () {
    test('should be instantiable', () {
      final authRepository = AuthRepository();
      expect(authRepository, isNotNull);
    });

    group('Exception Handling', () {
      test('should throw BegaAuthException for sign up errors', () async {
        final authRepository = AuthRepository();
        expect(
          () => authRepository.signUp(
            email: 'test@example.com',
            password: 'password',
          ),
          throwsA(isA<BegaAuthException>()),
        );
      });

      test('should throw BegaAuthException for sign in errors', () async {
        final authRepository = AuthRepository();
        expect(
          () => authRepository.signInWithPassword(
            email: 'test@example.com',
            password: 'password',
          ),
          throwsA(isA<BegaAuthException>()),
        );
      });

      test('should throw BegaAuthException for OAuth sign in errors', () async {
        final authRepository = AuthRepository();
        expect(
          () => authRepository.signInWithOAuth(OAuthProvider.google),
          throwsA(isA<BegaAuthException>()),
        );
      });

      test('should throw BegaAuthException for sign out errors', () async {
        final authRepository = AuthRepository();
        expect(
          () => authRepository.signOut(),
          throwsA(isA<BegaAuthException>()),
        );
      });

      test(
        'should throw BegaAuthException for password reset errors',
        () async {
          final authRepository = AuthRepository();
          expect(
            () => authRepository.resetPassword('test@example.com'),
            throwsA(isA<BegaAuthException>()),
          );
        },
      );

      test(
        'should throw BegaAuthException for password update errors',
        () async {
          final authRepository = AuthRepository();
          expect(
            () => authRepository.updatePassword('newpassword'),
            throwsA(isA<BegaAuthException>()),
          );
        },
      );

      test('should throw BegaAuthException for user update errors', () async {
        final authRepository = AuthRepository();
        expect(
          () => authRepository.updateUser(email: 'new@example.com'),
          throwsA(isA<BegaAuthException>()),
        );
      });

      test('should throw BegaAuthException for user deletion errors', () async {
        final authRepository = AuthRepository();
        expect(
          () => authRepository.deleteUser(),
          throwsA(isA<BegaAuthException>()),
        );
      });

      test(
        'should throw BegaAuthException for session refresh errors',
        () async {
          final authRepository = AuthRepository();
          expect(
            () => authRepository.refreshSession(),
            throwsA(isA<BegaAuthException>()),
          );
        },
      );
    });
  });
}
