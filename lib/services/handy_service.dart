import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../core/config/env_config.dart';
import '../core/utils/logger.dart';

/// Service pour l'intégration avec Handy (transcription vocale offline)
/// Permet de transcrire des fichiers audio en texte
class HandyService {
  static final HandyService _instance = HandyService._internal();
  factory HandyService() => _instance;
  HandyService._internal();

  String? _baseUrl;
  String? _apiKey;

  void initialize() {
    _baseUrl = EnvConfig.handyApiBaseUrl;
    _apiKey = EnvConfig.handyApiKey;
    
    if (_baseUrl == null || _baseUrl!.isEmpty) {
      appLogger.w('URL API Handy non configurée');
    }
  }

  /// Transcrire un fichier audio en texte
  /// 
  /// [audioFile] : Chemin vers le fichier audio
  /// [language] : Code langue (fr, en, etc.) - optionnel pour détection auto
  /// [model] : Modèle à utiliser (whisper-small, whisper-medium, parakeet-v3, etc.)
  Future<String> transcribeAudio({
    required String audioFile,
    String? language,
    String? model,
  }) async {
    if (_baseUrl == null) {
      throw Exception('Handy API non configurée');
    }

    try {
      final url = Uri.parse('$_baseUrl/api/transcribe');
      
      final file = File(audioFile);
      if (!await file.exists()) {
        throw Exception('Fichier audio introuvable: $audioFile');
      }

      final request = http.MultipartRequest('POST', url);
      
      // Ajouter le fichier audio
      request.files.add(
        await http.MultipartFile.fromPath('audio', audioFile),
      );
      
      // Ajouter les paramètres
      if (language != null) {
        request.fields['language'] = language;
      }
      if (model != null) {
        request.fields['model'] = model;
      }
      
      if (_apiKey != null && _apiKey!.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $_apiKey';
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final transcription = data['text'] as String? ?? data['transcription'] as String? ?? '';
        appLogger.i('Transcription réussie: ${transcription.length} caractères');
        return transcription;
      } else {
        errorLogger.e('Erreur API Handy: ${response.statusCode} - ${response.body}');
        throw Exception('Erreur transcription: ${response.statusCode}');
      }
    } catch (e) {
      errorLogger.e('Erreur transcription Handy: $e');
      rethrow;
    }
  }

  /// Transcrire un fichier audio depuis les bytes
  Future<String> transcribeAudioBytes({
    required List<int> audioBytes,
    required String filename,
    String? language,
    String? model,
  }) async {
    if (_baseUrl == null) {
      throw Exception('Handy API non configurée');
    }

    try {
      // Sauvegarder temporairement le fichier
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$filename');
      await tempFile.writeAsBytes(audioBytes);

      try {
        return await transcribeAudio(
          audioFile: tempFile.path,
          language: language,
          model: model,
        );
      } finally {
        // Nettoyer le fichier temporaire
        if (await tempFile.exists()) {
          await tempFile.delete();
        }
      }
    } catch (e) {
      errorLogger.e('Erreur transcription bytes: $e');
      rethrow;
    }
  }

  /// Obtenir les modèles disponibles
  Future<List<String>> getAvailableModels() async {
    if (_baseUrl == null) {
      throw Exception('Handy API non configurée');
    }

    try {
      final url = Uri.parse('$_baseUrl/api/models');
      
      final headers = <String, String>{};
      if (_apiKey != null && _apiKey!.isNotEmpty) {
        headers['Authorization'] = 'Bearer $_apiKey';
      }

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<String>.from(data['models'] ?? []);
      } else {
        errorLogger.e('Erreur récupération modèles: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      errorLogger.e('Erreur getAvailableModels: $e');
      return [];
    }
  }

  /// Vérifier si le service est disponible
  Future<bool> checkHealth() async {
    if (_baseUrl == null) {
      return false;
    }

    try {
      final url = Uri.parse('$_baseUrl/health');
      final response = await http.get(url).timeout(
        const Duration(seconds: 5),
      );
      return response.statusCode == 200;
    } catch (e) {
      appLogger.w('Handy service non disponible: $e');
      return false;
    }
  }
}

