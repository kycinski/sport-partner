class RuleModel {
  String ruleTitle;
  String ruleDescription;

  RuleModel({required this.ruleTitle, required this.ruleDescription});

  factory RuleModel.fromJson(Map<String, dynamic> json) {
    return RuleModel(
      ruleTitle: json['ruleTitle'],
      ruleDescription: json['ruleDescription'],
    );
  }
}
