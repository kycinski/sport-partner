import 'package:latlong2/latlong.dart';
import 'package:sport_partner/models/city_model.dart';

class CitiesData {
  final List<CityModel> _citiesData = [
    CityModel(
      name: 'wroclaw',
      coordinates: const LatLng(51.1170779, 17.0318639),
    ),
    CityModel(
      name: 'warsaw',
      coordinates: const LatLng(52.2330335, 21.0000000),
    ),
    CityModel(
      name: 'cracow',
      coordinates: const LatLng(50.0568695, 19.9400654),
    ),
  ];

  List<String> get citiesNames => _citiesData.map((city) => city.name).toList();
  LatLng getCityCoordinates(String cityName) => _citiesData.firstWhere((city) => city.name == cityName).coordinates;
}
