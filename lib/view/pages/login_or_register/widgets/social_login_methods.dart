import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/login_or_register_controller.dart';
import 'package:sport_partner/view/pages/login_or_register/widgets/square_tile.dart';

class SocialLoginMethods extends StatelessWidget {
  const SocialLoginMethods({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = context.read<LoginOrRegisterController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SquareTile(
          onTap: () async {
            await loginController.signInWithGoogle(context);
          },
          imagePath: 'assets/images/google.png',
        ),
        const SizedBox(width: 25),
        SquareTile(
          onTap: () async {
            await loginController.signInWithFacebook();
          },
          imagePath: 'assets/images/facebook.png',
        )
      ],
    );
  }
}
