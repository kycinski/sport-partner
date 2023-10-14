import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sport_partner/models/place.dart';
import 'package:sport_partner/services/city_service.dart';
import 'package:sport_partner/services/places_service.dart';

class FindPlaceController with ChangeNotifier {
  MapController? _mapController;
  List<Place> _placesList = [];
  final PlacesService _placesService = PlacesService();

  MapController? get mapController => _mapController;
  List<Place> get placesList => _placesList;

  void setMapController(MapController mapController) {
    _mapController = mapController;
  }

  Future<void> fetchPlaces(String categoryId) async {
    final city = await CityService().getSelectedCity();
    _placesList = await _placesService.fetchPlacesFromFirestore(city: city!, category: categoryId);
    notifyListeners();
  }

  void showOnMap(LatLng coordinates) {
    _mapController?.move(coordinates, 15);
    notifyListeners();
  }
}
