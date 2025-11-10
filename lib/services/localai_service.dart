import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/config/env_config.dart';
import '../core/utils/logger.dart';

/// Service pour l'intégration avec LocalAI
/// Alternative locale à Gemini/OpenAI pour les fonctionnalités IA
class LocalAIService {
  static final LocalAIService _instance = LocalAIService._internal();
  factory LocalAIService() => _instance;
  LocalAIService._internal();

  String? _baseUrl;
  String? _apiKey;
  String? _model;

  void initialize() {
    _baseUrl = EnvConfig.localAIBaseUrl;
    _apiKey = EnvConfig.localAIApiKey;
    _model = EnvConfig.localAIModel ?? 'gpt-3.5-turbo';
    
    if (_baseUrl == null || _baseUrl!.isEmpty) {
      errorLogger.w('URL LocalAI non configurée');
    }
  }

  /// Envoyer un message au chatbot LocalAI
  Future<String> chat({
    required String message,
    List<Map<String, String>>? conversationHistory,
    String? systemPrompt,
  }) async {
    if (_baseUrl == null) {
      throw Exception('LocalAI API non configurée');
    }

    try {
      final url = Uri.parse('$_baseUrl/v1/chat/completions');
      
      // Construire les messages
      final messages = <Map<String, dynamic>>[];
      
      if (systemPrompt != null) {
        messages.add({
          'role': 'system',
          'content': systemPrompt,
        });
      }
      
      // Ajouter l'historique
      if (conversationHistory != null) {
        for (final msg in conversationHistory) {
          messages.add({
            'role': msg['role'] ?? 'user',
            'content': msg['content'] ?? '',
          });
        }
      }
      
      // Ajouter le message actuel
      messages.add({
        'role': 'user',
        'content': message,
      });

      final headers = <String, String>{
        'Content-Type': 'application/json',
      };
      
      if (_apiKey != null && _apiKey!.isNotEmpty) {
        headers['Authorization'] = 'Bearer $_apiKey';
      }

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'model': _model,
          'messages': messages,
          'temperature': 0.7,
          'max_tokens': 1024,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'] as String;
        return content;
      } else {
        errorLogger.e('Erreur API LocalAI: ${response.statusCode} - ${response.body}');
        throw Exception('Erreur API LocalAI: ${response.statusCode}');
      }
    } catch (e) {
      errorLogger.e('Erreur chat LocalAI: $e');
      rethrow;
    }
  }

  /// Générer des recommandations de camping personnalisées
  Future<List<Map<String, dynamic>>> getRecommendations({
    required String userId,
    String? region,
    String? preferredType,
    int? budget,
    List<String>? preferredAmenities,
    DateTime? checkIn,
    DateTime? checkOut,
    int? guests,
  }) async {
    final prompt = '''
Tu es un assistant expert en camping au Québec. 
Génère 5 recommandations de camping personnalisées pour un utilisateur.

Contexte utilisateur:
- Région préférée: ${region ?? 'Toutes'}
- Type de camping: ${preferredType ?? 'Tous'}
- Budget: ${budget != null ? '\$$budget/nuit' : 'Flexible'}
- Équipements souhaités: ${preferredAmenities?.join(', ') ?? 'Aucune préférence'}
- Dates: ${checkIn != null ? '${checkIn.day}/${checkIn.month}/${checkIn.year}' : 'Flexible'}
- Nombre de voyageurs: ${guests ?? 'Non spécifié'}

Génère une réponse JSON avec ce format:
{
  "recommendations": [
    {
      "listing_id": "suggestion_1",
      "title": "Nom du camping",
      "region": "Région",
      "reason": "Pourquoi cette recommandation",
      "match_score": 0.95
    }
  ]
}
''';

    try {
      final response = await chat(message: prompt);
      final jsonMatch = RegExp(r'\{.*\}', dotAll: true).firstMatch(response);
      if (jsonMatch != null) {
        final data = jsonDecode(jsonMatch.group(0)!);
        return List<Map<String, dynamic>>.from(data['recommendations'] ?? []);
      }
      return [];
    } catch (e) {
      errorLogger.e('Erreur recommandations LocalAI: $e');
      return [];
    }
  }

  /// Générer un résumé intelligent des avis
  Future<String> summarizeReviews(List<Map<String, dynamic>> reviews) async {
    final prompt = '''
Analyse les avis suivants et génère un résumé intelligent en français:

${reviews.map((r) => 'Note: ${r['rating']}/5 - ${r['comment'] ?? 'Pas de commentaire'}').join('\n')}

Génère un résumé de 2-3 phrases qui:
1. Identifie les points forts mentionnés
2. Identifie les points à améliorer
3. Donne une impression générale

Format: Texte simple, pas de JSON.
''';

    try {
      return await chat(message: prompt);
    } catch (e) {
      errorLogger.e('Erreur résumé avis LocalAI: $e');
      return 'Impossible de générer le résumé des avis.';
    }
  }

  /// Traduire un texte FR/EN
  Future<String> translate(String text, {required String targetLanguage}) async {
    final prompt = '''
Traduis le texte suivant en $targetLanguage:
"$text"

Réponds uniquement avec la traduction, sans explication.
''';

    try {
      return await chat(message: prompt);
    } catch (e) {
      errorLogger.e('Erreur traduction LocalAI: $e');
      return text;
    }
  }

  /// Générer un itinéraire de voyage
  Future<Map<String, dynamic>> generateItinerary({
    required String region,
    required int days,
    List<String>? interests,
    int? budget,
  }) async {
    final prompt = '''
Crée un itinéraire de camping de $days jours dans la région $region au Québec.

Intérêts: ${interests?.join(', ') ?? 'Camping général'}
Budget: ${budget != null ? '\$$budget total' : 'Flexible'}

Génère un JSON avec:
{
  "title": "Titre de l'itinéraire",
  "days": $days,
  "region": "$region",
  "itinerary": [
    {
      "day": 1,
      "activities": ["Activité 1", "Activité 2"],
      "camping_suggestion": "Nom du camping",
      "tips": "Conseils pour cette journée"
    }
  ],
  "total_estimated_cost": 0,
  "highlights": ["Point fort 1", "Point fort 2"]
}
''';

    try {
      final response = await chat(message: prompt);
      final jsonMatch = RegExp(r'\{.*\}', dotAll: true).firstMatch(response);
      if (jsonMatch != null) {
        return jsonDecode(jsonMatch.group(0)!) as Map<String, dynamic>;
      }
      return {};
    } catch (e) {
      errorLogger.e('Erreur génération itinéraire LocalAI: $e');
      return {};
    }
  }

  /// Lister les modèles disponibles
  Future<List<String>> listModels() async {
    if (_baseUrl == null) {
      throw Exception('LocalAI API non configurée');
    }

    try {
      final url = Uri.parse('$_baseUrl/v1/models');
      
      final headers = <String, String>{};
      if (_apiKey != null && _apiKey!.isNotEmpty) {
        headers['Authorization'] = 'Bearer $_apiKey';
      }

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final models = data['data'] as List;
        return models.map((m) => m['id'] as String).toList();
      } else {
        errorLogger.e('Erreur liste modèles: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      errorLogger.e('Erreur listModels: $e');
      return [];
    }
  }
}

