# Architecture - Campbnb

## Vue d'ensemble

Campbnb suit une architecture par domaines (Domain-Driven Design) avec une séparation claire des responsabilités.

## Structure du Projet

```
lib/
├── core/                    # Configuration et utilitaires centraux
│   ├── config/             # Configuration (env, constants)
│   ├── constants/          # Constantes de l'application
│   └── utils/              # Utilitaires (logger, helpers)
│
├── features/               # Modules par fonctionnalité
│   ├── auth/              # Authentification
│   │   ├── providers/     # Providers Riverpod
│   │   └── screens/       # Écrans d'authentification
│   │
│   ├── home/              # Accueil
│   │   └── screens/
│   │
│   ├── search/            # Recherche et filtres
│   │   ├── providers/
│   │   └── screens/
│   │
│   ├── listing/           # Gestion des annonces
│   │   ├── providers/
│   │   └── screens/
│   │
│   ├── booking/           # Réservations
│   │   ├── providers/
│   │   └── screens/
│   │
│   ├── profile/           # Profil utilisateur
│   │   └── screens/
│   │
│   └── ai/                # Fonctionnalités IA
│       ├── providers/
│       └── screens/
│
├── models/                 # Modèles de données
│   ├── profile_model.dart
│   ├── listing_model.dart
│   ├── booking_model.dart
│   └── review_model.dart
│
├── services/              # Services backend
│   ├── supabase_service.dart
│   ├── gemini_service.dart
│   └── maps_service.dart
│
├── shared/                # Code partagé
│   ├── widgets/           # Widgets réutilisables
│   └── routing/           # Navigation (GoRouter)
│
└── main.dart              # Point d'entrée
```

## Principes Architecturaux

### 1. Séparation des Responsabilités

- **Models** : Structures de données pures
- **Services** : Logique métier et communication avec les APIs
- **Providers** : Gestion d'état (Riverpod)
- **Screens** : Interface utilisateur
- **Widgets** : Composants UI réutilisables

### 2. Gestion d'État avec Riverpod

Riverpod est utilisé pour :
- Gestion de l'état global
- Injection de dépendances
- Cache et optimisation des requêtes
- État réactif

**Exemple de Provider :**
```dart
@riverpod
Future<List<ListingModel>> searchListings(SearchListingsRef ref) async {
  final filters = ref.watch(searchFiltersProvider);
  return await supabase.getListings(filters: filters);
}
```

### 3. Services Layer

Les services encapsulent toute la logique de communication avec les APIs externes :

- **SupabaseService** : Backend, authentification, base de données
- **GeminiService** : Intégration IA (chatbot, recommandations)
- **MapsService** : Géolocalisation et cartes

### 4. Navigation avec GoRouter

Navigation déclarative et type-safe :

```dart
GoRoute(
  path: '/listing/:id',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return ListingDetailScreen(listingId: id);
  },
)
```

## Flux de Données

```
UI (Screen) 
  ↓
Provider (Riverpod)
  ↓
Service (Supabase/Gemini/Maps)
  ↓
API/Backend
  ↓
Response
  ↓
Model
  ↓
Provider State Update
  ↓
UI Rebuild
```

## Sécurité

### Authentification
- Supabase Auth avec email/password
- Support Google Sign-In et Apple Sign-In
- JWT tokens gérés automatiquement

### Row Level Security (RLS)
- Politiques RLS configurées dans Supabase
- Accès aux données basé sur l'utilisateur connecté
- Vérification côté serveur

### Variables d'Environnement
- Clés API stockées dans `.env`
- `.env` exclu du versioning
- Validation au démarrage de l'app

## Performance

### Optimisations
- **Cached Network Images** : Cache des images
- **Lazy Loading** : Chargement à la demande
- **Pagination** : Limite des résultats
- **Riverpod** : Cache automatique des providers

### Offline Support
- Favoris en cache local
- Consultation hors ligne des données mises en cache

## Tests

### Structure Recommandée
```
test/
├── unit/
│   ├── models/
│   ├── services/
│   └── providers/
├── widget/
│   └── screens/
└── integration/
    └── flows/
```

## Scalabilité

### Points d'Extension
1. **Nouveaux Features** : Créer un nouveau dossier dans `features/`
2. **Nouveaux Services** : Ajouter dans `services/`
3. **Nouveaux Modèles** : Ajouter dans `models/`

### Bonnes Pratiques
- Un provider par feature
- Services en singleton
- Widgets réutilisables dans `shared/`
- Constants centralisées dans `core/constants/`

## Architecture GitHub

### Structure du Dépôt

```
campbnb/
├── .github/
│   └── workflows/              # GitHub Actions workflows
│       ├── auto-deploy.yml     # CI/CD principal (build, test, deploy)
│       ├── flutter.yml         # Tests et builds Flutter
│       ├── dart.yml            # Tests Dart
│       ├── docker-publish.yml  # Publication Docker images
│       ├── cmake-single-platform.yml  # (désactivé)
│       └── msbuild.yml         # (désactivé)
│
├── backend/                    # API Backend Python
│   ├── api_server.py          # Serveur API FastAPI
│   ├── Dockerfile             # Image Docker
│   ├── docker-compose.example.yml
│   └── requirements.txt       # Dépendances Python
│
├── lib/                        # Code source Flutter
│   ├── core/                  # Configuration centrale
│   ├── features/              # Modules par fonctionnalité
│   ├── models/                # Modèles de données
│   ├── services/              # Services backend
│   ├── repositories/         # Couche d'accès aux données
│   ├── shared/                # Code partagé
│   └── examples/              # Exemples d'intégration
│
├── docs/                       # Documentation
│   ├── architecture.md        # Ce fichier
│   ├── api.md                 # Documentation API
│   ├── database/              # Schémas de base de données
│   ├── integrations.md        # Guide d'intégrations
│   └── GITHUB_CONTAINER_REGISTRY.md
│
├── android/                    # Configuration Android
├── ios/                        # Configuration iOS
├── web/                        # Configuration Web
├── windows/                    # Configuration Windows
├── linux/                     # Configuration Linux
└── macos/                      # Configuration macOS
```

### Workflows GitHub Actions

#### 1. Auto Deploy (`auto-deploy.yml`)

**Déclencheurs :**
- Push sur `main`
- Pull requests vers `main`
- Déclenchement manuel (`workflow_dispatch`)

**Jobs :**

**a) Build & Test**
- Setup Flutter 3.24.0
- Installation des dépendances
- Vérification du formatage
- Analyse statique (`flutter analyze`)
- Exécution des tests
- Build APK Android
- Build Web

**b) Deploy**
- S'exécute uniquement sur push vers `main`
- Build de production (APK + Web)
- Upload des artefacts
- Création de release si tag présent

#### 2. Flutter CI (`flutter.yml`)

**Déclencheurs :**
- Push sur `main`
- Pull requests vers `main`

**Actions :**
- Tests et analyse du code
- Build multi-plateformes (Android, iOS, Web)
- Vérification de la qualité du code

#### 3. Docker Publish (`docker-publish.yml`)

**Déclencheurs :**
- Push sur `main` (si backend modifié)
- Création de tags

**Actions :**
- Build d'images Docker pour le backend
- Publication vers GitHub Container Registry
- Tagging automatique (latest, version, sha)

### Stratégie de Branches

```
main                    # Branche principale (production)
  │
  ├── feature/*        # Nouvelles fonctionnalités
  ├── fix/*            # Corrections de bugs
  ├── hotfix/*         # Corrections urgentes
  └── develop          # Branche de développement (optionnel)
```

**Règles :**
- `main` est toujours déployable
- Pull requests obligatoires pour merger
- Tests automatiques avant merge
- Protection de branche activée

### Secrets GitHub

**Secrets configurés :**
- `GITHUB_TOKEN` : Token d'authentification GitHub
- (À ajouter) `SUPABASE_URL` : URL du projet Supabase
- (À ajouter) `SUPABASE_ANON_KEY` : Clé anonyme Supabase
- (À ajouter) `GEMINI_API_KEY` : Clé API Gemini
- (À ajouter) `GOOGLE_MAPS_API_KEY` : Clé API Google Maps

**Configuration :**
1. GitHub → Settings → Secrets and variables → Actions
2. Ajouter les secrets nécessaires
3. Utilisation dans les workflows : `${{ secrets.SECRET_NAME }}`

### CI/CD Pipeline

```
┌─────────────────┐
│  Code Push      │
│  (Git Push)     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  GitHub Actions │
│  Trigger        │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Build & Test   │
│  - Flutter      │
│  - Dependencies │
│  - Tests        │
└────────┬────────┘
         │
         ├─── Succès ───► Deploy ───► Artifacts
         │
         └─── Échec ───► Notification ───► Issue
```

### Automatisation Git

**Hooks Git configurés :**
- `.git/hooks/post-commit` : Push automatique après commit
- `.git/hooks/post-commit.ps1` : Version PowerShell pour Windows

**Scripts disponibles :**
- `auto-push.ps1` : Push manuel avec vérifications
- `watch-changes.ps1` : Surveillance continue et push automatique
- `push-now.bat` : Script batch pour double-clic

**Fonctionnement :**
1. Commit local → Hook déclenché
2. Vérification des changements
3. Pull automatique (rebase)
4. Push vers GitHub
5. GitHub Actions déclenché

### Structure des Repositories

**Pattern Repository :**
```
lib/repositories/
├── booking_repository.dart    # Accès aux données de réservation
├── favorite_repository.dart   # Gestion des favoris
├── listing_repository.dart    # Gestion des annonces
├── profile_repository.dart    # Gestion des profils
└── search_repository.dart     # Recherche et filtres
```

**Avantages :**
- Séparation des responsabilités
- Testabilité améliorée
- Abstraction de la source de données
- Facilite le mock pour les tests

### Intégrations Externes

**Repositories intégrés :**
- `integrations/call-center-ai/` : Assistant IA pour appels
- `integrations/handy/` : Transcription vocale offline
- `integrations/localai/` : IA locale

**Services :**
- `CallCenterService` : Intégration Call Center AI
- `HandyService` : Intégration Handy
- `LocalAIService` : Intégration LocalAI

### Sécurité GitHub

**Protection de branche :**
- Push protection activée (détection de secrets)
- Require pull request reviews
- Require status checks to pass
- Require branches to be up to date

**Secret Scanning :**
- Détection automatique des tokens exposés
- Blocage des push contenant des secrets
- Alertes de sécurité

### Monitoring et Notifications

**GitHub Actions :**
- Statut des workflows visible dans l'onglet Actions
- Notifications par email en cas d'échec
- Badges de statut disponibles

**Artifacts :**
- APK Android stocké après build
- Build Web disponible en téléchargement
- Images Docker publiées sur GHCR

## Déploiement

### Build Android
```bash
flutter build apk --release
```

### Build iOS
```bash
flutter build ios --release
```

### Build Web
```bash
flutter build web --release
```

### CI/CD Automatique
- **GitHub Actions** configuré avec 3 workflows principaux
- **Tests automatiques** à chaque push
- **Build automatique** sur push vers `main`
- **Déploiement automatique** des artefacts
- **Docker images** publiées automatiquement

### Déploiement Manuel

**Backend API :**
```bash
cd backend
docker build -t campbnb-api .
docker run -p 8000:8000 campbnb-api
```

**Flutter App :**
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

