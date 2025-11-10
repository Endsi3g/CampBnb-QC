import '../core/utils/logger.dart';

/// Service Gemini mock pour le mode sandbox
class MockGeminiService {
  static final MockGeminiService _instance = MockGeminiService._internal();
  factory MockGeminiService() => _instance;
  MockGeminiService._internal();
  
  void initialize() {
    appLogger.i('Mock Gemini initialisé (mode sandbox)');
  }
  
  // ============================================
  // CHATBOT / ASSISTANT
  // ============================================
  
  Future<String> chat({
    required String message,
    List<Map<String, String>>? conversationHistory,
    String? context,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simuler latence API
    
    // Réponses mock basées sur le message
    final lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('bonjour') || lowerMessage.contains('salut')) {
      return 'Bonjour! Je suis Campy, votre assistant virtuel pour Campbnb. Comment puis-je vous aider à trouver le camping idéal au Québec?';
    }
    
    if (lowerMessage.contains('recommandation') || lowerMessage.contains('suggérer')) {
      return r'''Voici mes recommandations pour vous:

1. **Camping Domaine Aventura - Charlevoix** (45$/nuit)
   - Parfait pour les amoureux de la nature avec vue sur le fleuve
   - Équipements: eau, feu, toilettes, douches

2. **Camping Éco-Lodge Laurentides** (85$/nuit)
   - Camping écologique avec cabanes en bois
   - Idéal pour les familles, wifi inclus

3. **Camping Mont-Tremblant - Expérience Premium** (120$/nuit)
   - Glamping de luxe avec vue sur les montagnes
   - Toutes les commodités modernes

Ces recommandations sont basées sur les campings disponibles dans notre base de données. Souhaitez-vous plus de détails sur l'un d'eux?''';
    }
    
    if (lowerMessage.contains('prix') || lowerMessage.contains('coût')) {
      return r'''Les prix varient selon le type de camping:

- **Tente**: 45-60$/nuit
- **Cabane**: 85-100$/nuit
- **VR/Caravane**: 60-80$/nuit
- **Glamping**: 120-150$/nuit

Les prix incluent généralement l'accès aux installations de base (eau, toilettes, douches). Certains campings offrent des équipements supplémentaires comme l'électricité, le wifi, ou des installations de luxe.

Avez-vous un budget en tête? Je peux vous suggérer des options adaptées!''';
    }
    
    if (lowerMessage.contains('région') || lowerMessage.contains('où')) {
      return '''Nous avons des campings dans plusieurs régions du Québec:

- **Charlevoix**: Paysages magnifiques, vue sur le fleuve
- **Laurentides**: Proximité de Montréal, montagnes
- **Lanaudière**: Nature préservée, rivières
- **Capitale-Nationale**: Proche de Québec, île d'Orléans

Quelle région vous intéresse? Je peux vous donner des recommandations spécifiques!''';
    }
    
    // Réponse par défaut
    return '''Merci pour votre message! Je suis en mode démonstration, donc mes réponses sont limitées.

En mode production, je pourrais:
- Vous aider à trouver le camping parfait selon vos préférences
- Répondre à vos questions sur les réservations
- Suggérer des activités locales
- Générer des itinéraires personnalisés

Pour tester l'application complète, vous pouvez:
- Parcourir les campings disponibles
- Créer un compte et faire une réservation
- Explorer les différentes régions du Québec

Avez-vous d'autres questions?''';
  }
  
  // ============================================
  // RECOMMANDATIONS PERSONNALISÉES
  // ============================================
  
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
    await Future.delayed(const Duration(milliseconds: 1000));
    
    return [
      {
        'listing_id': 'mock_1',
        'title': 'Camping Domaine Aventura - Charlevoix',
        'region': 'Charlevoix',
        'reason': 'Correspond à vos préférences de budget et de région',
        'match_score': 0.92,
      },
      {
        'listing_id': 'mock_2',
        'title': 'Camping Éco-Lodge Laurentides',
        'region': 'Laurentides',
        'reason': 'Excellent rapport qualité-prix avec équipements modernes',
        'match_score': 0.88,
      },
    ];
  }
  
  // ============================================
  // RÉSUMÉ D'AVIS
  // ============================================
  
  Future<String> summarizeReviews(List<Map<String, dynamic>> reviews) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (reviews.isEmpty) {
      return 'Aucun avis disponible pour le moment.';
    }
    
    final avgRating = reviews
        .map((r) => (r['rating'] as num?)?.toDouble() ?? 0.0)
        .reduce((a, b) => a + b) / reviews.length;
    
    return '''Résumé des avis (${reviews.length} avis, note moyenne: ${avgRating.toStringAsFixed(1)}/5):

Les clients apprécient particulièrement la beauté naturelle des lieux et la qualité des installations. Certains mentionnent que c'est un excellent rapport qualité-prix. Quelques suggestions d'amélioration concernent l'ajout de plus d'équipements modernes.

Dans l'ensemble, les visiteurs recommandent ce camping pour une expérience authentique en pleine nature.''';
  }
  
  // ============================================
  // GÉNÉRATION D'ITINÉRAIRES
  // ============================================
  
  Future<Map<String, dynamic>> generateItinerary({
    required String region,
    required int days,
    List<String>? interests,
    int? budget,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    return {
      'title': 'Itinéraire de camping en $region',
      'days': days,
      'region': region,
      'itinerary': List.generate(days, (index) => {
        'day': index + 1,
        'activities': [
          'Randonnée matinale',
          'Déjeuner en plein air',
          'Activité locale',
        ],
        'camping_suggestion': 'Camping recommandé pour la nuit',
        'tips': 'Conseils pour profiter au maximum de cette journée',
      }),
      'total_estimated_cost': (budget ?? 300),
      'highlights': [
        'Découverte de la nature québécoise',
        'Expérience de camping authentique',
        'Activités en plein air',
      ],
    };
  }
  
  // ============================================
  // TRADUCTION
  // ============================================
  
  Future<String> translate(String text, {required String targetLanguage}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // En mode mock, on retourne juste le texte avec une note
    return '[Traduction mock vers $targetLanguage] $text';
  }
  
  // ============================================
  // ANALYSE DE PHOTOS
  // ============================================
  
  Future<Map<String, dynamic>> analyzePhotos(List<String> photoUrls) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return {
      'quality_score': 0.85,
      'suggestions': [
        'Ajouter plus de photos de l\'extérieur',
        'Inclure des photos des équipements',
        'Montrer les vues panoramiques',
      ],
    };
  }
}

