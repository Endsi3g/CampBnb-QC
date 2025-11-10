// Test de base pour l'application Campbnb
// Vérifie que l'application peut être construite sans erreur

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:campbnb/main.dart';
import 'package:campbnb/core/config/env_config.dart';
import 'package:campbnb/services/service_factory.dart';

void main() {
  testWidgets('L\'application Campbnb se lance correctement', (WidgetTester tester) async {
    // Initialiser l'environnement de test
    // Configurer SharedPreferences pour activer le mode sandbox
    SharedPreferences.setMockInitialValues({'sandbox_mode': true});
    
    // Initialiser EnvConfig (sans fichier .env, cela activera le mode sandbox)
    await EnvConfig.load();
    
    // Initialiser les services (en mode sandbox pour les tests)
    await ServiceFactory.initializeAll();
    
    // Construire l'application avec ProviderScope requis par Riverpod
    await tester.pumpWidget(
      const ProviderScope(
        child: CampbnbApp(),
      ),
    );

    // Attendre que l'application soit construite
    // Utiliser pump() au lieu de pumpAndSettle() pour éviter les timeouts
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Vérifier que l'application s'est construite sans erreur
    // L'application devrait contenir un MaterialApp
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
