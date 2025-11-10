import 'package:logger/logger.dart';

/// Logger global de l'application
final appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

/// Logger pour les erreurs uniquement
final errorLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 5,
    errorMethodCount: 10,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
  level: Level.error,
);

