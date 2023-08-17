import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/register_controller.dart';
import 'package:sport_partner/view/widgets/custom_text_field.dart';
import 'package:sport_partner/view/widgets/square_tile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({required this.switchPageCallback, super.key});

  final VoidCallback switchPageCallback;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterController(),
      builder: (context, child) {
        return Consumer<RegisterController>(
          builder: (context, registerController, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 50),
                const Text(
                  'Zarejestruj się!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
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
                                  onPressed: () async => registerController.selectBirthDate(context),
                                  child: Text(registerController.selectedDateAsString),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Hasło',
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: confirmPasswordController,
                        hintText: 'Potwierdź hasło',
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () => registerController.signUserUp(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    confirmPassword: confirmPasswordController.text,
                  ),
                  child: const Text('Zarejestruj'),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Lub kontynuuj z',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(onTap: () {}, imagePath: 'assets/images/google.png'),
                    const SizedBox(width: 25),
                    SquareTile(onTap: () {}, imagePath: 'assets/images/facebook.png')
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Juz masz konto?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.switchPageCallback,
                      child: const Text(
                        'Zaloguj się',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }
}
