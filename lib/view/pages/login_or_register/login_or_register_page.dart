import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/login_or_register_controller.dart';
import 'package:sport_partner/view/pages/login_or_register/widgets/login_methods_divider.dart';
import 'package:sport_partner/view/pages/login_or_register/widgets/login_or_register_with_email_section.dart';
import 'package:sport_partner/view/pages/login_or_register/widgets/social_login_methods.dart';
import 'package:sport_partner/view/pages/login_or_register/widgets/switch_mode_section.dart';
import 'package:sport_partner/view/widgets/custom_page_background.dart';

class LoginOrRegisterPage extends StatelessWidget {
  const LoginOrRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginOrRegisterController(),
      builder: (context, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: CustomPageBackground(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/sport_partner_logo.png',
                        height: 200,
                      ),
                      Text(
                        'LogInAndFindYourPerfectSportsPartnerToday'.tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      const LoginOrRegisterWithEmailSection(),
                      const SizedBox(height: 15),
                      const LoginMethodsDivider(),
                      const SizedBox(height: 25),
                      const SocialLoginMethods(),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('buttons.continueAnonymously'.tr()),
                      ),
                      const SizedBox(height: 10),
                      const SwitchModeSection(),
                      const SizedBox(height: 10),
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
