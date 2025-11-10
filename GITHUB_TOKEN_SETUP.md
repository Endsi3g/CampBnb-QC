# 🔐 Configuration du Token GitHub pour Actions

## ⚠️ SÉCURITÉ IMPORTANTE

**Le token que vous avez partagé est maintenant exposé publiquement.**
**Vous DEVEZ le révoquer et en créer un nouveau après la configuration.**

## 📋 Étapes de Configuration

### 1. Ajouter le Token comme Secret GitHub

1. Allez sur votre dépôt GitHub : https://github.com/Endsi3g/CampBnb-QC
2. Cliquez sur **Settings** (Paramètres)
3. Dans le menu de gauche, cliquez sur **Secrets and variables** → **Actions**
4. Cliquez sur **New repository secret**
5. Remplissez :
   - **Name** : `GITHUB_TOKEN`
   - **Secret** : Collez votre token (commence par `ghp_`)
6. Cliquez sur **Add secret**

### 2. Révoquer l'Ancien Token (IMPORTANT)

1. Allez sur GitHub → **Settings** → **Developer settings**
2. Cliquez sur **Personal access tokens** → **Tokens (classic)**
3. Trouvez votre ancien token (celui que vous avez partagé)
4. Cliquez sur **Revoke** (Révoquer)
5. Créez un nouveau token avec les permissions :
   - ✅ `repo` (accès complet aux dépôts)
   - ✅ `workflow` (accès aux workflows)
6. Ajoutez le nouveau token comme secret `GITHUB_TOKEN` dans votre dépôt

### 3. Configurer Git Localement (Optionnel)

Pour utiliser le token dans vos commandes Git locales :

```powershell
# Configurer le token pour les push
git config --global credential.helper store

# Ou utiliser le token directement dans l'URL (temporaire)
git remote set-url origin https://ghp_VOTRE_NOUVEAU_TOKEN@github.com/Endsi3g/CampBnb-QC.git
```

**⚠️ Ne commitez JAMAIS le token dans un fichier !**

### 4. Vérifier que GitHub Actions Fonctionne

1. Allez sur l'onglet **Actions** de votre dépôt GitHub
2. Vous devriez voir les workflows s'exécuter automatiquement à chaque push
3. Les workflows incluent :
   - ✅ Build & Test automatique
   - ✅ Analyse du code
   - ✅ Tests
   - ✅ Build des artefacts (APK, Web)

## 🔄 Workflows Configurés

### `auto-deploy.yml`
- Build et test automatiques
- Déploiement sur push vers `main`
- Upload d'artefacts

### `dart.yml` / `flutter.yml`
- Tests et analyse du code
- Vérification du formatage

## 🛡️ Bonnes Pratiques de Sécurité

1. **Ne jamais partager de tokens publiquement**
2. **Utiliser des secrets GitHub** pour stocker les tokens
3. **Révoquer les tokens compromis immédiatement**
4. **Limiter les permissions des tokens** au strict nécessaire
5. **Utiliser des tokens avec expiration** quand possible

## 📝 Commandes Utiles

```powershell
# Vérifier les remotes configurés
git remote -v

# Voir les secrets GitHub (via l'interface web uniquement)
# GitHub → Settings → Secrets and variables → Actions

# Tester le token
gh auth status
```

## 🔗 Ressources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Personal Access Tokens](https://github.com/settings/tokens)
- [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)

