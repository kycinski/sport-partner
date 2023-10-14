import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/add_post_controller.dart';
import 'package:sport_partner/controllers/user_controller.dart';
import 'package:sport_partner/enums/skill_level.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:sport_partner/view/widgets/custom_gradient_background.dart';
import 'package:sport_partner/view/widgets/custom_text_field.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key, required this.categoryIdName});

  final String categoryIdName;

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  String _buildRangeAgeText(double minAge, double maxAge, RangeValues selectedAge) {
    if (minAge == selectedAge.start.toInt() && maxAge == selectedAge.end.toInt()) {
      return 'W kazdym wieku';
    } else if (maxAge == selectedAge.end.toInt()) {
      return 'Między ${selectedAge.start.toInt()}, a ${maxAge.toInt()}+ lat';
    } else {
      return 'Między ${selectedAge.start.toInt()}, a ${selectedAge.end.toInt()} lat';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          AddPostController(user: context.read<UserController>().user!, categoryIdName: widget.categoryIdName),
      builder: (context, child) {
        final addPostController = context.watch<AddPostController>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('addPost'.tr()),
            flexibleSpace: AppTheme.defaultAppBarTheme,
          ),
          body: CustomGradientBackground(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('iAm'.tr(), style: const TextStyle(color: Colors.black)),
                  Wrap(
                    spacing: 20,
                    children: SkillLevel.values.map((skillLevel) {
                      return FilterChip(
                          label: Text(skillLevel.skillLevelToString()),
                          onSelected: (value) {
                            addPostController.setSelectedSkillLevel(skillLevel);
                          },
                          selected: addPostController.selectedSkillLevel == skillLevel ? true : false);
                    }).toList(),
                  ),
                  Text(
                    'wantPlayWith'.tr(),
                    style: const TextStyle(color: Colors.black),
                  ),
                  Wrap(
                    spacing: 20,
                    children: addPostController.genders.map((gender) {
                      return FilterChip(
                        label: Text('gender.$gender.plural'.tr()),
                        onSelected: (value) {
                          addPostController.setSelectedGender(gender);
                        },
                        selected: addPostController.selectedGender == gender ? true : false,
                      );
                    }).toList(),
                  ),
                  Text(
                    _buildRangeAgeText(
                        addPostController.minAge, addPostController.maxAge, addPostController.selectedAgeRange),
                    style: const TextStyle(color: Colors.black),
                  ),
                  RangeSlider(
                    values: addPostController.selectedAgeRange,
                    onChanged: (value) {
                      addPostController.setSelectedAgeRange(value);
                    },
                    min: addPostController.minAge,
                    max: addPostController.maxAge,
                  ),
                  CustomTextField(
                    controller: descriptionController,
                    hintText: 'description'.tr(),
                    obscureText: false,
                    minLines: 5,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await addPostController.onAddClicked(descriptionController.text.trim());
                        if (context.mounted) {
                          if (addPostController.error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(addPostController.error!)),
                            );
                          } else {
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text('addPost'.tr()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
