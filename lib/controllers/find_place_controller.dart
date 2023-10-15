import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sport_partner/data/cities_data.dart';
import 'package:sport_partner/models/place.dart';
import 'package:sport_partner/services/city_service.dart';
import 'package:sport_partner/services/places_service.dart';

class FindPlaceController with ChangeNotifier {
  MapController? _mapController;
  List<Place> _placesList = [];
  String? _city;

  MapController? get mapController => _mapController;
  List<Place> get placesList => _placesList;
  LatLng get initialCoordinates => CitiesData().getCityCoordinates(_city!);

  void setMapController(MapController mapController) {
    _mapController = mapController;
  }

  Future<void> fetchPlaces(String categoryId) async {
    _city = await CityService().getSelectedCity();
    _placesList = await PlacesService().fetchPlacesFromFirestore(city: _city!, category: categoryId);
    notifyListeners();
  }

  void showOnMap(LatLng coordinates) {
    _mapController?.move(coordinates, 15);
    notifyListeners();
  }
}
