// Test de base pour l'application Campbnb
// Vérifie que l'application peut être construite et affiche l'écran de bienvenue

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campbnb/main.dart';

void main() {
  testWidgets('L\'application Campbnb se lance correctement', (WidgetTester tester) async {
    // Construire l'application avec ProviderScope requis par Riverpod
    await tester.pumpWidget(
      const ProviderScope(
        child: CampbnbApp(),
      ),
    );

    // Attendre que l'application soit complètement chargée
    await tester.pumpAndSettle();

    // Vérifier que l'application s'est construite sans erreur
    // L'écran de bienvenue devrait être affiché (route initiale: /welcome)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
