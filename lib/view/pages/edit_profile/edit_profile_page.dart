import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/edit_profile_controller.dart';
import 'package:sport_partner/controllers/user_controller.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:sport_partner/view/widgets/custom_page_background.dart';
import 'package:sport_partner/view/widgets/custom_text_field.dart';
import 'package:sport_partner/view/pages/edit_profile/widgets/edit_photo.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: context.read<UserController>().user?.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditProfileController(userController: context.read<UserController>()),
      builder: (context, child) {
        final editProfileController = context.watch<EditProfileController>();
        return CustomPageBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('Edytuj profil'),
              flexibleSpace: AppTheme.defaultAppBarTheme,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 35),
                      const EditPhoto(),
                      const SizedBox(height: 35),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text('gender.man.singular'.tr(), style: const TextStyle(color: Colors.white)),
                              value: 'man',
                              groupValue: editProfileController.selectedGender,
                              onChanged: (value) {
                                editProfileController.selectGender(value!);
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text(
                                'gender.woman.singular'.tr(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              value: 'woman',
                              groupValue: editProfileController.selectedGender,
                              onChanged: (value) {
                                editProfileController.selectGender(value!);
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: CustomTextField(controller: nameController, hintText: 'Imie', obscureText: false),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                const Text(
                                  'Data urodzenia:',
                                  style: TextStyle(fontSize: 15),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    editProfileController.selectBirthDate(context);
                                  },
                                  child: Text(editProfileController.selectedDateAsString ?? 'Wybierz datę'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      ElevatedButton(
                        onPressed: () async {
                          await editProfileController.onSaveClicked(nameController.text.trim());
                          if (context.mounted) {
                            if (editProfileController.error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(editProfileController.error!)),
                              );
                            } else {
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text('Zapisz'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
