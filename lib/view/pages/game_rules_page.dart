import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sport_partner/models/sport_category.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:sport_partner/view/widgets/custom_gradient_background.dart';
import 'package:sport_partner/view/widgets/single_rule_section.dart';

class GameRulesPage extends StatelessWidget {
  const GameRulesPage({super.key, required this.choosenCategory});

  final SportCategory choosenCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mainOptions.gameRules'.tr()),
        flexibleSpace: AppTheme.defaultAppBarTheme,
      ),
      body: CustomGradientBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(choosenCategory.rulesImagePath),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Wrap(
                  children: [
                    Center(
                      child: GradientText(
                        'categories.${choosenCategory.name}'.tr(),
                        colors: [Colors.grey.shade300, Colors.white],
                        gradientType: GradientType.linear,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: choosenCategory.rules.length,
                      itemBuilder: (context, index) {
                        return SingleRuleSection(
                          ruleTitle: choosenCategory.rules[index].ruleTitle,
                          ruleDescription: choosenCategory.rules[index].ruleDescription,
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
