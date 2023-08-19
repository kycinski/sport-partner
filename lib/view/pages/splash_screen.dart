import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/user_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return SportCategoriesPage();
  }
}
