# Guide d'Installation - Campbnb

## Prérequis

- Flutter SDK 3.0.0 ou supérieur
- Dart 3.0.0 ou supérieur
- Android Studio / Xcode (pour le développement mobile)
- Compte Supabase
- Clé API Google Maps
- Clé API Gemini (gratuite)

## Étapes d'Installation

### 1. Cloner le Projet

```bash
git clone <repository-url>
cd campbnb
```

### 2. Installer les Dépendances

```bash
flutter pub get
```

### 3. Configurer les Variables d'Environnement

Copiez le fichier `.env.example` vers `.env`:

```bash
cp .env.example .env
```

Éditez `.env` et remplissez les valeurs:

```env
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre_cle_anon
GOOGLE_MAPS_API_KEY=votre_cle_google_maps
GEMINI_API_KEY=votre_cle_gemini
```

### 4. Configurer Supabase

1. Créez un projet sur [Supabase](https://supabase.com)
2. Exécutez le script SQL dans `docs/database/schema.sql` dans l'éditeur SQL de Supabase
3. Configurez le storage:
   - Allez dans Storage
   - Créez un bucket nommé `listing-photos`
   - Configurez les politiques d'accès

### 5. Obtenir les Clés API

#### Google Maps API
1. Allez sur [Google Cloud Console](https://console.cloud.google.com)
2. Créez un projet ou sélectionnez-en un
3. Activez l'API Maps SDK for Android et iOS
4. Créez une clé API
5. Ajoutez la clé dans `.env`

#### Gemini API
1. Allez sur [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Créez une clé API (gratuite)
3. Ajoutez la clé dans `.env`

### 6. Générer les Fichiers

Générez les fichiers `.g.dart` nécessaires:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 7. Configuration Android

Dans `android/app/src/main/AndroidManifest.xml`, ajoutez:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
```

### 8. Configuration iOS

Dans `ios/Runner/Info.plist`, ajoutez:

```xml
<key>GMSApiKey</key>
<string>YOUR_GOOGLE_MAPS_API_KEY</string>
```

### 9. Lancer l'Application

```bash
# Android
flutter run

# iOS
flutter run -d ios

# Web (pour test)
flutter run -d chrome
```

## Vérification

1. L'application démarre sans erreur
2. L'écran de connexion s'affiche
3. Vous pouvez créer un compte
4. La liste des campings s'affiche (si des données existent)

## Dépannage

### Erreur: "Supabase non initialisé"
- Vérifiez que `.env` contient les bonnes valeurs
- Vérifiez que `EnvConfig.load()` est appelé dans `main.dart`

### Erreur: "Clé API Gemini non configurée"
- Vérifiez que `GEMINI_API_KEY` est dans `.env`
- Vérifiez que le fichier `.env` est dans le dossier racine

### Erreur de build: "Missing .g.dart files"
- Exécutez: `flutter pub run build_runner build --delete-conflicting-outputs`

### Erreur Google Maps
- Vérifiez que la clé API est correcte
- Vérifiez que les APIs sont activées dans Google Cloud Console
- Vérifiez les restrictions de la clé API

## Prochaines Étapes

1. Créez votre premier compte utilisateur
2. Créez une annonce de test
3. Testez la recherche et les filtres
4. Testez le chatbot IA
5. Testez les réservations

## Support

Pour toute question, consultez:
- [Documentation](./docs/README.md)
- [Architecture](./docs/architecture.md)
- [API](./docs/api.md)

