import 'package:flutter/material.dart';
import 'package:sport_partner/view/pages/login_page.dart';
import 'package:sport_partner/view/pages/register_page.dart';
import 'package:sport_partner/view/widgets/custom_page_background.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomPageBackground(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: showLoginPage
                  ? LoginPage(switchPageCallback: togglePage)
                  : RegisterPage(switchPageCallback: togglePage),
            ),
          ),
        ),
      ),
    );
  }
}
