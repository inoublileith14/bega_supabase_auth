import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bega_supabase_auth/src/presentation/widgets/auth_form.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_bloc.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_state.dart';
import 'package:bega_supabase_auth/src/domain/use_cases/auth_use_cases.dart';

// Mock classes
class MockAuthBloc extends Mock implements AuthBloc {}
class MockAuthUseCases extends Mock implements AuthUseCases {}

void main() {
  group('AuthForm', () {
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
      when(() => mockAuthBloc.state).thenReturn(const AuthInitial());
      when(() => mockAuthBloc.stream).thenAnswer((_) => Stream.value(const AuthInitial()));
    });

    Widget createWidgetUnderTest({
      bool isSignUp = false,
      VoidCallback? onToggleMode,
      AuthFormStyle? style,
    }) {
      return MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: Scaffold(
            body: AuthForm(
              isSignUp: isSignUp,
              onToggleMode: onToggleMode,
              style: style,
            ),
          ),
        ),
      );
    }

    testWidgets('displays sign in form by default', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsNothing);
    });

    testWidgets('displays sign up form when isSignUp is true', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(isSignUp: true));

      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
    });

    testWidgets('shows toggle button when onToggleMode is provided', (WidgetTester tester) async {
      bool toggled = false;
      void toggleMode() {
        toggled = true;
      }

      await tester.pumpWidget(createWidgetUnderTest(onToggleMode: toggleMode));

      expect(find.text('Don\'t have an account? Sign Up'), findsOneWidget);
      
      await tester.tap(find.text('Don\'t have an account? Sign Up'));
      expect(toggled, isTrue);
    });

    testWidgets('validates email field', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Test empty email
      await tester.tap(find.text('Sign In'));
      await tester.pump();
      expect(find.text('Please enter your email'), findsOneWidget);

      // Test invalid email
      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.tap(find.text('Sign In'));
      await tester.pump();
      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets('validates password field', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Enter valid email
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');

      // Test empty password
      await tester.tap(find.text('Sign In'));
      await tester.pump();
      expect(find.text('Please enter your password'), findsOneWidget);

      // Test short password
      await tester.enterText(find.byType(TextFormField).at(1), '123');
      await tester.tap(find.text('Sign In'));
      await tester.pump();
      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });

    testWidgets('validates confirm password field in sign up mode', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(isSignUp: true));

      // Enter valid email and password
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password123');

      // Test empty confirm password
      await tester.tap(find.text('Sign Up'));
      await tester.pump();
      expect(find.text('Please confirm your password'), findsOneWidget);

      // Test mismatched passwords
      await tester.enterText(find.byType(TextFormField).at(2), 'different');
      await tester.tap(find.text('Sign Up'));
      await tester.pump();
      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('calls AuthBloc with correct event on valid form submission', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Enter valid credentials
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password123');

      // Submit form
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      verify(() => mockAuthBloc.add(any())).called(1);
    });

    testWidgets('shows loading state when AuthBloc is in loading state', (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthLoading());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Sign In'), findsNothing);
    });

    testWidgets('applies custom styling when provided', (WidgetTester tester) async {
      final customStyle = AuthFormStyle(
        titleStyle: const TextStyle(fontSize: 24, color: Colors.blue),
        spacing: 20,
      );

      await tester.pumpWidget(createWidgetUnderTest(style: customStyle));

      final titleWidget = tester.widget<Text>(find.text('Sign In'));
      expect(titleWidget.style?.fontSize, 24);
      expect(titleWidget.style?.color, Colors.blue);
    });
  });
}
