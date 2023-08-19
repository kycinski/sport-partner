import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/user_controller.dart';
import 'package:sport_partner/view/pages/login_or_register.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Consumer<UserController>(builder: (context, userController, child) {
          return userController.userLoggedIn
              ? _buildAppDrawerForLoggedUser(userController)
              : _buildAppDrawerForNotLoggedUser(context);
        }),
      ),
    );
  }

  Widget _buildAppDrawerForLoggedUser(UserController userController) {
    return Column(
      children: [
        const SizedBox(height: 35),
        ClipOval(
          child: Image.asset(
            'assets/images/profile_picture.jpeg',
            height: 70,
          ),
        ),
        const SizedBox(height: 15),
        if (userController.user?.name == null)
          const Text(
            'Aby publikować posty oraz odpowiadać na ogłoszenia uzupełnij swój profil',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        else
          Text('Witaj ${userController.user!.name}'),
        const SizedBox(height: 35),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Edytuj profil'),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            userController.signOut();
          },
          icon: const Icon(Icons.logout),
          label: const Text('Wyloguj'),
        ),
      ],
    );
  }

  Widget _buildAppDrawerForNotLoggedUser(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Zaloguj się aby korzystać z pełnych mozliwosci Sport Partner',
          style: TextStyle(color: Colors.black),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()));
          },
          icon: const Icon(Icons.login),
          label: const Text('Zaloguj'),
        ),
      ],
    );
  }
}
