# Configuration Flutter pour Windows

## Option 1 : Installation de Flutter (Recommandé)

### 1. Télécharger Flutter
1. Allez sur https://docs.flutter.dev/get-started/install/windows
2. Téléchargez le SDK Flutter pour Windows
3. Extrayez le fichier ZIP dans un dossier (ex: `C:\src\flutter`)

### 2. Ajouter Flutter au PATH
1. Ouvrez les **Variables d'environnement** :
   - Appuyez sur `Windows + R`
   - Tapez `sysdm.cpl` et appuyez sur Entrée
   - Allez dans l'onglet **Avancé**
   - Cliquez sur **Variables d'environnement**

2. Dans **Variables système**, trouvez `Path` et cliquez sur **Modifier**

3. Cliquez sur **Nouveau** et ajoutez le chemin vers Flutter :
   ```
   C:\src\flutter\bin
   ```
   (Remplacez par votre chemin d'installation)

4. Cliquez sur **OK** pour fermer toutes les fenêtres

5. **Redémarrez votre terminal** (ou PowerShell)

### 3. Vérifier l'installation
```powershell
flutter --version
flutter doctor
```

## Option 2 : Utiliser Android Studio / VS Code

Si vous avez Android Studio ou VS Code installé :

### Avec VS Code :
1. Installez l'extension "Flutter" dans VS Code
2. Ouvrez le terminal intégré (Ctrl + `)
3. VS Code devrait détecter Flutter automatiquement

### Avec Android Studio :
1. Installez le plugin Flutter
2. Utilisez le terminal intégré d'Android Studio

## Option 3 : Utiliser le chemin complet

Si Flutter est installé mais pas dans le PATH, vous pouvez utiliser le chemin complet :

```powershell
# Remplacez C:\src\flutter par votre chemin
C:\src\flutter\bin\flutter.bat pub get
C:\src\flutter\bin\flutter.bat pub run build_runner build --delete-conflicting-outputs
```

## Option 4 : Génération manuelle (Temporaire)

Si vous ne pouvez pas installer Flutter maintenant, les fichiers `.g.dart` peuvent être générés plus tard. L'application devrait quand même compiler si les fichiers existent déjà.

Pour vérifier quels fichiers doivent être régénérés :
- `lib/features/listing/providers/listing_provider.g.dart`
- `lib/features/booking/providers/booking_provider.g.dart`
- `lib/features/search/providers/search_provider.g.dart`
- `lib/features/profile/providers/profile_provider.g.dart`

