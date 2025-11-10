import '../core/config/env_config.dart';
import 'supabase_service.dart';
import 'gemini_service.dart';
import 'maps_service.dart';
import 'call_center_service.dart';
import 'localai_service.dart';
import 'handy_service.dart';
import 'mock_supabase_service.dart';
import 'mock_gemini_service.dart';
import 'mock_maps_service.dart';

/// Factory pour obtenir les services appropriés (réels ou mock)
class ServiceFactory {
  static bool get _isSandbox => EnvConfig.isSandboxMode;
  
  // Services Supabase
  static SupabaseService get supabaseService => SupabaseService();
  static MockSupabaseService get mockSupabaseService => MockSupabaseService();
  
  // Services Gemini
  static GeminiService get geminiService => GeminiService();
  static MockGeminiService get mockGeminiService => MockGeminiService();
  
  // Services Maps
  static MapsService get mapsService => MapsService();
  static MockMapsService get mockMapsService => MockMapsService();
  
  // Services intégrés
  static CallCenterService get callCenterService => CallCenterService();
  static LocalAIService get localAIService => LocalAIService();
  static HandyService get handyService => HandyService();
  
  /// Obtenir le service Supabase (réel ou mock)
  static dynamic getSupabaseService() {
    return _isSandbox ? mockSupabaseService : supabaseService;
  }
  
  /// Obtenir le service Gemini (réel ou mock)
  static dynamic getGeminiService() {
    return _isSandbox ? mockGeminiService : geminiService;
  }
  
  /// Obtenir le service Maps (réel ou mock)
  static dynamic getMapsService() {
    return _isSandbox ? mockMapsService : mapsService;
  }
  
  /// Obtenir le service Call Center
  static CallCenterService getCallCenterService() {
    return callCenterService;
  }
  
  /// Obtenir le service LocalAI
  static LocalAIService getLocalAIService() {
    return localAIService;
  }
  
  /// Obtenir le service Handy
  static HandyService getHandyService() {
    return handyService;
  }
  
  /// Initialiser tous les services
  static Future<void> initializeAll() async {
    if (_isSandbox) {
      await mockSupabaseService.initialize();
      mockGeminiService.initialize();
    } else {
      await supabaseService.initialize();
      geminiService.initialize();
    }
    
    // Initialiser les nouveaux services
    callCenterService.initialize();
    localAIService.initialize();
    handyService.initialize();
  }
}

