import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/find_place_controller.dart';
import 'package:sport_partner/utils/url_launcher.dart';
import 'package:sport_partner/models/place.dart';

class PlacesListComponent extends StatelessWidget {
  final List<Place> places;
  const PlacesListComponent({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    final findPlaceController = Provider.of<FindPlaceController>(context, listen: false);
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(2, 4),
            blurRadius: 4,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          child: places.isNotEmpty
              ? ListView.builder(
                  itemCount: places.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        if (index % 2 != 0) const Divider(),
                        ListTile(
                          title: Text(places[index].name),
                          subtitle: Text(
                            places[index].address,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          trailing: IconButton(
                            onPressed: () => UrlLauncher.openWebsite(places[index].url),
                            icon: SvgPicture.asset('assets/icons/internet.svg'),
                          ),
                          onTap: () => findPlaceController.showOnMap(places[index].coordinates),
                        ),
                      ],
                    );
                  },
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '   ${'oops'.tr()} ...',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${'findPlaceEmptyList'.tr()}\n😔',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
