import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ra3_flutter_services_dacaga24_cpu/main.dart';

void main() {
  testWidgets('Hello World screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Hello World!'), findsOneWidget);
    expect(find.text('Hello World'), findsOneWidget);
  });
}
