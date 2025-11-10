import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/config/env_config.dart';
import '../core/utils/logger.dart';

/// Service pour l'intégration avec Call Center AI (Microsoft)
/// Permet de passer des appels téléphoniques avec un assistant IA
class CallCenterService {
  static final CallCenterService _instance = CallCenterService._internal();
  factory CallCenterService() => _instance;
  CallCenterService._internal();

  String? _baseUrl;
  String? _apiKey;

  void initialize() {
    _baseUrl = EnvConfig.callCenterApiBaseUrl;
    _apiKey = EnvConfig.callCenterApiKey;
    
    if (_baseUrl == null || _baseUrl!.isEmpty) {
      appLogger.w('URL API Call Center non configurée');
    }
    if (_apiKey == null || _apiKey!.isEmpty) {
      appLogger.w('Clé API Call Center non configurée');
    }
  }

  /// Initier un appel sortant avec l'assistant IA
  /// 
  /// [phoneNumber] : Numéro de téléphone à appeler (format international)
  /// [task] : Description de la tâche pour l'assistant
  /// [claim] : Schéma de données à collecter pendant l'appel
  /// [botName] : Nom du bot (optionnel, défaut: "Campy")
  /// [botCompany] : Nom de l'entreprise (optionnel, défaut: "Campbnb")
  Future<Map<String, dynamic>> initiateCall({
    required String phoneNumber,
    required String task,
    List<Map<String, dynamic>>? claim,
    String? botName,
    String? botCompany,
    String? agentPhoneNumber,
  }) async {
    if (_baseUrl == null || _apiKey == null) {
      throw Exception('Call Center API non configurée');
    }

    try {
      final url = Uri.parse('$_baseUrl/call');
      
      final body = {
        'phone_number': phoneNumber,
        'task': task,
        'bot_name': botName ?? 'Campy',
        'bot_company': botCompany ?? 'Campbnb',
        if (agentPhoneNumber != null) 'agent_phone_number': agentPhoneNumber,
        if (claim != null) 'claim': claim,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        appLogger.i('Appel initié avec succès: ${data['call_id']}');
        return data;
      } else {
        errorLogger.e('Erreur API Call Center: ${response.statusCode} - ${response.body}');
        throw Exception('Erreur API Call Center: ${response.statusCode}');
      }
    } catch (e) {
      errorLogger.e('Erreur initiation appel: $e');
      rethrow;
    }
  }

  /// Obtenir le statut d'un appel
  Future<Map<String, dynamic>> getCallStatus(String callId) async {
    if (_baseUrl == null || _apiKey == null) {
      throw Exception('Call Center API non configurée');
    }

    try {
      final url = Uri.parse('$_baseUrl/call/$callId/status');
      
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_apiKey',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        errorLogger.e('Erreur récupération statut: ${response.statusCode}');
        throw Exception('Erreur récupération statut: ${response.statusCode}');
      }
    } catch (e) {
      errorLogger.e('Erreur getCallStatus: $e');
      rethrow;
    }
  }

  /// Obtenir les données collectées pendant un appel
  Future<Map<String, dynamic>> getCallData(String callId) async {
    if (_baseUrl == null || _apiKey == null) {
      throw Exception('Call Center API non configurée');
    }

    try {
      final url = Uri.parse('$_baseUrl/call/$callId/data');
      
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_apiKey',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        errorLogger.e('Erreur récupération données: ${response.statusCode}');
        throw Exception('Erreur récupération données: ${response.statusCode}');
      }
    } catch (e) {
      errorLogger.e('Erreur getCallData: $e');
      rethrow;
    }
  }

  /// Créer un schéma de claim pour un appel de support réservation
  static List<Map<String, dynamic>> createBookingSupportClaim() {
    return [
      {
        'name': 'booking_id',
        'type': 'text',
        'description': 'Numéro de réservation',
      },
      {
        'name': 'issue_type',
        'type': 'text',
        'description': 'Type de problème (annulation, modification, question)',
      },
      {
        'name': 'preferred_solution',
        'type': 'text',
        'description': 'Solution préférée par le client',
      },
      {
        'name': 'urgency',
        'type': 'text',
        'description': 'Niveau d\'urgence (faible, moyen, élevé)',
      },
    ];
  }

  /// Créer un schéma de claim pour un appel d'assistance générale
  static List<Map<String, dynamic>> createGeneralSupportClaim() {
    return [
      {
        'name': 'question_type',
        'type': 'text',
        'description': 'Type de question (réservation, paiement, annulation, autre)',
      },
      {
        'name': 'user_id',
        'type': 'text',
        'description': 'ID utilisateur',
      },
      {
        'name': 'resolution_status',
        'type': 'text',
        'description': 'Statut de résolution',
      },
    ];
  }
}

