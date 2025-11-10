import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../core/config/env_config.dart';
import '../core/utils/logger.dart';

/// Service pour la géolocalisation et les cartes
class MapsService {
  static final MapsService _instance = MapsService._internal();
  factory MapsService() => _instance;
  MapsService._internal();
  
  // ============================================
  // GÉOLOCALISATION
  // ============================================
  
  /// Obtenir la position actuelle de l'utilisateur
  Future<Position?> getCurrentPosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        errorLogger.w('Service de localisation désactivé');
        return null;
      }
      
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          errorLogger.w('Permission de localisation refusée');
          return null;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        errorLogger.w('Permission de localisation refusée définitivement');
        return null;
      }
      
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      errorLogger.e('Erreur géolocalisation: $e');
      return null;
    }
  }
  
  /// Calculer la distance entre deux points
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
  
  /// Convertir une adresse en coordonnées
  Future<Position?> addressToCoordinates(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return Position(
          latitude: locations.first.latitude,
          longitude: locations.first.longitude,
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
      return null;
    } catch (e) {
      errorLogger.e('Erreur géocodage: $e');
      return null;
    }
  }
  
  /// Convertir des coordonnées en adresse
  Future<String?> coordinatesToAddress(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.street}, ${place.locality}, ${place.administrativeArea}';
      }
      return null;
    } catch (e) {
      errorLogger.e('Erreur reverse géocodage: $e');
      return null;
    }
  }
  
  /// Obtenir la région du Québec depuis les coordonnées
  Future<String?> getQuebecRegion(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        final region = placemarks.first.administrativeArea;
        // Vérifier si c'est une région du Québec
        if (region != null && region.contains('Québec')) {
          return region;
        }
      }
      return null;
    } catch (e) {
      errorLogger.e('Erreur récupération région: $e');
      return null;
    }
  }
  
  String get googleMapsApiKey => EnvConfig.googleMapsApiKey;
}

