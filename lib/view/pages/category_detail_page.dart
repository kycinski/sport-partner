import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sport_partner/models/sport_category.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:sport_partner/view/pages/find_partner/find_partner_page.dart';
import 'package:sport_partner/view/pages/find_place/find_place_page.dart';
import 'package:sport_partner/view/widgets/custom_gradient_background.dart';
import 'package:sport_partner/view/widgets/main_image_button.dart';

class CategoryDetailPage extends StatelessWidget {
  final SportCategory choosenCategory;

  const CategoryDetailPage({super.key, required this.choosenCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(choosenCategory.name),
        flexibleSpace: AppTheme.defaultAppBarTheme,
      ),
      body: SafeArea(
        child: CustomGradientBackground(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                MainImageButton(
                  text: 'mainOptions.findPartner'.tr().toUpperCase(),
                  imagePath: 'assets/images/find_partner.jpeg',
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FindPartnerPage(
                          categoryIdName: choosenCategory.idName,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                MainImageButton(
                  text: 'mainOptions.gameRules'.tr().toUpperCase(),
                  imagePath: 'assets/images/rules.jpeg',
                  onClick: () {},
                ),
                const SizedBox(height: 20),
                MainImageButton(
                  text: 'mainOptions.findPlace'.tr().toUpperCase(),
                  imagePath: 'assets/images/find_place.jpeg',
                  onClick: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FindPlacePage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
