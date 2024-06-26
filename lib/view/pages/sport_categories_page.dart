import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/sport_categories_provider.dart';
import 'package:sport_partner/controllers/user_controller.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:sport_partner/view/pages/category_detail_page.dart';
import 'package:sport_partner/view/widgets/app_drawer.dart';
import 'package:sport_partner/view/widgets/custom_gradient_background.dart';
import 'package:sport_partner/view/widgets/main_image_button.dart';

class SportCategoriesPage extends StatefulWidget {
  const SportCategoriesPage({super.key});

  @override
  State<SportCategoriesPage> createState() => _SportCategoriesPageState();
}

class _SportCategoriesPageState extends State<SportCategoriesPage> {
  late StreamSubscription<User?> authStreamSubscription;

  @override
  void initState() {
    super.initState();
    final userController = Provider.of<UserController>(context, listen: false);
    authStreamSubscription = FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        await userController.setUserData(userId: event.uid);
      } else {
        userController.resetState();
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
    final categories = context.read<SportCategoriesProvider>().categories;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text('categories.categories'.tr()),
        flexibleSpace: AppTheme.defaultAppBarTheme,
      ),
      body: CustomGradientBackground(
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return MainImageButton(
              text: 'categories.${categories[index].name}'.tr(),
              imagePath: categories[index].imagePath,
              onClick: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CategoryDetailPage(
                    choosenCategory: categories[index],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
