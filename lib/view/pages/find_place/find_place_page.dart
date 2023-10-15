import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/find_place_controller.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:sport_partner/view/pages/find_place/widgets/map_preview.dart';
import 'package:sport_partner/view/pages/find_place/widgets/places_list_component.dart';
import 'package:sport_partner/view/widgets/custom_gradient_background.dart';

class FindPlacePage extends StatelessWidget {
  const FindPlacePage({super.key, required this.categoryIdName});

  final String categoryIdName;

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
            child: CustomGradientBackground(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FutureBuilder(
                  future: context.read<FindPlaceController>().fetchPlaces(categoryIdName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Consumer<FindPlaceController>(
                        builder: (context, findPlaceController, child) {
                          return Column(
                            children: [
                              Flexible(
                                flex: 2,
                                child: MapPreview(
                                  initialCoordinates: findPlaceController.initialCoordinates,
                                  places: findPlaceController.placesList,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Flexible(
                                flex: 1,
                                child: PlacesListComponent(
                                  places: findPlaceController.placesList,
                                ),
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
          ),
        );
      },
    );
  }
}
