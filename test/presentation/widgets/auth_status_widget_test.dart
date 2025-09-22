import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bega_supabase_auth/src/presentation/widgets/auth_status_widget.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_bloc.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_state.dart';
import 'package:bega_supabase_auth/src/domain/auth_user.dart';
import 'package:bega_supabase_auth/src/domain/auth_result.dart';
import 'package:bega_supabase_auth/src/domain/use_cases/auth_use_cases.dart';

// Mock classes
class MockAuthBloc extends Mock implements AuthBloc {}
class MockAuthUseCases extends Mock implements AuthUseCases {}

void main() {
  group('AuthStatusWidget', () {
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
      when(() => mockAuthBloc.stream).thenAnswer((_) => Stream.value(const AuthInitial()));
    });

    Widget createWidgetUnderTest({
      required Widget authenticatedWidget,
      required Widget unauthenticatedWidget,
      Widget? loadingWidget,
      Widget? errorWidget,
      void Function(AuthState state)? onStateChanged,
    }) {
      return MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: AuthStatusWidget(
            authenticatedWidget: authenticatedWidget,
            unauthenticatedWidget: unauthenticatedWidget,
            loadingWidget: loadingWidget,
            errorWidget: errorWidget,
            onStateChanged: onStateChanged,
          ),
        ),
      );
    }

    testWidgets('shows authenticated widget when state is AuthAuthenticated', (WidgetTester tester) async {
      const user = AuthUser(id: 'test-id', email: 'test@example.com');
      when(() => mockAuthBloc.state).thenReturn(const AuthAuthenticated(user: user));

      const authenticatedWidget = Text('Authenticated');
      const unauthenticatedWidget = Text('Not Authenticated');

      await tester.pumpWidget(createWidgetUnderTest(
        authenticatedWidget: authenticatedWidget,
        unauthenticatedWidget: unauthenticatedWidget,
      ));

      expect(find.text('Authenticated'), findsOneWidget);
      expect(find.text('Not Authenticated'), findsNothing);
    });

    testWidgets('shows unauthenticated widget when state is AuthUnauthenticated', (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthUnauthenticated());

      const authenticatedWidget = Text('Authenticated');
      const unauthenticatedWidget = Text('Not Authenticated');

      await tester.pumpWidget(createWidgetUnderTest(
        authenticatedWidget: authenticatedWidget,
        unauthenticatedWidget: unauthenticatedWidget,
      ));

      expect(find.text('Not Authenticated'), findsOneWidget);
      expect(find.text('Authenticated'), findsNothing);
    });

    testWidgets('shows loading widget when state is AuthLoading', (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthLoading());

      const authenticatedWidget = Text('Authenticated');
      const unauthenticatedWidget = Text('Not Authenticated');
      const loadingWidget = Text('Loading...');

      await tester.pumpWidget(createWidgetUnderTest(
        authenticatedWidget: authenticatedWidget,
        unauthenticatedWidget: unauthenticatedWidget,
        loadingWidget: loadingWidget,
      ));

      expect(find.text('Loading...'), findsOneWidget);
      expect(find.text('Authenticated'), findsNothing);
      expect(find.text('Not Authenticated'), findsNothing);
    });

    testWidgets('shows default loading widget when state is AuthLoading and no custom loading widget provided', (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthLoading());

      const authenticatedWidget = Text('Authenticated');
      const unauthenticatedWidget = Text('Not Authenticated');

      await tester.pumpWidget(createWidgetUnderTest(
        authenticatedWidget: authenticatedWidget,
        unauthenticatedWidget: unauthenticatedWidget,
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error widget when state is AuthFailure', (WidgetTester tester) async {
      final error = AuthError.fromMessage('Test error');
      when(() => mockAuthBloc.state).thenReturn(AuthFailure(error: error));

      const authenticatedWidget = Text('Authenticated');
      const unauthenticatedWidget = Text('Not Authenticated');
      const errorWidget = Text('Error occurred');

      await tester.pumpWidget(createWidgetUnderTest(
        authenticatedWidget: authenticatedWidget,
        unauthenticatedWidget: unauthenticatedWidget,
        errorWidget: errorWidget,
      ));

      expect(find.text('Error occurred'), findsOneWidget);
      expect(find.text('Authenticated'), findsNothing);
      expect(find.text('Not Authenticated'), findsNothing);
    });

    testWidgets('shows default error widget when state is AuthFailure and no custom error widget provided', (WidgetTester tester) async {
      final error = AuthError.fromMessage('Test error');
      when(() => mockAuthBloc.state).thenReturn(AuthFailure(error: error));

      const authenticatedWidget = Text('Authenticated');
      const unauthenticatedWidget = Text('Not Authenticated');

      await tester.pumpWidget(createWidgetUnderTest(
        authenticatedWidget: authenticatedWidget,
        unauthenticatedWidget: unauthenticatedWidget,
      ));

      expect(find.text('An error occurred: Test error'), findsOneWidget);
    });

    testWidgets('calls onStateChanged when state changes', (WidgetTester tester) async {
      AuthState? capturedState;
      void onStateChanged(AuthState state) {
        capturedState = state;
      }

      when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

      const authenticatedWidget = Text('Authenticated');
      const unauthenticatedWidget = Text('Not Authenticated');

      await tester.pumpWidget(createWidgetUnderTest(
        authenticatedWidget: authenticatedWidget,
        unauthenticatedWidget: unauthenticatedWidget,
        onStateChanged: onStateChanged,
      ));

      expect(capturedState, isA<AuthInitial>());
    });
  });

  group('AuthLoadingWidget', () {
    testWidgets('displays loading indicator with message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthLoadingWidget(message: 'Loading...'),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('displays loading indicator without message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthLoadingWidget(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('AuthErrorWidget', () {
    testWidgets('displays error message with retry button', (WidgetTester tester) async {
      bool retryPressed = false;
      void onRetry() {
        retryPressed = true;
      }

      await tester.pumpWidget(
        MaterialApp(
          home: AuthErrorWidget(
            message: 'Test error',
            onRetry: onRetry,
          ),
        ),
      );

      expect(find.text('Test error'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      await tester.tap(find.text('Retry'));
      expect(retryPressed, isTrue);
    });

    testWidgets('displays error message without retry button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthErrorWidget(message: 'Test error'),
        ),
      );

      expect(find.text('Test error'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Retry'), findsNothing);
    });
  });

  group('AuthSuccessWidget', () {
    testWidgets('displays success message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthSuccessWidget(message: 'Success!'),
        ),
      );

      expect(find.text('Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });
  });
}
