import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/find_partner_controller.dart';
import 'package:sport_partner/models/sport_category.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:sport_partner/view/pages/find_partner/find_partner_page.dart';
import 'package:sport_partner/view/pages/find_place/find_place_page.dart';
import 'package:sport_partner/view/pages/game_rules_page.dart';
import 'package:sport_partner/view/widgets/custom_gradient_background.dart';
import 'package:sport_partner/view/widgets/main_image_button.dart';

class CategoryDetailPage extends StatelessWidget {
  final SportCategory choosenCategory;

  const CategoryDetailPage({super.key, required this.choosenCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('categories.${choosenCategory.name}'.tr()),
        flexibleSpace: AppTheme.defaultAppBarTheme,
      ),
      body: CustomGradientBackground(
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
                      builder: (context) => ChangeNotifierProvider(
                          create: (context) => FindPartnerController(choosenCategory.name),
                          builder: (context, _) {
                            return FindPartnerPage(
                              categoryIdName: choosenCategory.name,
                            );
                          }),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              MainImageButton(
                text: 'mainOptions.gameRules'.tr().toUpperCase(),
                imagePath: 'assets/images/rules.jpeg',
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GameRulesPage(
                        choosenCategory: choosenCategory,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              MainImageButton(
                text: 'mainOptions.findPlace'.tr().toUpperCase(),
                imagePath: 'assets/images/find_place.jpeg',
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FindPlacePage(
                        categoryIdName: choosenCategory.name,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
