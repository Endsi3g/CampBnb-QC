import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Configuration des variables d'environnement
class EnvConfig {
  static bool _sandboxMode = false;
  static bool _initialized = false;
  
  static Future<void> load() async {
    if (_initialized) return;
    
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      // Si .env n'existe pas, on active le mode sandbox
      _sandboxMode = true;
    }
    
    // Vérifier si le mode sandbox est explicitement activé
    final prefs = await SharedPreferences.getInstance();
    _sandboxMode = prefs.getBool('sandbox_mode') ?? 
                   dotenv.env['SANDBOX_MODE'] == 'true' ||
                   !isConfigured;
    
    _initialized = true;
  }
  
  /// Activer/désactiver le mode sandbox
  static Future<void> setSandboxMode(bool enabled) async {
    _sandboxMode = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sandbox_mode', enabled);
  }
  
  /// Vérifier si on est en mode sandbox
  static bool get isSandboxMode => _sandboxMode;
  
  // Supabase
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  
  // Google Maps
  static String get googleMapsApiKey => dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  
  // Gemini AI
  static String get geminiApiKey => dotenv.env['GEMINI_API_KEY'] ?? '';
  
  // Stripe
  static String get stripePublishableKey => dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
  
  // Firebase
  static String get firebaseProjectId => dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  
  // Call Center AI
  static String get callCenterApiBaseUrl => dotenv.env['CALL_CENTER_API_BASE_URL'] ?? '';
  static String get callCenterApiKey => dotenv.env['CALL_CENTER_API_KEY'] ?? '';
  
  // LocalAI
  static String get localAIBaseUrl => dotenv.env['LOCALAI_BASE_URL'] ?? 'http://localhost:8080';
  static String get localAIApiKey => dotenv.env['LOCALAI_API_KEY'] ?? '';
  static String? get localAIModel => dotenv.env['LOCALAI_MODEL'];
  
  // Handy (Speech-to-Text)
  static String get handyApiBaseUrl => dotenv.env['HANDY_API_BASE_URL'] ?? '';
  static String get handyApiKey => dotenv.env['HANDY_API_KEY'] ?? '';
  
  static bool get isConfigured => 
    supabaseUrl.isNotEmpty && 
    supabaseAnonKey.isNotEmpty &&
    googleMapsApiKey.isNotEmpty &&
    geminiApiKey.isNotEmpty;
}

