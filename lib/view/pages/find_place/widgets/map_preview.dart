import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/find_place_controller.dart';
import 'package:sport_partner/helpers/url_launcher.dart';
import 'package:sport_partner/models/place.dart';
import 'package:sport_partner/view/pages/find_place/widgets/cached_network_tile_provider.dart';
import 'package:sport_partner/view/pages/find_place/widgets/map_attribution.dart';

class MapPreview extends StatefulWidget {
  final LatLng initialCoordinates;
  final List<Place> places;
  const MapPreview({
    super.key,
    required this.initialCoordinates,
    required this.places,
  });

  @override
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  @override
  void initState() {
    super.initState();
    Provider.of<FindPlaceController>(context, listen: false).setMapController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(2, 4),
            blurRadius: 4,
          )
        ],
        border: Border.all(
          width: 1,
          color: Colors.black.withOpacity(0.25),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlutterMap(
          options: MapOptions(center: widget.initialCoordinates, zoom: 11),
          mapController: Provider.of<FindPlaceController>(context, listen: false).mapController,
          nonRotatedChildren: [
            MapAttribution(
              source: Text(
                'OpenStreetMap contributors',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () => UrlLauncher.openWebsite('https://www.openstreetmap.org/copyright'),
              backgroundColor: Colors.white.withOpacity(0.6),
            )
          ],
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
              maxZoom: 19,
              tileProvider: CachedNetworkTileProvider(),
            ),
            MarkerLayer(
              markers: _buildMarkers(widget.places),
            )
          ],
        ),
      ),
    );
  }

  List<Marker> _buildMarkers(List<Place> placesList) {
    return placesList.map((place) {
      return Marker(
        point: place.coordinates,
        rotate: true,
        builder: (context) => const Icon(
          Icons.location_pin,
          color: Colors.red,
        ),
      );
    }).toList();
  }
}
