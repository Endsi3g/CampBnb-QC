# 🤖 Automatisation des mises à jour GitHub

Ce projet inclut plusieurs méthodes pour pousser automatiquement les changements vers GitHub.

## 🚀 Méthodes disponibles

### 1. GitHub Actions (Automatisation Cloud) ⭐ RECOMMANDÉ

**Les workflows GitHub Actions s'exécutent automatiquement dans le cloud** et offrent une automatisation complète sans intervention locale.

#### Workflows configurés :

1. **🚀 CI/CD - Build & Tests** (`.github/workflows/ci.yml`)
   - ✅ S'exécute automatiquement à chaque push sur `main` ou `develop`
   - ✅ Exécute les tests Flutter
   - ✅ Analyse le code (lint)
   - ✅ Build pour toutes les plateformes (Linux, Windows, macOS, Web, Android)
   - ✅ Upload des artefacts de build

2. **🐍 Backend CI/CD** (`.github/workflows/backend-ci.yml`)
   - ✅ Tests du backend Python
   - ✅ Analyse du code (flake8, black)
   - ✅ Build et push d'images Docker vers GitHub Container Registry
   - ✅ S'exécute uniquement si le backend est modifié

3. **🔄 Synchronisation Automatique** (`.github/workflows/auto-sync.yml`)
   - ✅ S'exécute tous les jours à 2h UTC
   - ✅ Peut être déclenché manuellement
   - ✅ Synchronise automatiquement les changements
   - ✅ Crée des commits de synchronisation si nécessaire

4. **🚀 Release Automatique** (`.github/workflows/release.yml`)
   - ✅ Crée automatiquement une release lors de la création d'un tag `v*.*.*`
   - ✅ Build les artefacts (APK, Web)
   - ✅ Publie la release sur GitHub avec les artefacts

#### Comment utiliser :

**Automatique :**
- Les workflows s'exécutent automatiquement à chaque push
- Consultez l'onglet **Actions** sur GitHub pour voir les résultats

**Manuel :**
1. Allez sur votre dépôt GitHub
2. Cliquez sur l'onglet **Actions**
3. Sélectionnez le workflow souhaité
4. Cliquez sur **Run workflow**

**Voir les résultats :**
- Onglet **Actions** → Cliquez sur un workflow → Voir les logs et artefacts

#### Avantages :
- ✅ Aucune configuration locale nécessaire
- ✅ S'exécute dans le cloud (pas besoin que votre PC soit allumé)
- ✅ Builds pour toutes les plateformes automatiquement
- ✅ Tests et validation automatiques
- ✅ Historique complet des builds et tests

### 2. Script PowerShell manuel (`auto-push.ps1`)

Le moyen le plus simple pour pousser rapidement tous les changements :

```powershell
# Avec message de commit par défaut
.\auto-push.ps1

# Avec message personnalisé
.\auto-push.ps1 -CommitMessage "Ajout de nouvelles fonctionnalités"
```

**Ce que fait le script :**
- ✅ Vérifie s'il y a des changements
- ✅ Ajoute tous les fichiers modifiés
- ✅ Crée un commit avec message
- ✅ Récupère les changements distants (pull avec rebase)
- ✅ Pousse vers GitHub

### 3. Surveillance automatique (`watch-changes.ps1`)

Surveille le dossier et pousse automatiquement les changements à intervalles réguliers :

```powershell
# Surveillance toutes les 5 minutes (par défaut)
.\watch-changes.ps1

# Surveillance toutes les 10 minutes
.\watch-changes.ps1 -IntervalMinutes 10

# Avec message de commit personnalisé
.\watch-changes.ps1 -IntervalMinutes 5 -CommitMessage "Mise à jour automatique"
```

**Utilisation recommandée :**
- Lancer ce script en arrière-plan pendant que vous travaillez
- Il vérifiera automatiquement les changements et les poussera
- Appuyez sur `Ctrl+C` pour arrêter

### 4. Hooks Git automatiques

Des hooks Git ont été configurés pour pousser automatiquement après chaque commit :

**Sur Linux/Mac :** `.git/hooks/post-commit` (bash)
**Sur Windows :** `.git/hooks/post-commit.ps1` (PowerShell)

Ces hooks s'exécutent automatiquement après chaque `git commit`.

**Pour activer le hook PowerShell sur Windows :**
```powershell
# Rendre le hook exécutable (si nécessaire)
icacls .git\hooks\post-commit.ps1 /grant Everyone:RX
```

### 5. Tâche planifiée Windows (Optionnel)

Pour une automatisation complète 24/7, vous pouvez créer une tâche planifiée Windows :

1. Ouvrir le **Planificateur de tâches** Windows
2. Créer une tâche de base
3. Déclencheur : **À la connexion** ou **Toutes les X minutes**
4. Action : Exécuter `powershell.exe` avec l'argument :
   ```
   -File "C:\campbnb\auto-push.ps1"
   ```

## 📋 Workflow recommandé

### Pour un développement actif :

1. **Option 1 - GitHub Actions (RECOMMANDÉ)** ⭐ :
   - Travaillez normalement
   - Faites vos commits et push : `git push`
   - Les workflows GitHub Actions s'exécutent automatiquement dans le cloud
   - Tests, builds et validations sont effectués automatiquement
   - Consultez l'onglet **Actions** sur GitHub pour voir les résultats

2. **Option 2 - Hook automatique** :
   - Travaillez normalement
   - Faites vos commits : `git commit -m "votre message"`
   - Le hook poussera automatiquement vers GitHub
   - Les workflows GitHub Actions se déclencheront ensuite

3. **Option 3 - Script manuel** :
   - Travaillez normalement
   - Quand vous voulez sauvegarder : `.\auto-push.ps1`
   - Tout est automatiquement poussé
   - Les workflows GitHub Actions se déclencheront ensuite

4. **Option 4 - Surveillance continue** :
   - Lancez `.\watch-changes.ps1` en arrière-plan
   - Travaillez normalement
   - Les changements seront poussés automatiquement toutes les X minutes
   - Les workflows GitHub Actions se déclencheront ensuite

## ⚙️ Configuration Git

Pour que les hooks fonctionnent correctement, assurez-vous que Git est configuré :

```powershell
# Vérifier la configuration
git config --list

# Configurer votre identité (si pas déjà fait)
git config --global user.name "Votre Nom"
git config --global user.email "votre.email@example.com"
```

## 🔐 Authentification GitHub

Si vous êtes souvent demandé de vous authentifier, configurez :

1. **Personal Access Token** (recommandé) :
   - GitHub → Settings → Developer settings → Personal access tokens
   - Créer un token avec permission `repo`
   - Utiliser ce token comme mot de passe

2. **GitHub CLI** :
   ```powershell
   winget install GitHub.cli
   gh auth login
   ```

3. **SSH** :
   - Configurer une clé SSH avec GitHub
   - Utiliser l'URL SSH du dépôt

## 🛠️ Dépannage

### Le hook ne s'exécute pas :
- Vérifiez que le fichier est exécutable
- Sur Windows, assurez-vous que PowerShell peut exécuter les scripts

### Erreur de push :
- Vérifiez votre connexion Internet
- Vérifiez vos credentials GitHub
- Faites un `git pull` manuel d'abord

### Conflits :
- Le script essaie automatiquement de résoudre avec `git pull --rebase`
- Si cela échoue, résolvez manuellement les conflits

## 📝 Notes

- Les scripts incluent des messages de commit automatiques avec timestamp
- Tous les scripts vérifient d'abord s'il y a des changements
- Les erreurs sont affichées clairement avec des couleurs
- **GitHub Actions** est la méthode la plus robuste et ne nécessite aucune configuration locale
- Les workflows GitHub Actions s'exécutent même si votre PC est éteint

## 🔧 Configuration GitHub Actions

### Secrets nécessaires (optionnel)

Pour certaines fonctionnalités avancées, vous pouvez configurer des secrets dans GitHub :

1. Allez sur votre dépôt GitHub → **Settings** → **Secrets and variables** → **Actions**
2. Ajoutez les secrets suivants si nécessaire :
   - `GITHUB_TOKEN` : Généré automatiquement par GitHub (déjà disponible)
   - `SUPABASE_URL` : URL de votre projet Supabase (si nécessaire)
   - `SUPABASE_ANON_KEY` : Clé anonyme Supabase (si nécessaire)
   - `GEMINI_API_KEY` : Clé API Gemini (si nécessaire)
   - `GOOGLE_MAPS_API_KEY` : Clé API Google Maps (si nécessaire)

### Vérifier que les workflows fonctionnent

1. Allez sur l'onglet **Actions** de votre dépôt GitHub
2. Vous devriez voir les workflows listés
3. Après un push, les workflows s'exécutent automatiquement
4. Cliquez sur un workflow pour voir les détails et les logs

