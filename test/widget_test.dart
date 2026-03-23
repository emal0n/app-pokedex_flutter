// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pokedex/main.dart';

void main() {
  testWidgets('Renderiza a splash screen inicial', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('POKÉDEX'), findsOneWidget);
    expect(find.text('Explore o mundo Pokémon'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Avanca o timer de navegacao da splash para evitar timer pendente no fim do teste.
    await tester.pump(const Duration(seconds: 4));
  });
}
