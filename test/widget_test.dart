import 'package:flutter_test/flutter_test.dart';

import 'package:delivery/app/app.dart';

void main() {
  testWidgets('renders the splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const DeliveryApp());

    expect(find.text('Foodgo'), findsWidgets);
  });
}
