import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_masked_input/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('7618ANSA-019: Stateless Router Zero Local Footprint Integration Tests', () {
    testWidgets('1. Happy-Path: Navigates statelessly and verifies 0 KB local cache', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify Overview route rendered statelessly
      expect(find.textContaining('Overview Portal'), findsOneWidget);
      expect(find.textContaining('Volatile Local Cache Memory Marker: 0 KB'), findsOneWidget);

      // Trigger valid deep-link navigation
      final validLinkButton = find.text('VALID_DEEP_LINK');
      expect(validLinkButton, findsOneWidget);
      await tester.tap(validLinkButton);
      await tester.pumpAndSettle();

      // Verify Analytics route rendered with constructor parameter and 0 KB cache
      expect(find.textContaining('Analytics Ledger'), findsOneWidget);
      expect(find.textContaining('Volatile Local Cache Memory Marker: 0 KB'), findsOneWidget);
    });

    testWidgets('2. Failure Scenario: Deep-link missing tracking key triggers interceptor', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final invalidLinkButton = find.text('INVALID_LINK');
      expect(invalidLinkButton, findsOneWidget);
      await tester.tap(invalidLinkButton);
      await tester.pumpAndSettle();

      // Interceptor should catch missing 'tk' and route to blocked screen
      expect(find.text('DEEP-LINK INTERCEPTOR TRIGGERED'), findsOneWidget);
    });
  });
}
