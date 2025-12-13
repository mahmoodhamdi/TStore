import 'package:flutter_test/flutter_test.dart';
import 'package:t_store/t_store.dart';

void main() {
  testWidgets('TStore app loads successfully', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const TStore());

    // Verify that the app renders without errors.
    expect(find.byType(TStore), findsOneWidget);
  });
}
