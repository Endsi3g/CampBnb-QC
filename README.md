# CampBnb-QC

# Campbnb - Application de Réservation de Camping au Québec

Application Flutter mobile permettant de rechercher, réserver et gérer des emplacements de camping au Québec, avec intégration d'intelligence artificielle (Gemini 2.5) pour des recommandations personnalisées.

## 🎯 Objectif

Permettre aux utilisateurs de :
- Rechercher et réserver des emplacements de camping (tentes, chalets, vans, etc.)
- Publier leurs propres annonces de camping
- Bénéficier de recommandations IA personnalisées
- Accéder à un chatbot IA pour l'assistance

## 🛠️ Tech Stack

- **Frontend** : Flutter (Dart) - Cross-platform mobile
- **Backend** : Supabase (Auth, Database, Storage)
- **Géolocalisation** : Google Maps API
- **Paiements** : Stripe (intégration future)
- **Notifications** : Firebase Cloud Messaging
- **IA** : Gemini 2.5 API (gratuite)
- **CI/CD** : GitHub Actions

## 📋 Fonctionnalités MVP

### Pour les Voyageurs
- ✅ Authentification (email, Google, Apple)
- ✅ Feed d'emplacements avec filtres avancés
- ✅ Recherche intelligente avec IA
- ✅ Fiche camping détaillée
- ✅ Réservation (demande sans paiement MVP)
- ✅ Historique de réservations
- ✅ Favoris

### Pour les Hôtes
- ✅ Ajout/modification/suppression d'annonces
- ✅ Gestion des réservations
- ✅ Tableau de bord

### Fonctionnalités IA
- 🤖 Chatbot Gemini pour assistance
- 🤖 Suggestions automatiques personnalisées
- 🤖 Résumé automatique d'avis
- 🤖 Traduction FR/EN
- 🤖 Génération d'itinéraires
- 🤖 Analyse de photos

## 🏗️ Architecture

Le projet suit une architecture par domaines (Clean Architecture) :

```
lib/
├── core/              # Configuration, constants, utils
├── features/          # Modules par fonctionnalité
│   ├── auth/
│   ├── search/
│   ├── booking/
│   ├── listing/
│   └── profile/
├── shared/            # Widgets, services partagés
└── main.dart
```

## 🚀 Installation

1. **Cloner le projet**
```bash
git clone <repository-url>
cd campbnb
```

2. **Installer les dépendances**
```bash
flutter pub get
```

3. **Configurer les variables d'environnement**
```bash
cp .env.example .env
# Remplir les clés API dans .env
```

4. **Générer les fichiers**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

5. **Lancer l'application**
```bash
flutter run
```

## 📱 Configuration

### Supabase
1. Créer un projet sur [Supabase](https://supabase.com)
2. Exécuter le script SQL dans `docs/database/schema.sql`
3. Configurer les politiques RLS (Row Level Security)

### Google Maps
1. Obtenir une clé API Google Maps
2. Configurer dans `android/app/src/main/AndroidManifest.xml` et `ios/Runner/Info.plist`

### Gemini API
1. Obtenir une clé API gratuite sur [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Ajouter dans `.env`

## 📚 Documentation

Voir la documentation complète dans le dossier `docs/` :
- `docs/architecture.md` - Architecture détaillée
- `docs/api.md` - Documentation API
- `docs/database/schema.sql` - Schéma de base de données
- `docs/flows.md` - Flux utilisateur
- `docs/gemini-prompts.md` - Exemples de prompts Gemini

## 🧪 Tests

```bash
flutter test
```

## 📄 Licence

Propriétaire - Campbnb Québec

