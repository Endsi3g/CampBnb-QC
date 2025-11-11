# 🚀 Déploiement Rapide - Testing

## Déclencher le déploiement maintenant

### Option 1 : Via l'interface GitHub (Recommandé)

1. **Ouvrir le workflow** :
   - https://github.com/Endsi3g/CampBnb-QC/actions/workflows/deploy-testing.yml

2. **Cliquer sur "Run workflow"** (bouton en haut à droite)

3. **Sélectionner** :
   - **Branch** : `main` (ou la branche de votre choix)
   - **Environment** : `testing`

4. **Cliquer sur "Run workflow"**

### Option 2 : Via le script PowerShell

```powershell
# Depuis le répertoire du projet
cd "C:\Users\le3li\Documents\Camp Airbnb App\CampBnb-QC"

# Exécuter le script
powershell -ExecutionPolicy Bypass -File scripts/trigger-testing-deploy.ps1
```

**Note** : Le script nécessite un GitHub Personal Access Token avec les permissions `actions:write`.

### Option 3 : Push sur une branche de test

```bash
# Créer/checkout une branche develop
git checkout -b develop

# Faire un commit (même vide)
git commit --allow-empty -m "Trigger testing deployment"

# Push pour déclencher automatiquement
git push origin develop
```

## 📊 Suivre le déploiement

Une fois déclenché, suivez le déploiement sur :
- https://github.com/Endsi3g/CampBnb-QC/actions

## ✅ Vérifier les résultats

Après le déploiement, vous trouverez :

1. **Artifacts** :
   - Web Build : `web-build-testing`
   - APK Android : `apk-build-testing`

2. **Image Docker** :
   - `ghcr.io/Endsi3g/campbnb-backend:testing`

3. **Release** :
   - Release pré-release avec tous les artifacts

## 🔗 Liens utiles

- **Workflow** : https://github.com/Endsi3g/CampBnb-QC/actions/workflows/deploy-testing.yml
- **Actions** : https://github.com/Endsi3g/CampBnb-QC/actions
- **Documentation** : `docs/DEPLOY_TESTING.md`

