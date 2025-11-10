# Instructions pour connecter le projet à GitHub

## ✅ Étape 1 : Créer un dépôt sur GitHub

1. Allez sur [GitHub](https://github.com) et connectez-vous
2. Cliquez sur le bouton **"+"** en haut à droite, puis **"New repository"**
3. Remplissez les informations :
   - **Repository name** : `campbnb` (ou le nom de votre choix)
   - **Description** : "Application Flutter de réservation de camping au Québec"
   - **Visibilité** : Choisissez Public ou Private selon vos préférences
   - **⚠️ IMPORTANT** : Ne cochez PAS "Initialize this repository with a README" (nous avons déjà un README)
   - Ne cochez PAS "Add .gitignore" (nous avons déjà un .gitignore)
   - Ne cochez PAS "Choose a license" (sauf si vous voulez en ajouter un)
4. Cliquez sur **"Create repository"**

## ✅ Étape 2 : Connecter le dépôt local à GitHub

Une fois le dépôt créé sur GitHub, vous verrez une page avec des instructions. 

**Copiez l'URL de votre dépôt GitHub** (elle ressemble à : `https://github.com/votre-username/campbnb.git` ou `git@github.com:votre-username/campbnb.git`)

Ensuite, exécutez ces commandes dans PowerShell (remplacez `VOTRE_URL_GITHUB` par l'URL que vous avez copiée) :

```powershell
cd C:\campbnb
git remote add origin VOTRE_URL_GITHUB
git branch -M main
git push -u origin main
```

**Exemple concret** :
```powershell
cd C:\campbnb
git remote add origin https://github.com/votre-username/campbnb.git
git branch -M main
git push -u origin main
```

## ✅ Étape 3 : Vérifier la connexion

Pour vérifier que tout est bien connecté :

```powershell
git remote -v
```

Vous devriez voir l'URL de votre dépôt GitHub.

## 📝 Note sur l'authentification

Si GitHub vous demande de vous authentifier lors du `git push`, vous avez plusieurs options :

1. **Personal Access Token (recommandé)** :
   - Allez dans GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
   - Créez un nouveau token avec les permissions `repo`
   - Utilisez ce token comme mot de passe lors du push

2. **GitHub CLI** :
   - Installez GitHub CLI : `winget install GitHub.cli`
   - Authentifiez-vous : `gh auth login`
   - Puis faites `git push`

3. **SSH** (optionnel) :
   - Configurez une clé SSH avec GitHub
   - Utilisez l'URL SSH du dépôt : `git@github.com:votre-username/campbnb.git`

## 🔄 Commandes utiles pour la suite

Une fois connecté, vous pouvez utiliser ces commandes :

```powershell
# Voir l'état des modifications
git status

# Ajouter des fichiers modifiés
git add .

# Créer un commit
git commit -m "Description de vos modifications"

# Envoyer les modifications sur GitHub
git push

# Récupérer les modifications depuis GitHub
git pull
```

## ⚙️ Configuration Git (optionnel)

Si vous voulez configurer votre identité Git globalement (pour tous vos projets) :

```powershell
git config --global user.name "Votre Nom"
git config --global user.email "votre.email@example.com"
```

Pour ce projet uniquement, l'identité est déjà configurée localement.

