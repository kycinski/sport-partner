import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/login_or_register_controller.dart';
import 'package:sport_partner/view/widgets/custom_text_field.dart';

class LoginOrRegisterWithEmailSection extends StatefulWidget {
  const LoginOrRegisterWithEmailSection({super.key});

  @override
  State<LoginOrRegisterWithEmailSection> createState() => _LoginOrRegisterWithEmailSectionState();
}

class _LoginOrRegisterWithEmailSectionState extends State<LoginOrRegisterWithEmailSection> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginOrRegisterController = context.watch<LoginOrRegisterController>();
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          hintText: 'Email',
          obscureText: false,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: passwordController,
          hintText: 'password'.tr(),
          obscureText: true,
          maxLines: 1,
        ),
        if (!loginOrRegisterController.isLoginMode)
          Column(
            children: [
              const SizedBox(height: 10),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'confirmPassword'.tr(),
                obscureText: true,
                maxLines: 1,
              ),
            ],
          ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () => loginOrRegisterController.signInOrSignUp(
            email: emailController.text,
            password: passwordController.text,
            confirmPassword: confirmPasswordController.text,
            context: context,
          ),
          child: Text(loginOrRegisterController.isLoginMode ? 'buttons.login'.tr() : 'buttons.register'.tr()),
        ),
      ],
    );
  }
}
