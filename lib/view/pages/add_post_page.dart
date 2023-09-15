import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/add_post_controller.dart';
import 'package:sport_partner/view/widgets/custom_text_field.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

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
      create: (context) => AddPostController(),
      builder: (context, child) {
        final addPostController = context.watch<AddPostController>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Dodaj post'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Jestem:', style: TextStyle(color: Colors.black)),
                Wrap(
                  spacing: 20,
                  children: addPostController.skillLevels.map((skillLevel) {
                    return FilterChip(
                      label: Text(skillLevel),
                      onSelected: (value) {
                        addPostController.setSelectedSkillLevel(skillLevel);
                      },
                      selected: addPostController.selectedSkillLevel == skillLevel ? true : false,
                    );
                  }).toList(),
                ),
                const Text(
                  'Szukam:',
                  style: TextStyle(color: Colors.black),
                ),
                Wrap(
                  spacing: 20,
                  children: addPostController.genders.map((gender) {
                    return FilterChip(
                      label: Text(gender),
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
                  hintText: 'Description',
                  obscureText: false,
                  minLines: 5,
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await addPostController.onSaveClicked(descriptionController.text.trim());
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
                    child: const Text('Dodaj post'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
