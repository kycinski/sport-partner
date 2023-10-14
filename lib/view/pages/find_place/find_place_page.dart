import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/find_place_controller.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:sport_partner/view/pages/find_place/widgets/map_preview.dart';
import 'package:sport_partner/view/pages/find_place/widgets/places_list_component.dart';

class FindPlacePage extends StatelessWidget {
  const FindPlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FindPlaceController(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('mainOptions.findPlace'.tr()),
            flexibleSpace: AppTheme.defaultAppBarTheme,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder(
                future: Provider.of<FindPlaceController>(context, listen: false).fetchPlaces(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Consumer<FindPlaceController>(
                      builder: (context, mapData, child) {
                        return Column(
                          children: [
                            MapPreview(
                              initialCoordinates: const LatLng(51.1270779, 16.9918639),
                              places: mapData.placesList,
                            ),
                            const SizedBox(height: 20),
                            PlacesListComponent(
                              places: mapData.placesList,
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
