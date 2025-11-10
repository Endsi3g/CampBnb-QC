/// Constantes de l'application Campbnb
class AppConstants {
  // App Info
  static const String appName = 'Campbnb';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String geminiApiBaseUrl = 'https://generativelanguage.googleapis.com/v1beta';
  
  // Limites
  static const int maxPhotosPerListing = 10;
  static const int maxGuests = 20;
  static const int minNights = 1;
  static const int maxNights = 365;
  
  // Régions du Québec
  static const List<String> quebecRegions = [
    'Bas-Saint-Laurent',
    'Saguenay–Lac-Saint-Jean',
    'Capitale-Nationale',
    'Mauricie',
    'Estrie',
    'Montréal',
    'Outaouais',
    'Abitibi-Témiscamingue',
    'Côte-Nord',
    'Nord-du-Québec',
    'Gaspésie–Îles-de-la-Madeleine',
    'Chaudière-Appalaches',
    'Laval',
    'Lanaudière',
    'Laurentides',
    'Montérégie',
    'Centre-du-Québec',
  ];
  
  // Types de camping
  static const List<String> listingTypes = [
    'tent',
    'rv',
    'cabin',
    'van',
    'glamping',
    'other',
  ];
  
  // Équipements disponibles
  static const List<String> amenities = [
    'wifi',
    'electricity',
    'water',
    'fire_pit',
    'picnic_table',
    'bathroom',
    'shower',
    'toilet',
    'kitchen',
    'refrigerator',
    'parking',
    'pets_allowed',
    'lake_access',
    'hiking_trails',
    'fishing',
    'canoe_rental',
    'boat_ramp',
  ];
  
  // Politiques d'annulation
  static const List<String> cancellationPolicies = [
    'flexible',
    'moderate',
    'strict',
  ];
  
  // Statuts de réservation
  static const List<String> bookingStatuses = [
    'pending',
    'confirmed',
    'cancelled',
    'completed',
    'rejected',
  ];
  
  // Statuts de paiement
  static const List<String> paymentStatuses = [
    'pending',
    'paid',
    'refunded',
    'failed',
  ];
  
  // Badges de gamification
  static const List<String> availableBadges = [
    'first_booking',
    'explorer',
    'host',
    'superhost',
    'reviewer',
    'frequent_traveler',
    'local_expert',
  ];
}

