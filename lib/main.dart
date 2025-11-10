import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/env_config.dart';
import 'core/constants/app_colors.dart';
import 'services/supabase_service.dart';
import 'services/gemini_service.dart';
import 'features/auth/providers/auth_provider.dart';
import 'shared/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Charger les variables d'environnement
  await EnvConfig.load();
  
  // Initialiser Supabase
  await SupabaseService().initialize();
  
  // Initialiser Gemini
  GeminiService().initialize();
  
  runApp(
    const ProviderScope(
      child: CampbnbApp(),
    ),
  );
}

class CampbnbApp extends ConsumerWidget {
  const CampbnbApp({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    
    return MaterialApp.router(
      title: 'Campbnb',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.forestGreen,
          brightness: Brightness.light,
        ),
        fontFamily: 'Montserrat',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.forestGreen,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Montserrat',
      ),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}

