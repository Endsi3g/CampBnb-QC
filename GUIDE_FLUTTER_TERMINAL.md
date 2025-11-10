# Guide : Utiliser Flutter dans le Terminal

## Problème
Flutter n'est pas reconnu dans le terminal PowerShell.

## Solutions

### ✅ Solution 1 : Installation de Flutter (Recommandé)

1. **Télécharger Flutter**
   - Allez sur : https://docs.flutter.dev/get-started/install/windows
   - Téléchargez le SDK Flutter pour Windows
   - Extrayez dans `C:\src\flutter` (ou un autre dossier)

2. **Ajouter au PATH Windows**
   - Appuyez sur `Windows + R`
   - Tapez : `sysdm.cpl` puis Entrée
   - Onglet **Avancé** → **Variables d'environnement**
   - Dans **Variables système**, sélectionnez `Path` → **Modifier**
   - **Nouveau** → Ajoutez : `C:\src\flutter\bin`
   - **OK** partout
   - **Fermez et rouvrez** votre terminal

3. **Vérifier**
   ```powershell
   flutter --version
   flutter doctor
   ```

### ✅ Solution 2 : Utiliser VS Code ou Android Studio

**Avec VS Code :**
1. Installez l'extension "Flutter"
2. Ouvrez le terminal intégré (Ctrl + `)
3. VS Code détecte Flutter automatiquement

**Avec Android Studio :**
1. Installez le plugin Flutter
2. Utilisez le terminal intégré

### ✅ Solution 3 : Chemin complet (Temporaire)

Si Flutter est installé mais pas dans le PATH :

```powershell
# Remplacez par votre chemin d'installation
C:\src\flutter\bin\flutter.bat pub get
C:\src\flutter\bin\flutter.bat pub run build_runner build --delete-conflicting-outputs
```

### ✅ Solution 4 : Utiliser Git Bash

Si vous avez Git installé, vous pouvez utiliser Git Bash qui gère mieux les chemins :

```bash
flutter --version
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## Commandes importantes

Une fois Flutter configuré :

```powershell
# Installer les dépendances
flutter pub get

# Générer les fichiers .g.dart (Riverpod)
flutter pub run build_runner build --delete-conflicting-outputs

# Vérifier le projet
flutter analyze

# Lancer l'application
flutter run
```

## Note importante

Le fichier `profile_provider.g.dart` a été créé manuellement pour que le code compile. Cependant, il est **recommandé de le régénérer** avec `build_runner` une fois Flutter configuré pour éviter les problèmes de compatibilité.

