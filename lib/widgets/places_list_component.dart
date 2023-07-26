import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/find_place_controller.dart';
import 'package:sport_partner/model/place.dart';

class PlacesListComponent extends StatelessWidget {
  final List<Place> places;
  const PlacesListComponent({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    final findPlaceController = Provider.of<FindPlaceController>(context, listen: false);
    return Container(
      height: 250,
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
          child: ListView.builder(
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
                      onPressed: () => findPlaceController.openLink(places[index].url),
                      icon: SvgPicture.asset('assets/icons/internet.svg'),
                    ),
                    onTap: () => findPlaceController.showOnMap(places[index].coordinates),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
