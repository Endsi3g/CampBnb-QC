import 'package:geolocator/geolocator.dart';
import '../core/utils/logger.dart';

/// Service Maps mock pour le mode sandbox
class MockMapsService {
  static final MockMapsService _instance = MockMapsService._internal();
  factory MockMapsService() => _instance;
  MockMapsService._internal();
  
  // Position mock (Montréal)
  static const double _mockLatitude = 45.5017;
  static const double _mockLongitude = -73.5673;
  
  // ============================================
  // GÉOLOCALISATION
  // ============================================
  
  Future<Position?> getCurrentPosition() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    appLogger.i('Position mock retournée (Montréal)');
    
    return Position(
      latitude: _mockLatitude,
      longitude: _mockLongitude,
      timestamp: DateTime.now(),
      accuracy: 10.0,
      altitude: 36.0,
      altitudeAccuracy: 5.0,
      heading: 0.0,
      headingAccuracy: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );
  }
  
  double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000; // en km
  }
  
  // ============================================
  // GÉOCODAGE
  // ============================================
  
  Future<Position?> addressToCoordinates(String address) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Retourner une position mock basée sur l'adresse
    // En production, cela utiliserait l'API de géocodage
    appLogger.i('Géocodage mock pour: $address');
    
    return Position(
      latitude: _mockLatitude + (address.hashCode % 100) / 1000,
      longitude: _mockLongitude + (address.hashCode % 100) / 1000,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }
  
  Future<String?> coordinatesToAddress(double lat, double lon) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Retourner une adresse mock
    return 'Adresse mock, ${lat.toStringAsFixed(4)}, ${lon.toStringAsFixed(4)}';
  }
  
  Future<String?> getQuebecRegion(double lat, double lon) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Régions mock basées sur les coordonnées
    if (lat > 46.0 && lat < 47.0) {
      return 'Charlevoix';
    } else if (lat > 45.5 && lat < 46.5) {
      return 'Laurentides';
    } else if (lat > 46.0 && lat < 46.5) {
      return 'Lanaudière';
    } else {
      return 'Capitale-Nationale';
    }
  }
  
  String get googleMapsApiKey => 'mock_api_key';
}

