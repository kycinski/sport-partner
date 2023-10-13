import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/login_or_register_controller.dart';

class SwitchModeSection extends StatelessWidget {
  const SwitchModeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loginOrRegisterController = context.watch<LoginOrRegisterController>();
    final isLoginMode = loginOrRegisterController.isLoginMode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLoginMode ? 'notAmember'.tr() : 'alreadyHaveAnAccount'.tr(),
          style: TextStyle(color: Colors.grey[700]),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: loginOrRegisterController.switchLoginMode,
          child: Text(
            isLoginMode ? 'registerNow'.tr() : 'logIn'.tr(),
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
