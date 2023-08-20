import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/user_controller.dart';
import 'package:sport_partner/services/city_service.dart';
import 'package:sport_partner/view/pages/select_city_page.dart';
import 'package:sport_partner/view/pages/sport_categories_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<User?> authStreamSubscription;

  @override
  void initState() {
    super.initState();
    final userController = Provider.of<UserController>(context, listen: false);
    authStreamSubscription = FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        await userController.setUserData(userUid: event.uid);
        print('zalogowano');
      } else {
        userController.resetState();
        print('wylogowano');
      }
    });
  }

  @override
  void dispose() {
    authStreamSubscription.cancel();
    super.dispose();
  }

  Future<bool> checkSelectedCity() async {
    final selectedCity = await CityService().getSelectedCity();
    return selectedCity != null && selectedCity.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkSelectedCity(),
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
