import 'package:flutter/material.dart';
import '../../services/service_factory.dart';
import '../../core/utils/logger.dart';

/// Exemples d'utilisation des services intégrés
/// 
/// Ce fichier montre comment utiliser Call Center AI, LocalAI et Handy
/// dans l'application Flutter.
class IntegrationsExample extends StatefulWidget {
  const IntegrationsExample({super.key});

  @override
  State<IntegrationsExample> createState() => _IntegrationsExampleState();
}

class _IntegrationsExampleState extends State<IntegrationsExample> {
  String _status = 'Prêt';
  bool _isLoading = false;

  // ============================================
  // EXEMPLE: Call Center AI
  // ============================================

  Future<void> _testCallCenter() async {
    setState(() {
      _isLoading = true;
      _status = 'Initiation d\'un appel...';
    });

    try {
      final callCenter = ServiceFactory.getCallCenterService();

      // Initier un appel de support réservation
      final result = await callCenter.initiateCall(
        phoneNumber: '+14161234567', // Remplacez par un vrai numéro
        task: '''
Aider le client avec sa réservation de camping.
Collecter les informations suivantes:
- Numéro de réservation
- Type de problème (annulation, modification, question)
- Solution préférée par le client
- Niveau d'urgence
''',
        claim: CallCenterService.createBookingSupportClaim(),
        botName: 'Campy',
        botCompany: 'Campbnb',
      );

      setState(() {
        _status = 'Appel initié avec succès!\nCall ID: ${result['call_id']}';
      });

      appLogger.i('Appel initié: ${result['call_id']}');

      // Attendre un peu puis vérifier le statut
      await Future.delayed(const Duration(seconds: 2));

      final status = await callCenter.getCallStatus(result['call_id']);
      appLogger.i('Statut de l\'appel: ${status['status']}');
    } catch (e) {
      setState(() {
        _status = 'Erreur: $e';
      });
      errorLogger.e('Erreur Call Center: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ============================================
  // EXEMPLE: LocalAI
  // ============================================

  Future<void> _testLocalAI() async {
    setState(() {
      _isLoading = true;
      _status = 'Chat avec LocalAI...';
    });

    try {
      final localAI = ServiceFactory.getLocalAIService();

      // Chat simple
      final response = await localAI.chat(
        message: 'Quels sont les meilleurs campings au Québec?',
        systemPrompt: '''
Tu es Campy, un assistant expert en camping au Québec.
Tu aides les utilisateurs à trouver le camping idéal.
Sois amical et informatif.
''',
      );

      setState(() {
        _status = 'Réponse LocalAI:\n$response';
      });

      appLogger.i('Réponse LocalAI: $response');

      // Tester les recommandations
      final recommendations = await localAI.getRecommendations(
        userId: 'user123',
        region: 'Charlevoix',
        budget: 100,
        preferredType: 'tent',
      );

      appLogger.i('Recommandations: ${recommendations.length} trouvées');
    } catch (e) {
      setState(() {
        _status = 'Erreur LocalAI: $e';
      });
      errorLogger.e('Erreur LocalAI: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ============================================
  // EXEMPLE: Handy (Transcription vocale)
  // ============================================

  Future<void> _testHandy() async {
    setState(() {
      _isLoading = true;
      _status = 'Vérification du service Handy...';
    });

    try {
      final handy = ServiceFactory.getHandyService();

      // Vérifier la disponibilité
      final isAvailable = await handy.checkHealth();
      if (!isAvailable) {
        setState(() {
          _status = 'Service Handy non disponible.\nAssurez-vous que le service est démarré.';
        });
        return;
      }

      setState(() {
        _status = 'Service Handy disponible!\nPour transcrire un fichier audio, utilisez:\nhandy.transcribeAudio(audioFile: path)';
      });

      // Obtenir les modèles disponibles
      final models = await handy.getAvailableModels();
      appLogger.i('Modèles Handy disponibles: $models');

      // Exemple de transcription (nécessite un fichier audio)
      // final transcription = await handy.transcribeAudio(
      //   audioFile: '/path/to/audio.wav',
      //   language: 'fr',
      //   model: 'whisper-small',
      // );
    } catch (e) {
      setState(() {
        _status = 'Erreur Handy: $e';
      });
      errorLogger.e('Erreur Handy: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ============================================
  // UI
  // ============================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemples d\'intégrations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Statut
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Statut:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _status,
                      style: const TextStyle(fontSize: 14),
                    ),
                    if (_isLoading) ...[
                      const SizedBox(height: 16),
                      const LinearProgressIndicator(),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Boutons de test
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _testCallCenter,
              icon: const Icon(Icons.phone),
              label: const Text('Tester Call Center AI'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _testLocalAI,
              icon: const Icon(Icons.smart_toy),
              label: const Text('Tester LocalAI'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _testHandy,
              icon: const Icon(Icons.mic),
              label: const Text('Tester Handy (Speech-to-Text)'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 24),

            // Instructions
            const Card(
              color: Colors.blue50,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📝 Instructions:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. Assurez-vous que le backend API est démarré (port 5000)',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      '2. Pour LocalAI: démarrez le serveur LocalAI (port 8080)',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      '3. Pour Handy: démarrez le service Handy (port 3000)',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      '4. Configurez les variables d\'environnement dans .env',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

