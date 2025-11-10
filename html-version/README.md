# Campbnb Québec - Version HTML de Test

Version HTML standalone pour tester l'interface utilisateur de Campbnb Québec dans Google Chrome.

## 🚀 Utilisation

1. Ouvrez le fichier `index.html` dans Google Chrome
2. Aucune installation requise - tout fonctionne en local

## ✨ Fonctionnalités

- **Page d'accueil** : Affichage des listings de camping
- **Détails de listing** : Vue détaillée avec description et équipements
- **Recherche** : Recherche par mots-clés dans les listings
- **Filtres** : Filtrage par prix, type, région
- **Navigation** : Navigation entre les différentes sections
- **Mode sombre** : Toggle pour changer de thème
- **Design responsive** : Adapté mobile et desktop

## 🎨 Design

Le design reprend les couleurs et le style de l'application Flutter :
- Vert forêt (#2D572C) - Couleur principale
- Bleu lac (#3B8EA5) - Couleur secondaire
- Beige bois (#F5F1E3) - Couleur de fond
- Design moderne inspiré Airbnb

## 📝 Données

Les données sont mockées localement dans `app.js`. Vous pouvez modifier le tableau `mockListings` pour ajouter ou modifier des listings de test.

## 🔧 Personnalisation

- **Couleurs** : Modifiez les variables CSS dans `styles.css`
- **Données** : Modifiez `mockListings` dans `app.js`
- **Fonctionnalités** : Ajoutez vos propres fonctions dans `app.js`

## 📱 Compatibilité

Testé et optimisé pour :
- Google Chrome (recommandé)
- Firefox
- Safari
- Edge

## ⚠️ Note

Cette version est uniquement pour le test de l'interface. Elle n'inclut pas :
- Connexion à Supabase
- Authentification réelle
- Données persistantes (sauf favoris en localStorage)
- Intégration avec les APIs externes

Pour la version complète avec toutes les fonctionnalités, utilisez l'application Flutter.

