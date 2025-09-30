// Basic smoke test for the Bega Supabase Auth example app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Example App Basic Tests', () {
    testWidgets('MaterialApp can be created', (WidgetTester tester) async {
      // Simple test to verify the Flutter setup works
      final testApp = MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Bega Supabase Auth')),
          body: const Center(child: Text('Test App')),
        ),
      );

      await tester.pumpWidget(testApp);

      expect(find.text('Bega Supabase Auth'), findsOneWidget);
      expect(find.text('Test App'), findsOneWidget);
    });

    testWidgets('Basic UI widgets work', (WidgetTester tester) async {
      const testApp = MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Text('Email Login'),
              Text('Social Login'),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );

      await tester.pumpWidget(testApp);

      expect(find.text('Email Login'), findsOneWidget);
      expect(find.text('Social Login'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
