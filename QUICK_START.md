# 🚀 Guide de démarrage rapide - Intégrations

Ce guide vous aide à configurer rapidement les intégrations (Call Center AI, LocalAI, Handy) dans votre application Campbnb.

## 📋 Prérequis

- Python 3.9+ installé
- Flutter SDK installé
- Git installé

## ⚡ Démarrage rapide

### 1. Configurer les variables d'environnement

Le fichier `.env` a été créé automatiquement. Modifiez-le avec vos clés API :

```bash
# Éditer le fichier .env
# Remplacer les valeurs "your-xxx-key" par vos vraies clés API
```

**Variables importantes à configurer :**
- `SUPABASE_URL` et `SUPABASE_ANON_KEY` - Pour Supabase
- `GOOGLE_MAPS_API_KEY` - Pour Google Maps
- `GEMINI_API_KEY` - Pour Gemini AI
- `CALL_CENTER_API_BASE_URL` - URL du backend API (par défaut: http://localhost:5000)
- `LOCALAI_BASE_URL` - URL de LocalAI (par défaut: http://localhost:8080)
- `HANDY_API_BASE_URL` - URL de Handy (par défaut: http://localhost:3000)

### 2. Installer le backend API

#### Sur Windows (PowerShell) :

```powershell
cd backend
.\setup.ps1
```

#### Sur Linux/macOS :

```bash
cd backend
chmod +x setup.sh
./setup.sh
```

#### Installation manuelle :

```bash
cd backend
python -m venv venv

# Windows:
venv\Scripts\activate

# Linux/macOS:
source venv/bin/activate

pip install -r requirements.txt
```

### 3. Démarrer le backend API

#### Sur Windows (PowerShell) :

```powershell
cd backend
.\start.ps1
```

#### Sur Linux/macOS :

```bash
cd backend
chmod +x start.sh
./start.sh
```

#### Démarrage manuel :

```bash
cd backend

# Windows:
venv\Scripts\activate

# Linux/macOS:
source venv/bin/activate

python api_server.py
```

Le serveur démarre sur `http://localhost:5000`

### 4. Démarrer LocalAI (optionnel)

Si vous voulez utiliser LocalAI au lieu de Gemini :

```bash
cd integrations/localai
docker-compose up -d
```

Ou suivre les instructions dans `integrations/localai/README.md`

### 5. Démarrer Handy (optionnel)

Si vous voulez utiliser Handy pour la transcription vocale :

Suivre les instructions dans `integrations/handy/README.md`

### 6. Utiliser les services dans Flutter

Les services sont déjà initialisés automatiquement dans `main.dart`. Vous pouvez les utiliser directement :

```dart
import 'package:campbnb/services/service_factory.dart';

// Call Center AI
final callCenter = ServiceFactory.getCallCenterService();
final result = await callCenter.initiateCall(
  phoneNumber: '+14161234567',
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

### 7. Tester les intégrations

Un exemple d'utilisation est disponible dans `lib/examples/integrations_example.dart`.

Pour l'utiliser, ajoutez une route dans votre router :

```dart
GoRoute(
  path: '/integrations-example',
  builder: (context, state) => const IntegrationsExample(),
),
```

## ✅ Vérification

### Vérifier que le backend API fonctionne :

```bash
curl http://localhost:5000/health
```

Vous devriez recevoir :
```json
{
  "status": "healthy",
  "services": {
    "call_center_ai": "available",
    "localai": "http://localhost:8080",
    "handy": "http://localhost:3000"
  }
}
```

### Vérifier LocalAI :

```bash
curl http://localhost:8080/v1/models
```

### Vérifier Handy :

```bash
curl http://localhost:3000/health
```

## 🐛 Dépannage

### Le backend API ne démarre pas

1. Vérifier que Python est installé : `python --version`
2. Vérifier que l'environnement virtuel est créé : `ls backend/venv` (ou `dir backend\venv` sur Windows)
3. Réinstaller les dépendances : `pip install -r requirements.txt`

### Erreur "Module not found"

```bash
cd backend
source venv/bin/activate  # ou venv\Scripts\activate sur Windows
pip install -r requirements.txt
```

### Le service ne répond pas

1. Vérifier que le service est démarré
2. Vérifier les variables d'environnement dans `.env`
3. Vérifier les logs du service

## 📚 Documentation complète

Pour plus de détails, consultez :
- `docs/integrations.md` - Guide complet d'intégration
- `backend/README.md` - Documentation du backend API
- `INTEGRATION_SUMMARY.md` - Résumé de l'intégration

## 🎯 Prochaines étapes

1. ✅ Configurer les variables d'environnement
2. ✅ Installer et démarrer le backend API
3. ✅ Tester les services avec `IntegrationsExample`
4. ✅ Intégrer les services dans vos écrans Flutter
5. ✅ Configurer les services optionnels (LocalAI, Handy)

---

**Besoin d'aide ?** Consultez la documentation dans `docs/integrations.md`

