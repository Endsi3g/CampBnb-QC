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

## Déploiement

### Build Android
```bash
flutter build apk --release
```

### Build iOS
```bash
flutter build ios --release
```

### CI/CD
- GitHub Actions configuré
- Tests automatiques
- Build automatique sur push

