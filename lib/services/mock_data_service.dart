import '../models/listing_model.dart';
import '../models/profile_model.dart';
import '../models/booking_model.dart';

/// Service de données mock pour le mode sandbox
class MockDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();
  
  // Données mock pour les listings
  List<ListingModel> getMockListings() {
    return [
      ListingModel(
        id: 'mock_1',
        hostId: 'mock_host_1',
        title: 'Camping Domaine Aventura - Charlevoix',
        description: 'Magnifique camping en pleine nature avec vue sur le fleuve Saint-Laurent. Parfait pour les amoureux de la nature.',
        region: 'Charlevoix',
        city: 'Baie-Saint-Paul',
        address: '123 Chemin du Camping',
        latitude: 47.4414,
        longitude: -70.5044,
        listingType: 'tent',
        pricePerNight: 45.0,
        maxGuests: 4,
        amenities: ['eau', 'feu', 'toilettes', 'douches'],
        images: [],
        status: 'active',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
      ),
      ListingModel(
        id: 'mock_2',
        hostId: 'mock_host_2',
        title: 'Camping Éco-Lodge Laurentides',
        description: 'Camping écologique avec cabanes en bois et installations modernes. Idéal pour une escapade en famille.',
        region: 'Laurentides',
        city: 'Sainte-Adèle',
        address: '456 Route des Érables',
        latitude: 45.9500,
        longitude: -74.1333,
        listingType: 'cabin',
        pricePerNight: 85.0,
        maxGuests: 6,
        amenities: ['eau', 'feu', 'toilettes', 'douches', 'électricité', 'wifi'],
        images: [],
        status: 'active',
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        updatedAt: DateTime.now(),
      ),
      ListingModel(
        id: 'mock_3',
        hostId: 'mock_host_3',
        title: 'Camping Rivière Rouge - Lanaudière',
        description: 'Camping au bord de la rivière avec accès direct à l\'eau. Parfait pour la pêche et le canot.',
        region: 'Lanaudière',
        city: 'Rawdon',
        address: '789 Chemin de la Rivière',
        latitude: 46.0333,
        longitude: -73.7167,
        listingType: 'rv',
        pricePerNight: 60.0,
        maxGuests: 8,
        amenities: ['eau', 'feu', 'toilettes', 'douches', 'électricité', 'vidange'],
        images: [],
        status: 'active',
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now(),
      ),
      ListingModel(
        id: 'mock_4',
        hostId: 'mock_host_1',
        title: 'Camping Mont-Tremblant - Expérience Premium',
        description: 'Camping de luxe avec vue sur les montagnes. Tentes safari et installations haut de gamme.',
        region: 'Laurentides',
        city: 'Mont-Tremblant',
        address: '321 Route du Mont',
        latitude: 46.1167,
        longitude: -74.5833,
        listingType: 'glamping',
        pricePerNight: 120.0,
        maxGuests: 4,
        amenities: ['eau', 'feu', 'toilettes', 'douches', 'électricité', 'wifi', 'chauffage'],
        images: [],
        status: 'active',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now(),
      ),
      ListingModel(
        id: 'mock_5',
        hostId: 'mock_host_2',
        title: 'Camping Île d\'Orléans - Vue Panoramique',
        description: 'Camping unique sur l\'île d\'Orléans avec vue imprenable sur le fleuve. Accès à la plage privée.',
        region: 'Capitale-Nationale',
        city: 'Saint-Pierre-de-l\'Île-d\'Orléans',
        address: '654 Chemin Royal',
        latitude: 46.8833,
        longitude: -71.0167,
        listingType: 'tent',
        pricePerNight: 55.0,
        maxGuests: 5,
        amenities: ['eau', 'feu', 'toilettes', 'douches', 'plage'],
        images: [],
        status: 'active',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now(),
      ),
    ];
  }
  
  // Profil mock
  ProfileModel getMockProfile(String userId) {
    return ProfileModel(
      id: userId,
      email: 'demo@campbnb.ca',
      fullName: 'Utilisateur Démo',
      phone: '+1 (514) 123-4567',
      avatar: null,
      bio: 'Passionné de camping et de plein air au Québec',
      createdAt: DateTime.now().subtract(const Duration(days: 100)),
      updatedAt: DateTime.now(),
    );
  }
  
  // Réservations mock
  List<BookingModel> getMockBookings(String userId) {
    return [
      BookingModel(
        id: 'mock_booking_1',
        listingId: 'mock_1',
        guestId: userId,
        hostId: 'mock_host_1',
        checkIn: DateTime.now().add(const Duration(days: 7)),
        checkOut: DateTime.now().add(const Duration(days: 10)),
        guests: 2,
        totalPrice: 135.0,
        status: 'confirmed',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      BookingModel(
        id: 'mock_booking_2',
        listingId: 'mock_2',
        guestId: userId,
        hostId: 'mock_host_2',
        checkIn: DateTime.now().add(const Duration(days: 20)),
        checkOut: DateTime.now().add(const Duration(days: 25)),
        guests: 4,
        totalPrice: 425.0,
        status: 'pending',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }
  
  // Favoris mock
  List<String> getMockFavorites(String userId) {
    return ['mock_1', 'mock_4'];
  }
}

