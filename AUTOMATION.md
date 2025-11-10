# 🤖 Automatisation des mises à jour GitHub

Ce projet inclut plusieurs méthodes pour pousser automatiquement les changements vers GitHub.

## 🚀 Méthodes disponibles

### 1. Script PowerShell manuel (`auto-push.ps1`)

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

### 2. Surveillance automatique (`watch-changes.ps1`)

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

### 3. Hooks Git automatiques

Des hooks Git ont été configurés pour pousser automatiquement après chaque commit :

**Sur Linux/Mac :** `.git/hooks/post-commit` (bash)
**Sur Windows :** `.git/hooks/post-commit.ps1` (PowerShell)

Ces hooks s'exécutent automatiquement après chaque `git commit`.

**Pour activer le hook PowerShell sur Windows :**
```powershell
# Rendre le hook exécutable (si nécessaire)
icacls .git\hooks\post-commit.ps1 /grant Everyone:RX
```

### 4. Tâche planifiée Windows (Optionnel)

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

1. **Option 1 - Hook automatique (recommandé)** :
   - Travaillez normalement
   - Faites vos commits : `git commit -m "votre message"`
   - Le hook poussera automatiquement

2. **Option 2 - Script manuel** :
   - Travaillez normalement
   - Quand vous voulez sauvegarder : `.\auto-push.ps1`
   - Tout est automatiquement poussé

3. **Option 3 - Surveillance continue** :
   - Lancez `.\watch-changes.ps1` en arrière-plan
   - Travaillez normalement
   - Les changements seront poussés automatiquement toutes les X minutes

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

