import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vitalis_app/app.dart';

void main() {
  testWidgets('App boots and renders the phone frame', (WidgetTester tester) async {
    await tester.pumpWidget(const VitalisApp());
    await tester.pump();

    expect(find.text('Inicio'), findsWidgets);
    expect(find.text('Entreno'), findsWidgets);
    expect(find.text('Sueño'), findsWidgets);
    expect(find.text('Comida'), findsWidgets);
    expect(find.text('Social'), findsWidgets);
  });

  testWidgets('Bottom nav switches tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const VitalisApp());
    await tester.pump();

    await tester.tap(find.byIcon(Icons.bedtime));
    await tester.pump();
    expect(find.byIcon(Icons.bedtime), findsOneWidget);
  });
}