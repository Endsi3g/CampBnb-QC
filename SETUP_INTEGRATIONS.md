# 🔧 Configuration des intégrations - Instructions complètes

## ✅ Ce qui a été fait

1. ✅ Fichier `.env` créé avec toutes les variables nécessaires
2. ✅ Scripts d'installation créés (`backend/setup.ps1` et `backend/setup.sh`)
3. ✅ Scripts de démarrage créés (`backend/start.ps1` et `backend/start.sh`)
4. ✅ Exemple d'utilisation créé (`lib/examples/integrations_example.dart`)
5. ✅ Guide de démarrage rapide créé (`QUICK_START.md`)

## 🚀 Instructions d'installation

### Étape 1: Configurer les variables d'environnement

Le fichier `.env` a été créé. **Modifiez-le** avec vos vraies clés API :

```bash
# Ouvrir .env dans un éditeur
# Remplacer toutes les valeurs "your-xxx-key" par vos vraies clés
```

**Variables minimales à configurer :**
- `SUPABASE_URL` et `SUPABASE_ANON_KEY`
- `GOOGLE_MAPS_API_KEY`
- `GEMINI_API_KEY`

Les autres variables (Call Center AI, LocalAI, Handy) ont des valeurs par défaut qui fonctionnent en local.

### Étape 2: Installer le backend API

#### Option A: Utiliser les scripts automatiques

**Windows (PowerShell) :**
```powershell
cd backend
.\setup.ps1
```

**Linux/macOS :**
```bash
cd backend
chmod +x setup.sh
./setup.sh
```

#### Option B: Installation manuelle

```bash
cd backend

# Créer l'environnement virtuel
python -m venv venv

# Activer l'environnement virtuel
# Windows:
venv\Scripts\activate
# Linux/macOS:
source venv/bin/activate

# Installer les dépendances
pip install --upgrade pip
pip install -r requirements.txt
```

### Étape 3: Démarrer le backend API

#### Option A: Utiliser les scripts automatiques

**Windows (PowerShell) :**
```powershell
cd backend
.\start.ps1
```

**Linux/macOS :**
```bash
cd backend
chmod +x start.sh
./start.sh
```

#### Option B: Démarrage manuel

```bash
cd backend

# Activer l'environnement virtuel
# Windows:
venv\Scripts\activate
# Linux/macOS:
source venv/bin/activate

# Démarrer le serveur
python api_server.py
```

Le serveur démarre sur `http://localhost:5000`

### Étape 4: Vérifier que tout fonctionne

Ouvrir un nouveau terminal et tester :

```bash
# Health check du backend API
curl http://localhost:5000/health

# Devrait retourner:
# {"status": "healthy", "services": {...}}
```

### Étape 5: Utiliser dans Flutter

Les services sont **déjà initialisés automatiquement** dans `main.dart` via `ServiceFactory.initializeAll()`.

Vous pouvez les utiliser directement dans votre code :

```dart
import 'package:campbnb/services/service_factory.dart';

// Exemple: Call Center AI
final callCenter = ServiceFactory.getCallCenterService();
final result = await callCenter.initiateCall(
  phoneNumber: '+14161234567',
  task: 'Aider le client avec sa réservation de camping',
  claim: CallCenterService.createBookingSupportClaim(),
);

// Exemple: LocalAI
final localAI = ServiceFactory.getLocalAIService();
final response = await localAI.chat(
  message: 'Quels sont les meilleurs campings au Québec?',
  systemPrompt: 'Tu es Campy, un assistant expert en camping au Québec.',
);

// Exemple: Handy
final handy = ServiceFactory.getHandyService();
final isAvailable = await handy.checkHealth();
if (isAvailable) {
  final transcription = await handy.transcribeAudio(
    audioFile: '/path/to/audio.wav',
    language: 'fr',
  );
}
```

### Étape 6: Tester avec l'exemple

Un exemple complet est disponible dans `lib/examples/integrations_example.dart`.

Pour l'utiliser, ajoutez cette route dans votre router Flutter :

```dart
import 'package:campbnb/examples/integrations_example.dart';

// Dans votre app_router.dart
GoRoute(
  path: '/integrations-example',
  builder: (context, state) => const IntegrationsExample(),
),
```

Puis naviguez vers `/integrations-example` dans votre app.

## 📋 Checklist de vérification

- [ ] Fichier `.env` configuré avec vos clés API
- [ ] Backend API installé (`backend/venv` existe)
- [ ] Backend API démarré (accessible sur http://localhost:5000)
- [ ] Health check fonctionne (`curl http://localhost:5000/health`)
- [ ] Services Flutter utilisables dans le code
- [ ] (Optionnel) LocalAI démarré si vous voulez l'utiliser
- [ ] (Optionnel) Handy démarré si vous voulez l'utiliser

## 🐛 Problèmes courants

### "Python n'est pas installé"

Installer Python 3.9+ depuis https://www.python.org/downloads/

### "Module not found" lors du démarrage

```bash
cd backend
source venv/bin/activate  # ou venv\Scripts\activate sur Windows
pip install -r requirements.txt
```

### Le backend ne démarre pas

1. Vérifier que le port 5000 n'est pas déjà utilisé
2. Vérifier que l'environnement virtuel est activé
3. Vérifier les logs d'erreur dans le terminal

### Les services ne répondent pas

1. Vérifier que le backend API est démarré
2. Vérifier les variables d'environnement dans `.env`
3. Vérifier les URLs dans `.env` (doivent correspondre aux services démarrés)

## 📚 Documentation

- `QUICK_START.md` - Guide de démarrage rapide
- `docs/integrations.md` - Documentation complète des intégrations
- `backend/README.md` - Documentation du backend API
- `INTEGRATION_SUMMARY.md` - Résumé de l'intégration

## 🎯 Prochaines étapes

1. ✅ Configurer `.env` avec vos clés API
2. ✅ Installer et démarrer le backend API
3. ✅ Tester avec `IntegrationsExample`
4. ✅ Intégrer les services dans vos écrans Flutter
5. ✅ (Optionnel) Configurer LocalAI et Handy

---

**Besoin d'aide ?** Consultez `docs/integrations.md` pour la documentation complète.

