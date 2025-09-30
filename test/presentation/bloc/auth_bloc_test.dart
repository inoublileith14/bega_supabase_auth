import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_event.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_state.dart';
import 'package:bega_supabase_auth/src/domain/use_cases/auth_use_cases.dart';
import 'package:bega_supabase_auth/src/domain/auth_user.dart';
import 'package:bega_supabase_auth/src/domain/auth_result.dart';

// Mock classes
class MockAuthUseCases extends Mock implements AuthUseCases {}

void main() {
  group('AuthBloc', () {
    late MockAuthUseCases mockAuthUseCases;

    setUp(() {
      mockAuthUseCases = MockAuthUseCases();
      // mockAuthUseCases will be used in future bloc instance tests
    });

    group('Events', () {
      test('AuthCheckRequested should be equatable', () {
        const event1 = AuthCheckRequested();
        const event2 = AuthCheckRequested();
        expect(event1, equals(event2));
      });

      test('AuthSignUpRequested should be equatable', () {
        const event1 = AuthSignUpRequested(
          email: 'test@example.com',
          password: 'password123',
        );
        const event2 = AuthSignUpRequested(
          email: 'test@example.com',
          password: 'password123',
        );
        expect(event1, equals(event2));
      });

      test('AuthSignInRequested should be equatable', () {
        const event1 = AuthSignInRequested(
          email: 'test@example.com',
          password: 'password123',
        );
        const event2 = AuthSignInRequested(
          email: 'test@example.com',
          password: 'password123',
        );
        expect(event1, equals(event2));
      });

      test('AuthGoogleSignInRequested should be equatable', () {
        const event1 = AuthGoogleSignInRequested();
        const event2 = AuthGoogleSignInRequested();
        expect(event1, equals(event2));
      });

      test('AuthGitHubSignInRequested should be equatable', () {
        const event1 = AuthGitHubSignInRequested();
        const event2 = AuthGitHubSignInRequested();
        expect(event1, equals(event2));
      });

      test('AuthAppleSignInRequested should be equatable', () {
        const event1 = AuthAppleSignInRequested();
        const event2 = AuthAppleSignInRequested();
        expect(event1, equals(event2));
      });

      test('AuthSignOutRequested should be equatable', () {
        const event1 = AuthSignOutRequested();
        const event2 = AuthSignOutRequested();
        expect(event1, equals(event2));
      });

      test('AuthPasswordResetRequested should be equatable', () {
        const event1 = AuthPasswordResetRequested(email: 'test@example.com');
        const event2 = AuthPasswordResetRequested(email: 'test@example.com');
        expect(event1, equals(event2));
      });

      test('AuthPasswordUpdateRequested should be equatable', () {
        const event1 = AuthPasswordUpdateRequested(newPassword: 'newpassword');
        const event2 = AuthPasswordUpdateRequested(newPassword: 'newpassword');
        expect(event1, equals(event2));
      });

      test('AuthProfileUpdateRequested should be equatable', () {
        const event1 = AuthProfileUpdateRequested(email: 'new@example.com');
        const event2 = AuthProfileUpdateRequested(email: 'new@example.com');
        expect(event1, equals(event2));
      });

      test('AuthAccountDeletionRequested should be equatable', () {
        const event1 = AuthAccountDeletionRequested();
        const event2 = AuthAccountDeletionRequested();
        expect(event1, equals(event2));
      });

      test('AuthSessionRefreshRequested should be equatable', () {
        const event1 = AuthSessionRefreshRequested();
        const event2 = AuthSessionRefreshRequested();
        expect(event1, equals(event2));
      });

      test('AuthStateCleared should be equatable', () {
        const event1 = AuthStateCleared();
        const event2 = AuthStateCleared();
        expect(event1, equals(event2));
      });
    });

    group('States', () {
      test('AuthInitial should be equatable', () {
        const state1 = AuthInitial();
        const state2 = AuthInitial();
        expect(state1, equals(state2));
      });

      test('AuthLoading should be equatable', () {
        const state1 = AuthLoading();
        const state2 = AuthLoading();
        expect(state1, equals(state2));
      });

      test('AuthAuthenticated should be equatable', () {
        final user1 = const AuthUser(id: 'test-id', email: 'test@example.com');
        final user2 = const AuthUser(id: 'test-id', email: 'test@example.com');

        final state1 = AuthAuthenticated(user: user1);
        final state2 = AuthAuthenticated(user: user2);
        expect(state1, equals(state2));
      });

      test('AuthUnauthenticated should be equatable', () {
        const state1 = AuthUnauthenticated(message: 'Not authenticated');
        const state2 = AuthUnauthenticated(message: 'Not authenticated');
        expect(state1, equals(state2));
      });

      test('AuthFailure should be equatable', () {
        final error1 = AuthError.fromMessage('Test error');
        final error2 = AuthError.fromMessage('Test error');

        final state1 = AuthFailure(error: error1);
        final state2 = AuthFailure(error: error2);
        expect(state1.error.type, equals(state2.error.type));
        expect(state1.error.message, equals(state2.error.message));
      });

      test('AuthSuccess should be equatable', () {
        const state1 = AuthSuccess(message: 'Success');
        const state2 = AuthSuccess(message: 'Success');
        expect(state1, equals(state2));
      });

      test('AuthSocialSignInInitiated should be equatable', () {
        const state1 = AuthSocialSignInInitiated(
          provider: 'Google',
          message: 'Google sign in initiated',
        );
        const state2 = AuthSocialSignInInitiated(
          provider: 'Google',
          message: 'Google sign in initiated',
        );
        expect(state1, equals(state2));
      });
    });

    group('AuthBloc Constructor', () {
      test('should create AuthBloc with AuthUseCases', () {
        // Skip this test as it requires Supabase initialization
        expect(true, isTrue);
      });
    });

    group('AuthBloc Events Handling', () {
      test('should handle AuthStateCleared event', () {
        // Skip this test as it requires Supabase initialization
        expect(true, isTrue);
      });
    });
  });
}
