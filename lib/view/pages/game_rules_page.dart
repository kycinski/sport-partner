import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:sport_partner/view/widgets/custom_gradient_background.dart';
import 'package:sport_partner/view/widgets/single_rule_section.dart';

class GameRulesPage extends StatelessWidget {
  const GameRulesPage({super.key, required this.categoryIdName});

  final String categoryIdName;

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
              Image.asset('assets/images/squash.jpeg'),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Wrap(
                  children: [
                    Center(
                      child: GradientText(
                        'Squash',
                        colors: [Colors.grey.shade300, Colors.white],
                        gradientType: GradientType.linear,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const SingleRuleSection(
                      ruleTitle: 'Zasada nr 1 - Liczenie punktów',
                      ruleDescription:
                          'Mecz squasha trwa do trzech wygranych setów. Każdy set trwa do jedenastu punktów za wyjątkiem sytuacji gdzie obaj zawodnicy zdobyli po dziesięć  punktów. W tym wypadku wygrywa ten, który zdobywa 2 punkty  przewagi.',
                    ),
                    const SingleRuleSection(
                      ruleTitle: 'Zasada nr 2 - Serwis',
                      ruleDescription:
                          'Mecz squasha rozpoczyna się serwisem, a serwującego po raz pierwszy losuje się poprzez pokręcenie rakiety na podłodze kortu. Serwujący, jeśli wykonuje prawidłowo serwis, serwuje na przemian z lewej i prawej strony tak długo dopóki nie przegra wymiany po serwisie. Wygrywający bieżącego seta serwuje po raz pierwszy w następnym. Przed rozpoczęciem każdego seta, oraz po każdym wygraniu serwisu serwujący ma prawo wybrać stronę z której chce serwować po raz pierwszy. Serwujący musi znajdować się przynajmniej częścią jednej stopy w kwadracie serwisowym nie dotykając ową stopą żadnej z linii ograniczających kwadrat. Serwis będzie prawidłowy jeśli uderzona piłka trafi bezpośrednio w ścianę frontową kortu powyżej linii serwisowej a poniżej linii autowej i odbije się od podłogi w polu serwisowym przeciwnika, lub przed odbiciem zostanie przez niego odegrana volleyem.',
                    )
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
