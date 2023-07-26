import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:sport_partner/model/place.dart';

class PlacesService {
  Future<List<Place>> fetchPlacesFromFirestore({required String city, required String category}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cities')
          .doc(city)
          .collection('places')
          .where('categories', arrayContains: category)
          .get();

      List<Place> placesList = querySnapshot.docs.map((doc) {
        String name = doc['name'];
        GeoPoint geoPoint = doc['coordinates'];
        LatLng coordinates = LatLng(geoPoint.latitude, geoPoint.longitude);
        String address = doc['address'];
        String url = doc['url'];

        return Place(name: name, coordinates: coordinates, address: address, url: url);
      }).toList();

      return placesList;
    } catch (e) {
      print('Error fetching data from Firestore: $e');
      return [];
    }
  }
}
