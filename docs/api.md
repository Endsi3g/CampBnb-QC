# Documentation API - Campbnb

## Endpoints Supabase

### Authentification

#### Inscription
```dart
POST /auth/v1/signup
Body: {
  email: string,
  password: string
}
Response: AuthResponse
```

#### Connexion
```dart
POST /auth/v1/token?grant_type=password
Body: {
  email: string,
  password: string
}
Response: AuthResponse
```

#### Déconnexion
```dart
POST /auth/v1/logout
Headers: {
  Authorization: Bearer <token>
}
```

### Profiles

#### Récupérer un profil
```dart
GET /rest/v1/profiles?id=eq.{userId}
Headers: {
  Authorization: Bearer <token>,
  apikey: <anon_key>
}
Response: ProfileModel
```

#### Mettre à jour un profil
```dart
PATCH /rest/v1/profiles?id=eq.{userId}
Headers: {
  Authorization: Bearer <token>
}
Body: ProfileModel (partial)
```

### Listings

#### Lister les annonces
```dart
GET /rest/v1/listings?status=eq.active&order=created_at.desc
Query Parameters:
  - region: string (optional)
  - city: string (optional)
  - listing_type: string (optional)
  - price_per_night: gte.{min}&lte.{max} (optional)
  - max_guests: gte.{guests} (optional)
  - limit: number (default: 20)
  - offset: number (default: 0)
Response: List<ListingModel>
```

#### Récupérer une annonce
```dart
GET /rest/v1/listings?id=eq.{listingId}
Response: ListingModel
```

#### Créer une annonce
```dart
POST /rest/v1/listings
Headers: {
  Authorization: Bearer <token>
}
Body: ListingModel
Response: ListingModel
```

#### Mettre à jour une annonce
```dart
PATCH /rest/v1/listings?id=eq.{listingId}
Headers: {
  Authorization: Bearer <token>
}
Body: ListingModel (partial)
```

#### Supprimer une annonce
```dart
DELETE /rest/v1/listings?id=eq.{listingId}
Headers: {
  Authorization: Bearer <token>
}
```

### Bookings

#### Créer une réservation
```dart
POST /rest/v1/bookings
Headers: {
  Authorization: Bearer <token>
}
Body: BookingModel
Response: BookingModel
```

#### Récupérer les réservations d'un utilisateur
```dart
GET /rest/v1/bookings?guest_id=eq.{userId}&order=created_at.desc
Headers: {
  Authorization: Bearer <token>
}
Response: List<BookingModel>
```

#### Mettre à jour le statut d'une réservation
```dart
PATCH /rest/v1/bookings?id=eq.{bookingId}
Headers: {
  Authorization: Bearer <token>
}
Body: {
  status: string
}
```

### Favoris

#### Ajouter un favori
```dart
POST /rest/v1/favorites
Headers: {
  Authorization: Bearer <token>
}
Body: {
  user_id: string,
  listing_id: string
}
```

#### Supprimer un favori
```dart
DELETE /rest/v1/favorites?user_id=eq.{userId}&listing_id=eq.{listingId}
Headers: {
  Authorization: Bearer <token>
}
```

#### Récupérer les favoris
```dart
GET /rest/v1/favorites?user_id=eq.{userId}
Headers: {
  Authorization: Bearer <token>
}
Response: List<{listing_id: string}>
```

### Storage (Images)

#### Upload une image
```dart
POST /storage/v1/object/listing-photos/{filename}
Headers: {
  Authorization: Bearer <token>
}
Body: Binary (image data)
```

#### Récupérer l'URL publique
```dart
GET /storage/v1/object/public/listing-photos/{filename}
```

## API Gemini 2.5

### Base URL
```
https://generativelanguage.googleapis.com/v1beta
```

### Chat / Assistant

#### Envoyer un message
```dart
POST /models/gemini-2.0-flash-exp:generateContent?key={API_KEY}
Headers: {
  Content-Type: application/json
}
Body: {
  contents: [
    {
      role: "user",
      parts: [{"text": "message"}]
    }
  ],
  generationConfig: {
    temperature: 0.7,
    topK: 40,
    topP: 0.95,
    maxOutputTokens: 1024
  }
}
Response: {
  candidates: [{
    content: {
      parts: [{"text": "response"}]
    }
  }]
}
```

### Exemples d'Utilisation

#### Chatbot
```dart
final response = await geminiService.chat(
  message: "Quels sont les meilleurs campings en Mauricie?",
  conversationHistory: history,
  context: userContext,
);
```

#### Recommandations
```dart
final recommendations = await geminiService.getRecommendations(
  userId: userId,
  region: "Mauricie",
  preferredType: "cabin",
  budget: 100,
  preferredAmenities: ["wifi", "fire_pit"],
);
```

#### Résumé d'avis
```dart
final summary = await geminiService.summarizeReviews(reviews);
```

#### Génération d'itinéraire
```dart
final itinerary = await geminiService.generateItinerary(
  region: "Laurentides",
  days: 3,
  interests: ["hiking", "fishing"],
  budget: 500,
);
```

#### Traduction
```dart
final translated = await geminiService.translate(
  "Bonjour, je cherche un camping",
  targetLanguage: "en",
);
```

## Google Maps API

### Géocodage
```
GET https://maps.googleapis.com/maps/api/geocode/json
  ?address={address}
  &key={API_KEY}
```

### Reverse Géocodage
```
GET https://maps.googleapis.com/maps/api/geocode/json
  ?latlng={lat},{lng}
  &key={API_KEY}
```

### Distance Matrix
```
GET https://maps.googleapis.com/maps/api/distancematrix/json
  ?origins={origin}
  &destinations={destination}
  &key={API_KEY}
```

## Codes d'Erreur

### Supabase
- `401` : Non authentifié
- `403` : Accès refusé (RLS)
- `404` : Ressource non trouvée
- `422` : Erreur de validation
- `500` : Erreur serveur

### Gemini
- `400` : Requête invalide
- `401` : Clé API invalide
- `429` : Limite de taux dépassée
- `500` : Erreur serveur

## Rate Limiting

### Supabase
- Plan gratuit : 500 requêtes/seconde
- Plan Pro : 2000 requêtes/seconde

### Gemini
- Plan gratuit : 15 requêtes/minute
- Plan payant : Selon le forfait

## Authentification

Toutes les requêtes Supabase nécessitent :
```
Headers: {
  Authorization: Bearer <jwt_token>,
  apikey: <supabase_anon_key>
}
```

Le token JWT est géré automatiquement par `supabase_flutter`.

