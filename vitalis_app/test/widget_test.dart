import 'package:flutter_test/flutter_test.dart';
import 'package:vitalis_app/app.dart';

void main() {
  testWidgets('App boots and shows auth landing', (WidgetTester tester) async {
    await tester.pumpWidget(const VitalisApp());
    await tester.pump();

    expect(find.text('Vitalis'), findsWidgets);
    expect(find.text('Iniciar sesión'), findsOneWidget);
    expect(find.text('Crear cuenta'), findsWidgets);
  });

  testWidgets('Auth login screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const VitalisApp());
    await tester.pump();

    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Contraseña'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('Bottom nav renders after exploring as guest', (WidgetTester tester) async {
    await tester.pumpWidget(const VitalisApp());
    await tester.pump();

    await tester.tap(find.text('Explorar sin cuenta'));
    await tester.pumpAndSettle();

    expect(find.text('Inicio'), findsWidgets);
    expect(find.text('Entreno'), findsWidgets);
    expect(find.text('Sueño'), findsWidgets);
    expect(find.text('Comida'), findsWidgets);
    expect(find.text('Social'), findsWidgets);
  });
}
