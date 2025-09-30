import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bega_supabase_auth/src/domain/use_cases/auth_use_cases.dart';
import 'package:bega_supabase_auth/src/domain/auth_result.dart';
import 'package:bega_supabase_auth/src/data/auth_repository.dart';
import 'package:bega_supabase_auth/src/data/social_auth_repository.dart';

// Mock classes
class MockAuthRepository extends Mock implements AuthRepository {}

class MockSocialAuthRepository extends Mock implements SocialAuthRepository {}

class MockUser extends Mock implements User {}

class MockAuthResponse extends Mock implements AuthResponse {}

class MockUserResponse extends Mock implements UserResponse {}

void main() {
  group('AuthUseCases', () {
    late MockAuthRepository mockAuthRepository;
    late MockSocialAuthRepository mockSocialAuthRepository;
    late AuthUseCases authUseCases;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      mockSocialAuthRepository = MockSocialAuthRepository();
      authUseCases = AuthUseCases(
        authRepository: mockAuthRepository,
        socialAuthRepository: mockSocialAuthRepository,
      );
    });

    group('Sign Up', () {
      test('should return success when sign up is successful', () async {
        // Arrange
        final mockUser = MockUser();
        when(() => mockUser.id).thenReturn('test-id');
        when(() => mockUser.email).thenReturn('test@example.com');
        when(() => mockUser.createdAt).thenReturn('2023-01-01T00:00:00Z');
        when(() => mockUser.userMetadata).thenReturn({});

        final mockResponse = MockAuthResponse();
        when(() => mockResponse.user).thenReturn(mockUser);

        when(
          () => mockAuthRepository.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            data: any(named: 'data'),
          ),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await authUseCases.signUp(
          email: 'test@example.com',
          password: 'password123',
        );

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.user, isNotNull);
        expect(result.user!.email, equals('test@example.com'));
        expect(result.message, contains('Account created successfully'));
      });

      test('should return failure when sign up fails', () async {
        // Arrange
        when(
          () => mockAuthRepository.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            data: any(named: 'data'),
          ),
        ).thenThrow(Exception('Sign up failed'));

        // Act
        final result = await authUseCases.signUp(
          email: 'test@example.com',
          password: 'password123',
        );

        // Assert
        expect(result.isSuccess, isFalse);
        expect(result.error, isNotNull);
        expect(result.error!.type, equals(AuthErrorType.unknown));
      });
    });

    group('Sign In with Password', () {
      test('should return success when sign in is successful', () async {
        // Arrange
        final mockUser = MockUser();
        when(() => mockUser.id).thenReturn('test-id');
        when(() => mockUser.email).thenReturn('test@example.com');
        when(() => mockUser.createdAt).thenReturn('2023-01-01T00:00:00Z');
        when(() => mockUser.userMetadata).thenReturn({});

        final mockResponse = MockAuthResponse();
        when(() => mockResponse.user).thenReturn(mockUser);

        when(
          () => mockAuthRepository.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await authUseCases.signInWithPassword(
          email: 'test@example.com',
          password: 'password123',
        );

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.user, isNotNull);
        expect(result.user!.email, equals('test@example.com'));
        expect(result.message, equals('Signed in successfully'));
      });

      test('should return failure when sign in fails', () async {
        // Arrange
        when(
          () => mockAuthRepository.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception('Invalid credentials'));

        // Act
        final result = await authUseCases.signInWithPassword(
          email: 'test@example.com',
          password: 'wrongpassword',
        );

        // Assert
        expect(result.isSuccess, isFalse);
        expect(result.error, isNotNull);
      });
    });

    group('Social Sign In', () {
      test('should return success when Google sign in is initiated', () async {
        // Arrange
        when(
          () => mockSocialAuthRepository.signInWithGoogle(),
        ).thenAnswer((_) async => true);

        // Act
        final result = await authUseCases.signInWithGoogle();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.message, equals('Google sign in initiated'));
      });

      test('should return success when GitHub sign in is initiated', () async {
        // Arrange
        when(
          () => mockSocialAuthRepository.signInWithGitHub(),
        ).thenAnswer((_) async => true);

        // Act
        final result = await authUseCases.signInWithGitHub();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.message, equals('GitHub sign in initiated'));
      });

      test('should return success when Apple sign in is initiated', () async {
        // Arrange
        when(
          () => mockSocialAuthRepository.signInWithApple(),
        ).thenAnswer((_) async => true);

        // Act
        final result = await authUseCases.signInWithApple();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.message, equals('Apple sign in initiated'));
      });

      test('should return failure when social sign in fails', () async {
        // Arrange
        when(
          () => mockSocialAuthRepository.signInWithGoogle(),
        ).thenThrow(Exception('Social sign in failed'));

        // Act
        final result = await authUseCases.signInWithGoogle();

        // Assert
        expect(result.isSuccess, isFalse);
        expect(result.error, isNotNull);
      });
    });

    group('Sign Out', () {
      test('should return success when sign out is successful', () async {
        // Arrange
        when(() => mockAuthRepository.signOut()).thenAnswer((_) async {});

        // Act
        final result = await authUseCases.signOut();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.message, equals('Signed out successfully'));
      });

      test('should return failure when sign out fails', () async {
        // Arrange
        when(
          () => mockAuthRepository.signOut(),
        ).thenThrow(Exception('Sign out failed'));

        // Act
        final result = await authUseCases.signOut();

        // Assert
        expect(result.isSuccess, isFalse);
        expect(result.error, isNotNull);
      });
    });

    group('Password Management', () {
      test('should return success when password reset is successful', () async {
        // Arrange
        when(
          () => mockAuthRepository.resetPassword(any()),
        ).thenAnswer((_) async {});

        // Act
        final result = await authUseCases.resetPassword('test@example.com');

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.message, contains('Password reset email sent'));
      });

      test(
        'should return success when password update is successful',
        () async {
          // Arrange
          final mockUser = MockUser();
          when(() => mockUser.id).thenReturn('test-id');
          when(() => mockUser.email).thenReturn('test@example.com');
          when(() => mockUser.createdAt).thenReturn('2023-01-01T00:00:00Z');
          when(() => mockUser.userMetadata).thenReturn({});

          final mockResponse = MockUserResponse();
          when(() => mockResponse.user).thenReturn(mockUser);

          when(
            () => mockAuthRepository.updatePassword(any()),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final result = await authUseCases.updatePassword('newpassword');

          // Assert
          expect(result.isSuccess, isTrue);
          expect(result.user, isNotNull);
          expect(result.message, equals('Password updated successfully'));
        },
      );
    });

    group('Profile Management', () {
      test('should return success when profile update is successful', () async {
        // Arrange
        final mockUser = MockUser();
        when(() => mockUser.id).thenReturn('test-id');
        when(() => mockUser.email).thenReturn('new@example.com');
        when(() => mockUser.createdAt).thenReturn('2023-01-01T00:00:00Z');
        when(() => mockUser.userMetadata).thenReturn({});

        final mockResponse = MockUserResponse();
        when(() => mockResponse.user).thenReturn(mockUser);

        when(
          () => mockAuthRepository.updateUser(
            email: any(named: 'email'),
            password: any(named: 'password'),
            data: any(named: 'data'),
          ),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await authUseCases.updateProfile(
          email: 'new@example.com',
        );

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.user, isNotNull);
        expect(result.user!.email, equals('new@example.com'));
        expect(result.message, equals('Profile updated successfully'));
      });

      test(
        'should return success when account deletion is successful',
        () async {
          // Arrange
          when(() => mockAuthRepository.deleteUser()).thenAnswer((_) async {});

          // Act
          final result = await authUseCases.deleteAccount();

          // Assert
          expect(result.isSuccess, isTrue);
          expect(result.message, equals('Account deleted successfully'));
        },
      );
    });

    group('Session Management', () {
      test(
        'should return success when session refresh is successful',
        () async {
          // Arrange
          final mockUser = MockUser();
          when(() => mockUser.id).thenReturn('test-id');
          when(() => mockUser.email).thenReturn('test@example.com');
          when(() => mockUser.createdAt).thenReturn('2023-01-01T00:00:00Z');
          when(() => mockUser.userMetadata).thenReturn({});

          final mockResponse = MockAuthResponse();
          when(() => mockResponse.user).thenReturn(mockUser);

          when(
            () => mockAuthRepository.refreshSession(),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final result = await authUseCases.refreshSession();

          // Assert
          expect(result.isSuccess, isTrue);
          expect(result.user, isNotNull);
          expect(result.message, equals('Session refreshed successfully'));
        },
      );
    });

    group('Current User', () {
      test('should return current user when authenticated', () {
        // Arrange
        final mockUser = MockUser();
        when(() => mockUser.id).thenReturn('test-id');
        when(() => mockUser.email).thenReturn('test@example.com');
        when(() => mockUser.createdAt).thenReturn('2023-01-01T00:00:00Z');
        when(() => mockUser.userMetadata).thenReturn({});

        when(() => mockAuthRepository.currentUser).thenReturn(mockUser);

        // Act
        final user = authUseCases.getCurrentUser();

        // Assert
        expect(user, isNotNull);
        expect(user!.email, equals('test@example.com'));
      });

      test('should return null when not authenticated', () {
        // Arrange
        when(() => mockAuthRepository.currentUser).thenReturn(null);

        // Act
        final user = authUseCases.getCurrentUser();

        // Assert
        expect(user, isNull);
      });

      test('should return authentication status', () {
        // Arrange
        when(() => mockAuthRepository.isAuthenticated).thenReturn(true);

        // Act
        final isAuth = authUseCases.isAuthenticated();

        // Assert
        expect(isAuth, isTrue);
      });
    });
  });
}
