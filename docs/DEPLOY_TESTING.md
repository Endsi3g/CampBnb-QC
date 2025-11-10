# 🧪 Guide de Déploiement - Environnement Testing

Ce guide explique comment déployer l'application Campbnb vers l'environnement de test.

## 🚀 Déploiement Automatique

### Déclenchement automatique

Le workflow `deploy-testing.yml` se déclenche automatiquement lors de :

1. **Push sur les branches** :
   - `develop`
   - `staging`
   - `test`

2. **Pull Request** vers :
   - `develop`
   - `staging`

3. **Déclenchement manuel** :
   - Via l'interface GitHub Actions
   - Sélectionner "Deploy to Testing Environment"
   - Choisir l'environnement (`testing` ou `staging`)

## 📦 Artifacts Générés

### Flutter

- **Web Build** : Application web compilée dans `build/web/`
- **APK Android** : Application Android dans `build/app/outputs/flutter-apk/app-release.apk`
- **Retention** : 7 jours

### Backend Docker

- **Image Docker** : `ghcr.io/[OWNER]/campbnb-backend:testing`
- **Tags** :
  - `testing` (latest testing)
  - `testing-{sha}` (spécifique au commit)
  - `{branch}` (nom de la branche)

## 🔧 Utilisation Locale

### Télécharger les Artifacts

1. Aller sur GitHub Actions
2. Sélectionner le workflow run
3. Télécharger les artifacts :
   - `web-build-testing` : Build web
   - `apk-build-testing` : APK Android

### Utiliser l'Image Docker

```bash
# Pull l'image
docker pull ghcr.io/[OWNER]/campbnb-backend:testing

# Run le container
docker run -p 5000:5000 \
  -e PORT=5000 \
  -e DEBUG=true \
  -e LOCALAI_URL=http://localhost:8080 \
  -e HANDY_API_URL=http://localhost:3000 \
  ghcr.io/[OWNER]/campbnb-backend:testing
```

### Tester l'API

```bash
# Health check
curl http://localhost:5000/health

# Test LocalAI
curl http://localhost:5000/api/localai/models

# Test Handy
curl http://localhost:5000/api/handy/health
```

## 📱 Tester l'Application Flutter

### Web

1. Télécharger l'artifact `web-build-testing`
2. Servir les fichiers avec un serveur HTTP :

```bash
# Avec Python
cd web-build-testing
python -m http.server 8000

# Avec Node.js
npx serve web-build-testing -p 8000

# Avec Docker
docker run -p 8000:80 -v $(pwd)/web-build-testing:/usr/share/nginx/html nginx
```

3. Ouvrir `http://localhost:8000` dans le navigateur

### Android

1. Télécharger l'artifact `apk-build-testing`
2. Installer sur un appareil Android :

```bash
# Via ADB
adb install app-release.apk

# Ou transférer le fichier et installer manuellement
```

## 🔍 Vérification du Déploiement

### Statuts GitHub

Le workflow crée automatiquement :
- ✅ **Statut de commit** : `deploy/testing`
- 📝 **Commentaire PR** : Résumé du déploiement
- 🏷️ **Release** : Release pré-release avec artifacts

### Vérifier les Builds

1. Aller sur GitHub Actions
2. Voir le workflow "Deploy to Testing Environment"
3. Vérifier les jobs :
   - ✅ Build Flutter App
   - ✅ Build Backend Docker Image
   - ✅ Deploy Notification

### Vérifier l'Image Docker

```bash
# Lister les tags disponibles
docker pull ghcr.io/[OWNER]/campbnb-backend:testing

# Vérifier l'image
docker inspect ghcr.io/[OWNER]/campbnb-backend:testing
```

## 🐛 Dépannage

### Build Flutter échoue

**Problèmes courants** :
- Dépendances manquantes
- Erreurs de compilation
- Problèmes de configuration

**Solutions** :
1. Vérifier les logs du workflow
2. Tester localement : `flutter build web --release`
3. Vérifier `pubspec.yaml` et les dépendances

### Build Docker échoue

**Problèmes courants** :
- Erreurs dans `Dockerfile`
- Problèmes de permissions GitHub Container Registry
- Erreurs de build Python

**Solutions** :
1. Vérifier les logs du build Docker
2. Tester localement : `docker build -f backend/Dockerfile ./backend`
3. Vérifier les permissions du repository

### Artifacts non disponibles

**Vérifier** :
1. Le workflow s'est terminé avec succès
2. Les artifacts n'ont pas expiré (7 jours)
3. Les permissions de téléchargement

## 📊 Monitoring

### Notifications

Le workflow envoie automatiquement :
- 📧 Commentaires sur les PRs
- ✅ Statuts de commit
- 🏷️ Releases GitHub

### Logs

Tous les logs sont disponibles dans :
- GitHub Actions → Workflow Run → Job → Step

## 🔄 Workflow de Déploiement

```
┌─────────────────┐
│  Push/PR Event  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Detect Changes  │
└────────┬────────┘
         │
    ┌────┴────┐
    │         │
    ▼         ▼
┌────────┐ ┌──────────┐
│Flutter │ │ Backend   │
│ Build  │ │ Docker    │
└───┬────┘ └─────┬────┘
    │            │
    └─────┬──────┘
          │
          ▼
┌─────────────────┐
│   Notification  │
└─────────────────┘
          │
          ▼
┌─────────────────┐
│ Create Release  │
└─────────────────┘
```

## 🎯 Prochaines Étapes

Après un déploiement réussi :

1. ✅ Tester l'application web
2. ✅ Tester l'APK Android
3. ✅ Vérifier l'API backend
4. ✅ Tester les fonctionnalités principales
5. ✅ Vérifier les logs et métriques

## 📚 Références

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Documentation](https://docs.docker.com/)
- [Flutter Build Documentation](https://docs.flutter.dev/deployment)

