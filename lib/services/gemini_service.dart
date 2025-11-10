import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/config/env_config.dart';
import '../core/constants/app_constants.dart';
import '../core/utils/logger.dart';

/// Service pour l'intégration avec l'API Gemini 2.5
class GeminiService {
  static final GeminiService _instance = GeminiService._internal();
  factory GeminiService() => _instance;
  GeminiService._internal();
  
  final String _baseUrl = AppConstants.geminiApiBaseUrl;
  String? _apiKey;
  
  void initialize() {
    _apiKey = EnvConfig.geminiApiKey;
    if (_apiKey == null || _apiKey!.isEmpty) {
      appLogger.w('Clé API Gemini non configurée');
    }
  }
  
  // ============================================
  // CHATBOT / ASSISTANT
  // ============================================
  
  /// Envoyer un message au chatbot Gemini
  Future<String> chat({
    required String message,
    List<Map<String, String>>? conversationHistory,
    String? context, // Contexte utilisateur (préférences, historique)
  }) async {
    if (_apiKey == null) {
      throw Exception('Clé API Gemini non configurée');
    }
    
    try {
      final url = Uri.parse('$_baseUrl/models/gemini-2.0-flash-exp:generateContent?key=$_apiKey');
      
      // Construire le prompt avec contexte
      final systemPrompt = _buildSystemPrompt(context);
      final messages = _buildMessages(systemPrompt, message, conversationHistory);
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': messages,
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          },
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'] as String;
        return text;
      } else {
        errorLogger.e('Erreur API Gemini: ${response.statusCode} - ${response.body}');
        throw Exception('Erreur API Gemini: ${response.statusCode}');
      }
    } catch (e) {
      errorLogger.e('Erreur chat Gemini: $e');
      rethrow;
    }
  }
  
  // ============================================
  // RECOMMANDATIONS PERSONNALISÉES
  // ============================================
  
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
    Map<String, dynamic>? userHistory,
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

Historique: ${userHistory != null ? jsonEncode(userHistory) : 'Aucun'}

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
      // Parser la réponse JSON
      final jsonMatch = RegExp(r'\{.*\}', dotAll: true).firstMatch(response);
      if (jsonMatch != null) {
        final data = jsonDecode(jsonMatch.group(0)!);
        return List<Map<String, dynamic>>.from(data['recommendations'] ?? []);
      }
      return [];
    } catch (e) {
      errorLogger.e('Erreur recommandations: $e');
      return [];
    }
  }
  
  // ============================================
  // RÉSUMÉ D'AVIS
  // ============================================
  
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
      errorLogger.e('Erreur résumé avis: $e');
      return 'Impossible de générer le résumé des avis.';
    }
  }
  
  // ============================================
  // GÉNÉRATION D'ITINÉRAIRES
  // ============================================
  
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
      errorLogger.e('Erreur génération itinéraire: $e');
      return {};
    }
  }
  
  // ============================================
  // TRADUCTION
  // ============================================
  
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
      errorLogger.e('Erreur traduction: $e');
      return text; // Retourner le texte original en cas d'erreur
    }
  }
  
  // ============================================
  // ANALYSE DE PHOTOS (Future)
  // ============================================
  
  /// Analyser la qualité des photos d'une annonce
  Future<Map<String, dynamic>> analyzePhotos(List<String> photoUrls) async {
    // Note: Cette fonctionnalité nécessite Gemini Vision API
    // Pour le MVP, on retourne un placeholder
    return {
      'quality_score': 0.8,
      'suggestions': ['Ajouter plus de photos de l\'extérieur'],
    };
  }
  
  // ============================================
  // HELPERS
  // ============================================
  
  String _buildSystemPrompt(String? context) {
    return '''
Tu es Campy, l'assistant IA de Campbnb, une plateforme de réservation de camping au Québec.

Ton rôle:
- Aider les utilisateurs à trouver le camping idéal
- Répondre aux questions sur les réservations
- Suggérer des activités locales québécoises
- Fournir des informations sur les régions du Québec
- Traduire entre français et anglais si nécessaire

Contexte utilisateur: ${context ?? 'Aucun'}
Régions du Québec disponibles: ${AppConstants.quebecRegions.join(', ')}

Sois toujours amical, informatif et adapté à la culture québécoise.
''';
  }
  
  List<Map<String, dynamic>> _buildMessages(
    String systemPrompt,
    String userMessage,
    List<Map<String, String>>? history,
  ) {
    final messages = <Map<String, dynamic>>[];
    
    // Ajouter l'historique de conversation
    if (history != null) {
      for (final msg in history) {
        messages.add({
          'role': msg['role'] ?? 'user',
          'parts': [{'text': msg['content'] ?? ''}],
        });
      }
    }
    
    // Ajouter le message système comme premier message
    messages.insert(0, {
      'role': 'user',
      'parts': [{'text': systemPrompt}],
    });
    
    // Ajouter le message actuel
    messages.add({
      'role': 'user',
      'parts': [{'text': userMessage}],
    });
    
    return messages;
  }
}

