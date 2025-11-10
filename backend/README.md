# Backend API - Intégrations

Ce backend API sert de pont entre l'application Flutter et les services intégrés (Call Center AI, LocalAI, Handy).

## 🚀 Démarrage rapide

### Installation

```bash
# Créer un environnement virtuel
python -m venv venv

# Activer l'environnement virtuel
# Sur Windows:
venv\Scripts\activate
# Sur macOS/Linux:
source venv/bin/activate

# Installer les dépendances
pip install -r requirements.txt
```

### Configuration

Créer un fichier `.env` à la racine du projet (voir `.env.example`) :

```env
PORT=5000
DEBUG=false
LOCALAI_URL=http://localhost:8080
HANDY_API_URL=http://localhost:3000
```

### Lancer le serveur

```bash
python api_server.py
```

Le serveur démarre sur `http://localhost:5000`

## 📡 Endpoints

### Health Check

```
GET /health
```

### Call Center AI

- `POST /api/call-center/call` - Initier un appel
- `GET /api/call-center/call/<call_id>/status` - Statut d'un appel
- `GET /api/call-center/call/<call_id>/data` - Données d'un appel

### LocalAI

- `POST /api/localai/chat` - Chat avec LocalAI
- `GET /api/localai/models` - Lister les modèles disponibles

### Handy

- `POST /api/handy/transcribe` - Transcrire un fichier audio
- `GET /api/handy/models` - Lister les modèles disponibles
- `GET /api/handy/health` - Vérifier la santé du service

## 🔧 Développement

### Structure

```
backend/
├── api_server.py          # Serveur Flask principal
├── requirements.txt       # Dépendances Python
└── README.md             # Ce fichier
```

### Tests

```bash
# Health check
curl http://localhost:5000/health

# Test LocalAI
curl http://localhost:5000/api/localai/models

# Test Handy
curl http://localhost:5000/api/handy/health
```

## 📝 Notes

- Ce backend est un proxy simple. Pour la production, considérer :
  - Authentification robuste (JWT, OAuth)
  - Rate limiting
  - Logging avancé
  - Monitoring (Sentry, etc.)
  - HTTPS obligatoire
  - Validation des entrées
  - Gestion d'erreurs améliorée

