import 'package:sport_partner/models/rule_model.dart';

class SportCategory {
  final String name;
  final String imagePath;
  final String rulesImagePath;
  final List<RuleModel> rules;

  SportCategory({required this.name, required this.imagePath, required this.rulesImagePath, required this.rules});

  factory SportCategory.fromJson(String name, String languageCode, Map<String, dynamic> json) {
    final List<RuleModel> rules = [];
    for (final rule in json['rules'][languageCode]) {
      rules.add(RuleModel.fromJson(rule));
    }

    return SportCategory(
      name: name,
      imagePath: json['imagePath'],
      rulesImagePath: json['rulesImagePath'],
      rules: rules,
    );
  }
}
