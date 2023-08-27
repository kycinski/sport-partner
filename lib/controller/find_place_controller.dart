import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sport_partner/model/place.dart';
import 'package:sport_partner/services/city_service.dart';
import 'package:sport_partner/services/places_service.dart';
import 'package:url_launcher/url_launcher.dart';

class FindPlaceController with ChangeNotifier {
  MapController? _mapController;
  List<Place> _placesList = [];
  final PlacesService _placesService = PlacesService();

  MapController? get mapController => _mapController;
  List<Place> get placesList => _placesList;

  void setMapController() {
    _mapController = MapController();
  }

  void disposeMapController() {
    _mapController?.dispose();
  }

  Future<void> fetchPlaces() async {
    final city = await CityService().getSelectedCity();
    _placesList = await _placesService.fetchPlacesFromFirestore(city: city!, category: 'squash');
    notifyListeners();
  }

  void showOnMap(LatLng coordinates) {
    _mapController?.move(coordinates, 15);
    notifyListeners();
  }

  Future<void> openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $uri';
    }
  }
}
