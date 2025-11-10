# Flux Utilisateur - Campbnb

## Flow 1: Inscription et Connexion

```
1. Utilisateur ouvre l'app
   ↓
2. Vérification de l'authentification
   ↓
3a. Si non connecté → Écran Login
   ↓
3b. Si connecté → Écran Home
   ↓
4. Sur Login, option "S'inscrire"
   ↓
5. Écran Signup
   ↓
6. Formulaire: Email + Password
   ↓
7. Validation côté client
   ↓
8. Appel Supabase Auth signUp
   ↓
9. Création automatique du profil
   ↓
10. Redirection vers Home
```

## Flow 2: Recherche et Réservation

```
1. Utilisateur sur Home
   ↓
2. Clique sur "Recherche" ou utilise la barre de recherche
   ↓
3. Écran Search avec filtres
   ↓
4. Sélection des filtres:
   - Région
   - Type de camping
   - Prix min/max
   - Nombre de voyageurs
   ↓
5. Application des filtres
   ↓
6. Affichage des résultats (ListingCard)
   ↓
7. Utilisateur clique sur une annonce
   ↓
8. Écran ListingDetail
   - Carrousel photos
   - Description
   - Équipements
   - Carte
   ↓
9. Clique sur "Réserver"
   ↓
10. Écran Booking
    - Sélection dates (check-in/check-out)
    - Nombre de voyageurs
    - Message optionnel
    - Récapitulatif prix
    ↓
11. Validation des dates
    ↓
12. Création de la réservation (statut: pending)
    ↓
13. Confirmation affichée
    ↓
14. Retour à Home ou Profil
```

## Flow 3: Création d'Annonce (Hôte)

```
1. Utilisateur connecté
   ↓
2. Va dans Profil
   ↓
3. Clique sur "Ajouter une annonce"
   ↓
4. Écran AddListing
   ↓
5. Formulaire en plusieurs étapes:
   a. Informations de base
      - Titre
      - Description
      - Type de camping
   b. Localisation
      - Adresse
      - Ville
      - Région
      - Sélection sur carte (Google Maps)
   c. Prix et capacité
      - Prix par nuit
      - Nombre max de voyageurs
   d. Équipements
      - Checklist avec icônes
   e. Photos
      - Upload jusqu'à 10 photos
   ↓
6. Validation du formulaire
   ↓
7. Upload des photos vers Supabase Storage
   ↓
8. Création du listing dans Supabase
   ↓
9. Confirmation
   ↓
10. Redirection vers Profil > Mes annonces
```

## Flow 4: Chatbot IA

```
1. Utilisateur clique sur l'icône chat (n'importe où)
   ↓
2. Écran AiChatScreen
   ↓
3. Historique de conversation (si existe)
   ↓
4. Utilisateur tape un message
   ↓
5. Envoi au service Gemini
   ↓
6. Prompt construit avec:
   - Contexte utilisateur (préférences, historique)
   - Message utilisateur
   - Historique de conversation
   ↓
7. Réponse de Gemini
   ↓
8. Affichage dans le chat
   ↓
9. Sauvegarde dans ai_chat_history
   ↓
10. Utilisateur peut continuer la conversation
```

## Flow 5: Recommandations IA

```
1. Utilisateur sur Home ou Search
   ↓
2. Section "Recommandations IA" visible
   ↓
3. Appel automatique à Gemini avec:
   - Historique de réservations
   - Préférences utilisateur
   - Région actuelle (si disponible)
   ↓
4. Analyse par Gemini:
   - Patterns dans l'historique
   - Préférences implicites
   - Saisonnalité
   ↓
5. Génération de 5 recommandations
   ↓
6. Affichage sous forme de cards
   ↓
7. Utilisateur clique sur une recommandation
   ↓
8. Redirection vers ListingDetail
   ↓
9. Tracking: clicked_at mis à jour
```

## Flow 6: Gestion des Réservations (Hôte)

```
1. Hôte connecté
   ↓
2. Va dans Profil
   ↓
3. Clique sur "Mes annonces"
   ↓
4. Liste de ses listings
   ↓
5. Clique sur une annonce
   ↓
6. Vue détaillée avec:
   - Réservations en attente
   - Réservations confirmées
   - Réservations passées
   ↓
7. Pour chaque réservation:
   - Voir les détails (dates, voyageurs, message)
   - Actions: Confirmer / Rejeter
   ↓
8. Confirmation → Statut: confirmed
   ↓
9. Rejet → Statut: rejected
   ↓
10. Notification envoyée au voyageur
```

## Flow 7: Favoris

```
1. Utilisateur sur ListingDetail
   ↓
2. Clique sur icône cœur
   ↓
3. Vérification si déjà en favori
   ↓
4a. Si non → Ajout dans Supabase
   ↓
4b. Si oui → Suppression
   ↓
5. Mise à jour de l'icône
   ↓
6. Dans Profil > Favoris:
   - Liste de tous les favoris
   - Possibilité de retirer
   - Navigation vers les listings
```

## Flow 8: Recherche Intelligente avec IA

```
1. Utilisateur tape dans la barre de recherche
   ↓
2. Analyse en temps réel par Gemini:
   - Extraction d'intentions
   - Suggestions de lieux
   - Correction d'orthographe
   ↓
3. Affichage de suggestions intelligentes
   ↓
4. Utilisateur sélectionne une suggestion
   ↓
5. Filtres appliqués automatiquement
   ↓
6. Résultats affichés
   ↓
7. Option "Demander à l'IA" pour affiner
```

## Flow 9: Génération d'Itinéraire

```
1. Utilisateur dans Profil ou Chatbot
   ↓
2. Clique sur "Générer un itinéraire"
   ↓
3. Formulaire:
   - Région
   - Nombre de jours
   - Intérêts (hiking, fishing, etc.)
   - Budget
   ↓
4. Appel à Gemini avec ces paramètres
   ↓
5. Génération d'itinéraire détaillé:
   - Jour 1: Activités, camping suggéré
   - Jour 2: Activités, camping suggéré
   - ...
   ↓
6. Affichage avec:
   - Timeline visuelle
   - Suggestions de campings
   - Activités locales
   - Estimation de coût
   ↓
7. Possibilité de réserver directement
```

## Flow 10: Mode Hors Ligne

```
1. Détection de perte de connexion
   ↓
2. Mode hors ligne activé
   ↓
3. Affichage des données en cache:
   - Favoris
   - Réservations récentes
   - Annonces consultées récemment
   ↓
4. Message "Mode hors ligne" visible
   ↓
5. Actions disponibles:
   - Consulter les favoris
   - Voir l'historique
   - (Pas de nouvelles recherches)
   ↓
6. Reconnexion détectée
   ↓
7. Synchronisation automatique
```

## États et Transitions

### Réservation
```
pending → confirmed → completed
       ↘ rejected
       ↘ cancelled
```

### Listing
```
pending → active → inactive
       ↘ rejected
```

### Notification
```
unread → read
```

