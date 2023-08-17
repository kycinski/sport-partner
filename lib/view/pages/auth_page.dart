import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_partner/view/pages/login_or_register.dart';
import 'package:sport_partner/view/pages/sport_categories_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const SportCategoriesPage();
        } else {
          return const LoginOrRegisterPage();
        }
      },
    );
  }
}