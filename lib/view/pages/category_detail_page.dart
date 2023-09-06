import 'package:flutter/material.dart';
import 'package:sport_partner/model/sport_category.dart';
import 'package:sport_partner/view/pages/find_partner_page.dart';
import 'package:sport_partner/view/pages/find_place_page.dart';
import 'package:sport_partner/view/widgets/main_image_button.dart';

class CategoryDetailPage extends StatelessWidget {
  final SportCategory choosenCategory;

  const CategoryDetailPage({super.key, required this.choosenCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(choosenCategory.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              MainImageButton(
                text: 'ZNAJDŹ PARTNERA',
                imagePath: 'assets/images/find_partner.jpg',
                onClick: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FindPartnerPage()));
                },
              ),
              const SizedBox(height: 20),
              MainImageButton(
                text: 'ZASADY GRY',
                imagePath: 'assets/images/rules.jpg',
                onClick: () {},
              ),
              const SizedBox(height: 20),
              MainImageButton(
                text: 'ZNAJDŹ MIEJSCE DO GRY',
                imagePath: 'assets/images/find_place.jpg',
                onClick: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FindPlacePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
