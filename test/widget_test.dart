import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe/widgets/section_header.dart'; // 👈 Correct path

void main() {
  testWidgets('SectionHeader shows icons and navigates correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/favorites': (context) => const Scaffold(body: Text('Favorites Page')),
          '/settings': (context) => const Scaffold(body: Text('Settings Page')),
        },
        home: const Scaffold(
         // appBar: SectionHeader(),
        ),
      ),
    );

    // ✅ Check title
    expect(find.text("My App"), findsOneWidget);

    // ✅ Check icons exist
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);

    // ✅ Tap Favorite
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pumpAndSettle();
    expect(find.text("Favorites Page"), findsOneWidget);

    // ✅ Go back
    await tester.pageBack();
    await tester.pumpAndSettle();

    // ✅ Tap Settings
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    expect(find.text("Settings Page"), findsOneWidget);
  });
}
