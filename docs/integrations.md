# Intégrations - Call Center AI, LocalAI et Handy

Ce document décrit l'intégration des trois repositories externes dans l'application Campbnb.

## 📋 Vue d'ensemble

Trois repositories ont été intégrés pour étendre les fonctionnalités de l'application :

1. **Call Center AI** (Microsoft) - Système de centre d'appel avec IA
2. **LocalAI** (mudler) - Alternative locale à OpenAI/Gemini
3. **Handy** (cjpais) - Transcription vocale offline

## 🏗️ Architecture

```
┌─────────────────┐
│  Flutter App    │
│  (Frontend)     │
└────────┬────────┘
         │
         │ HTTP/HTTPS
         │
┌────────▼─────────────────────────┐
│  Backend API (Python/Flask)     │
│  backend/api_server.py          │
└────────┬────────────────────────┘
         │
    ┌────┴────┬──────────┬──────────┐
    │         │          │          │
┌───▼───┐ ┌──▼───┐  ┌───▼───┐  ┌───▼───┐
│ Call  │ │LocalAI│  │ Handy │  │  ...  │
│Center │ │       │  │       │  │       │
│  AI   │ │       │  │       │  │       │
└───────┘ └───────┘  └───────┘  └───────┘
```

## 📦 Installation

### Prérequis

- Python 3.9+
- Node.js 18+ (pour Handy si nécessaire)
- Docker (optionnel, pour LocalAI)

### 1. Cloner les repositories

Les repositories sont déjà clonés dans le dossier `integrations/` :

```bash
integrations/
├── call-center-ai/    # Microsoft Call Center AI
├── handy/             # Handy Speech-to-Text
└── localai/           # LocalAI Server
```

### 2. Installer le backend API

```bash
cd backend
python -m venv venv
source venv/bin/activate  # Sur Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Configurer les variables d'environnement

Créer un fichier `.env` à la racine du projet :

```env
# Backend API
PORT=5000
DEBUG=false

# Call Center AI
CALL_CENTER_API_BASE_URL=http://localhost:5000/api/call-center
CALL_CENTER_API_KEY=your_api_key_here

# LocalAI
LOCALAI_BASE_URL=http://localhost:8080
LOCALAI_API_KEY=
LOCALAI_MODEL=gpt-3.5-turbo

# Handy
HANDY_API_BASE_URL=http://localhost:3000
HANDY_API_KEY=
```

### 4. Démarrer les services

#### Backend API

```bash
cd backend
python api_server.py
```

Le serveur démarre sur `http://localhost:5000`

#### LocalAI (optionnel)

```bash
cd integrations/localai
docker-compose up -d
```

Ou suivre les instructions dans `integrations/localai/README.md`

#### Handy (optionnel)

Si vous voulez utiliser Handy comme service séparé, suivre les instructions dans `integrations/handy/README.md`

## 🔧 Configuration Flutter

### Variables d'environnement

Ajouter dans `.env` :

```env
# Call Center AI
CALL_CENTER_API_BASE_URL=http://localhost:5000/api/call-center
CALL_CENTER_API_KEY=your_api_key_here

# LocalAI
LOCALAI_BASE_URL=http://localhost:8080
LOCALAI_API_KEY=
LOCALAI_MODEL=gpt-3.5-turbo

# Handy
HANDY_API_BASE_URL=http://localhost:3000
HANDY_API_KEY=
```

### Utilisation dans le code

```dart
import 'package:campbnb/services/service_factory.dart';

// Call Center AI
final callCenter = ServiceFactory.getCallCenterService();
final result = await callCenter.initiateCall(
  phoneNumber: '+1234567890',
  task: 'Aider le client avec sa réservation',
  claim: CallCenterService.createBookingSupportClaim(),
);

// LocalAI
final localAI = ServiceFactory.getLocalAIService();
final response = await localAI.chat(
  message: 'Bonjour, pouvez-vous m\'aider?',
  systemPrompt: 'Tu es un assistant pour Campbnb',
);

// Handy
final handy = ServiceFactory.getHandyService();
final transcription = await handy.transcribeAudio(
  audioFile: '/path/to/audio.wav',
  language: 'fr',
  model: 'whisper-small',
);
```

## 📚 Services détaillés

### 1. Call Center AI

**Description** : Permet de passer des appels téléphoniques avec un assistant IA pour le support client.

**Fonctionnalités** :
- Initier des appels sortants
- Collecter des données structurées pendant l'appel
- Obtenir le statut et les données d'un appel

**Exemple d'utilisation** :

```dart
final callCenter = ServiceFactory.getCallCenterService();

// Initier un appel de support réservation
final result = await callCenter.initiateCall(
  phoneNumber: '+14161234567',
  task: 'Aider le client avec sa réservation de camping. Collecter les informations sur le problème.',
  claim: CallCenterService.createBookingSupportClaim(),
  botName: 'Campy',
  botCompany: 'Campbnb',
);

print('Appel initié: ${result['call_id']}');

// Vérifier le statut
final status = await callCenter.getCallStatus(result['call_id']);
print('Statut: ${status['status']}');

// Récupérer les données collectées
final data = await callCenter.getCallData(result['call_id']);
print('Données: ${data['claim']}');
```

### 2. LocalAI

**Description** : Alternative locale à Gemini/OpenAI pour les fonctionnalités IA. Fonctionne entièrement en local.

**Fonctionnalités** :
- Chat avec IA locale
- Recommandations personnalisées
- Résumé d'avis
- Traduction
- Génération d'itinéraires

**Exemple d'utilisation** :

```dart
final localAI = ServiceFactory.getLocalAIService();

// Chat simple
final response = await localAI.chat(
  message: 'Quels sont les meilleurs campings au Québec?',
  systemPrompt: 'Tu es un assistant expert en camping au Québec.',
);

// Recommandations
final recommendations = await localAI.getRecommendations(
  userId: 'user123',
  region: 'Charlevoix',
  budget: 100,
  preferredType: 'tent',
);

// Lister les modèles disponibles
final models = await localAI.listModels();
print('Modèles disponibles: $models');
```

### 3. Handy

**Description** : Service de transcription vocale offline. Permet de convertir des fichiers audio en texte.

**Fonctionnalités** :
- Transcription de fichiers audio
- Support de plusieurs modèles (Whisper, Parakeet)
- Détection automatique de langue
- Traitement local (pas de cloud)

**Exemple d'utilisation** :

```dart
final handy = ServiceFactory.getHandyService();

// Vérifier la disponibilité
final isAvailable = await handy.checkHealth();
if (!isAvailable) {
  print('Service Handy non disponible');
  return;
}

// Transcrire un fichier audio
final transcription = await handy.transcribeAudio(
  audioFile: '/path/to/recording.wav',
  language: 'fr',
  model: 'whisper-small',
);

print('Transcription: $transcription');

// Obtenir les modèles disponibles
final models = await handy.getAvailableModels();
print('Modèles: $models');
```

## 🔐 Sécurité

### Authentification

Tous les endpoints du backend API doivent être protégés en production :

1. **API Keys** : Utiliser des clés API pour authentifier les requêtes
2. **HTTPS** : Toujours utiliser HTTPS en production
3. **Rate Limiting** : Implémenter un rate limiting pour éviter les abus
4. **CORS** : Configurer CORS pour n'autoriser que les domaines autorisés

### Variables d'environnement

Ne jamais commiter les fichiers `.env` contenant des clés API. Ils sont déjà dans `.gitignore`.

## 🧪 Tests

### Tester le backend API

```bash
# Health check
curl http://localhost:5000/health

# Test Call Center AI
curl -X POST http://localhost:5000/api/call-center/call \
  -H "Content-Type: application/json" \
  -d '{"phone_number": "+1234567890", "task": "Test call"}'

# Test LocalAI
curl http://localhost:5000/api/localai/models

# Test Handy
curl http://localhost:5000/api/handy/health
```

## 🐛 Dépannage

### Le backend API ne démarre pas

1. Vérifier que Python 3.9+ est installé
2. Vérifier que toutes les dépendances sont installées : `pip install -r requirements.txt`
3. Vérifier que le port 5000 n'est pas déjà utilisé

### LocalAI ne répond pas

1. Vérifier que LocalAI est démarré : `curl http://localhost:8080/v1/models`
2. Vérifier la variable `LOCALAI_BASE_URL` dans `.env`
3. Consulter les logs LocalAI

### Handy ne répond pas

1. Vérifier que le service Handy est démarré
2. Vérifier la variable `HANDY_API_BASE_URL` dans `.env`
3. Vérifier les permissions d'accès au microphone (si nécessaire)

## 📝 Notes importantes

1. **Call Center AI** nécessite une configuration Azure complète pour fonctionner en production
2. **LocalAI** nécessite des ressources système importantes (RAM, CPU) pour fonctionner efficacement
3. **Handy** fonctionne mieux avec un GPU pour la transcription rapide

## 🔗 Ressources

- [Call Center AI Documentation](https://github.com/microsoft/call-center-ai)
- [LocalAI Documentation](https://localai.io/)
- [Handy Documentation](https://github.com/cjpais/Handy)

## 📄 Licence

Chaque repository intégré a sa propre licence. Vérifier les fichiers LICENSE dans chaque dossier `integrations/`.

