import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration des variables d'environnement
class EnvConfig {
  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }
  
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
  
  static bool get isConfigured => 
    supabaseUrl.isNotEmpty && 
    supabaseAnonKey.isNotEmpty &&
    googleMapsApiKey.isNotEmpty &&
    geminiApiKey.isNotEmpty;
}

