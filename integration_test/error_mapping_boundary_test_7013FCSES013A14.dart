import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_masked_input/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('7013FCSES-013: Frontend Error Mapping Boundary Integration Tests', () {
    testWidgets('Simulates 500 Backend Error & Verifies Component-Level Retry',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('RETRY_COMPONENT_FETCH'), findsOneWidget);
      await tester.tap(find.text('RETRY_COMPONENT_FETCH'));
      await tester.pumpAndSettle();

      expect(find.text('Integration Test Pass Rate: Pass'), findsOneWidget);
    });
  });
}
