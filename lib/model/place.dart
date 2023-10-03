import 'package:latlong2/latlong.dart';

class Place {
  final String name;
  final LatLng coordinates;
  final String address;
  final String url;

  Place({
    required this.name,
    required this.coordinates,
    required this.address,
    required this.url,
  });
}
