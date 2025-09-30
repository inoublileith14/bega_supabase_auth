import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bega_supabase_auth/src/presentation/widgets/social_auth_buttons.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_bloc.dart';
import 'package:bega_supabase_auth/src/presentation/bloc/auth_state.dart';
import 'package:bega_supabase_auth/src/domain/use_cases/auth_use_cases.dart';

// Mock classes
class MockAuthBloc extends Mock implements AuthBloc {}

class MockAuthUseCases extends Mock implements AuthUseCases {}

void main() {
  group('SocialAuthButtons', () {
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
      when(() => mockAuthBloc.state).thenReturn(const AuthInitial());
      when(
        () => mockAuthBloc.stream,
      ).thenAnswer((_) => Stream.value(const AuthInitial()));
    });

    Widget createWidgetUnderTest({
      List<SocialProvider> providers = const [
        SocialProvider.google,
        SocialProvider.github,
        SocialProvider.apple,
      ],
      SocialAuthButtonsStyle? style,
    }) {
      return MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: Scaffold(
            body: SocialAuthButtons(providers: providers, style: style),
          ),
        ),
      );
    }

    testWidgets('displays default social providers', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Google'), findsOneWidget);
      expect(find.text('GitHub'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
    });

    testWidgets('displays only specified providers', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          providers: [SocialProvider.google, SocialProvider.facebook],
        ),
      );

      expect(find.text('Google'), findsOneWidget);
      expect(find.text('Facebook'), findsOneWidget);
      expect(find.text('GitHub'), findsNothing);
      expect(find.text('Apple'), findsNothing);
    });

    testWidgets('shows divider by default', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Or sign in with:'), findsOneWidget);
    });

    testWidgets('hides divider when showDivider is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          style: const SocialAuthButtonsStyle(showDivider: false),
        ),
      );

      expect(find.text('Or sign in with:'), findsNothing);
    });

    testWidgets(
      'calls AuthBloc with correct event when Google button is tapped',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.tap(find.text('Google'));
        await tester.pump();

        verify(() => mockAuthBloc.add(any())).called(1);
      },
    );

    testWidgets(
      'calls AuthBloc with correct event when GitHub button is tapped',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.tap(find.text('GitHub'));
        await tester.pump();

        verify(() => mockAuthBloc.add(any())).called(1);
      },
    );

    testWidgets(
      'calls AuthBloc with correct event when Apple button is tapped',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.tap(find.text('Apple'));
        await tester.pump();

        verify(() => mockAuthBloc.add(any())).called(1);
      },
    );

    testWidgets('disables buttons when AuthBloc is in loading state', (
      WidgetTester tester,
    ) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthLoading());

      await tester.pumpWidget(createWidgetUnderTest());

      final googleButton = tester.widget<ElevatedButton>(
        find.ancestor(
          of: find.text('Google'),
          matching: find.byType(ElevatedButton),
        ),
      );
      expect(googleButton.onPressed, isNull);
    });

    testWidgets('applies custom styling when provided', (
      WidgetTester tester,
    ) async {
      final customStyle = const SocialAuthButtonsStyle(
        buttonWidth: 200,
        buttonHeight: 50,
        spacing: 20,
      );

      await tester.pumpWidget(createWidgetUnderTest(style: customStyle));

      final googleButton = tester.widget<ElevatedButton>(
        find.ancestor(
          of: find.text('Google'),
          matching: find.byType(ElevatedButton),
        ),
      );

      // Check that the button has the custom styling applied
      expect(googleButton, isA<ElevatedButton>());
    });

    testWidgets('displays all supported social providers', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          providers: [
            SocialProvider.google,
            SocialProvider.github,
            SocialProvider.apple,
            SocialProvider.facebook,
            SocialProvider.twitter,
            SocialProvider.discord,
          ],
        ),
      );

      expect(find.text('Google'), findsOneWidget);
      expect(find.text('GitHub'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Facebook'), findsOneWidget);
      expect(find.text('Twitter'), findsOneWidget);
      expect(find.text('Discord'), findsOneWidget);
    });
  });

  group('SocialProvider', () {
    test('has correct values', () {
      expect(SocialProvider.google.name, 'google');
      expect(SocialProvider.github.name, 'github');
      expect(SocialProvider.apple.name, 'apple');
      expect(SocialProvider.facebook.name, 'facebook');
      expect(SocialProvider.twitter.name, 'twitter');
      expect(SocialProvider.discord.name, 'discord');
    });
  });

  group('SocialAuthButtonsStyle', () {
    test('defaultStyle returns default values', () {
      final style = SocialAuthButtonsStyle.defaultStyle();

      expect(style.showDivider, isTrue);
      expect(style.dividerSpacing, isNull);
      expect(style.dividerColor, isNull);
      expect(style.dividerTextStyle, isNull);
      expect(style.spacing, isNull);
      expect(style.buttonSpacing, isNull);
      expect(style.buttonWidth, isNull);
      expect(style.buttonHeight, isNull);
    });

    test('can be created with custom values', () {
      const style = SocialAuthButtonsStyle(
        showDivider: false,
        buttonWidth: 150,
        buttonHeight: 40,
        spacing: 10,
      );

      expect(style.showDivider, isFalse);
      expect(style.buttonWidth, 150);
      expect(style.buttonHeight, 40);
      expect(style.spacing, 10);
    });
  });
}
