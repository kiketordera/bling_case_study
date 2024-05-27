import 'package:bling_case_study/screens/age_estimator_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Age Estimator Screen shows initial UI elements',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: AgeEstimatorScreen(),
    ));

    expect(find.text('Enter your name'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Age Estimator Screen shows age estimate result',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: AgeEstimatorScreen(),
    ));

    await tester.enterText(find.byType(TextField), 'John');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
  });
}
