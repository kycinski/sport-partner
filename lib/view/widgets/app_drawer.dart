import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/user_controller.dart';
import 'package:sport_partner/view/pages/chat/chats_list_page.dart';
import 'package:sport_partner/view/pages/edit_profile/edit_profile_page.dart';
import 'package:sport_partner/view/pages/login_or_register/login_or_register_page.dart';
import 'package:sport_partner/view/pages/select_city_page.dart';
import 'package:sport_partner/view/widgets/profile_image.dart';
import 'package:sport_partner/utils/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/gradient.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Consumer<UserController>(
                  builder: (context, userController, child) {
                    return userController.userLoggedIn
                        ? _buildAppDrawerForLoggedUser(userController, context)
                        : _buildAppDrawerForNotLoggedUser(context);
                  },
                ),
                const Spacer(),
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    title: Text('buttons.contact'.tr()),
                    leading: const Icon(Icons.contact_support_rounded),
                    onTap: () async {
                      UrlLauncher.sendEmail('krzysiek.kycia1@gmail.com', 'Sport Partner Contact');
                    },
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    title: Text('buttons.changeCity'.tr()),
                    leading: const Icon(Icons.change_circle),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SelectCityPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
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
          Text(
            'completeYourProfileToPublishPosts'.tr(),
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        else
          Text(
            'hello'.tr(args: [userController.user!.name!]),
            style: const TextStyle(color: Colors.black),
          ),
        const SizedBox(height: 30),
        Material(
          color: Colors.transparent,
          child: ListTile(
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
        ),
        Material(
          color: Colors.transparent,
          child: ListTile(
            title: Text('buttons.messages'.tr()),
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
        ),
        Material(
          color: Colors.transparent,
          child: ListTile(
            title: Text('buttons.logout'.tr()),
            leading: const Icon(Icons.logout),
            onTap: () async {
              userController.signOut();
            },
          ),
        )
      ],
    );
  }

  Widget _buildAppDrawerForNotLoggedUser(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/sport_partner_logo.png',
          scale: 6,
        ),
        Text(
          'notLoggedMessage'.tr(),
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Material(
          color: Colors.transparent,
          child: ListTile(
            title: Text('buttons.login'.tr()),
            leading: const Icon(Icons.login),
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()));
            },
          ),
        )
      ],
    );
  }
}
