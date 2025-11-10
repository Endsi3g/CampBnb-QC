import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/env_config.dart';
import 'core/constants/app_colors.dart';
import 'core/utils/logger.dart';
import 'services/service_factory.dart';
import 'features/auth/providers/auth_provider.dart';
import 'shared/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Charger les variables d'environnement
  await EnvConfig.load();
  
  // Initialiser les services (réels ou mock selon le mode)
  await ServiceFactory.initializeAll();
  
  // Afficher le mode actuel
  if (EnvConfig.isSandboxMode) {
    appLogger.i('🚀 Mode SANDBOX activé - L\'application fonctionne sans APIs externes');
  } else {
    appLogger.i('🌐 Mode PRODUCTION - Connexion aux APIs réelles');
  }
  
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
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          background: AppColors.backgroundLight,
          surface: AppColors.surfaceLight,
        ),
        fontFamily: 'PlusJakartaSans',
        scaffoldBackgroundColor: AppColors.backgroundLight,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          background: AppColors.backgroundDark,
          surface: AppColors.surfaceDark,
        ),
        fontFamily: 'PlusJakartaSans',
        scaffoldBackgroundColor: AppColors.backgroundDark,
      ),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}

