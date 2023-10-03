import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/user_controller.dart';
import 'package:sport_partner/view/pages/chats_list_page.dart';
import 'package:sport_partner/view/pages/edit_profile_page.dart';
import 'package:sport_partner/view/pages/login_or_register.dart';
import 'package:sport_partner/view/pages/select_city_page.dart';
import 'package:sport_partner/view/widgets/profile_image.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Consumer<UserController>(
              builder: (context, userController, child) {
                return userController.userLoggedIn
                    ? _buildAppDrawerForLoggedUser(userController, context)
                    : _buildAppDrawerForNotLoggedUser(context);
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SelectCityPage(),
                  ),
                );
              },
              child: Text('buttons.changeCity'.tr()),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildAppDrawerForLoggedUser(UserController userController, BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 35),
        ProfileImage(imageUrl: userController.user!.profileImageUrl, size: 70),
        const SizedBox(height: 15),
        if (userController.user?.name == null)
          const Text(
            'Aby publikować posty oraz odpowiadać na ogłoszenia uzupełnij swój profil',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        else
          Text(
            'hello'.tr(args: [userController.user!.name!]),
            style: const TextStyle(color: Colors.black),
          ),
        const SizedBox(height: 35),
        ListTile(
          title: Text('buttons.editProfile'.tr()),
          leading: const Icon(Icons.edit),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfilePage(),
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Messages'),
          leading: const Icon(Icons.message),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatsListPage(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('buttons.logout'.tr()),
          leading: const Icon(Icons.logout),
          onTap: () async {
            userController.signOut();
          },
        )
      ],
    );
  }

  Widget _buildAppDrawerForNotLoggedUser(BuildContext context) {
    return Column(
      children: [
        Text(
          'notLoggedMessage'.tr(),
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 20),
        ListTile(
          title: Text('buttons.login'.tr()),
          leading: const Icon(Icons.login),
          onTap: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()));
          },
        )
      ],
    );
  }
}
