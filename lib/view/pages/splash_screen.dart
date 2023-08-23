import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sport_partner/services/city_service.dart';
import 'package:sport_partner/view/pages/select_city_page.dart';
import 'package:sport_partner/view/pages/sport_categories_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<bool> _checkSelectedCity() async {
    final selectedCity = await CityService().getSelectedCity();
    return selectedCity != null && selectedCity.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkSelectedCity(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return const SportCategoriesPage();
        } else {
          return const SelectCityPage();
        }
      },
    );
  }
}
