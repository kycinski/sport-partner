import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sport_partner/services/auth_service.dart';

class LoginOrRegisterController with ChangeNotifier {
  bool _isLoginMode = true;

  bool get isLoginMode => _isLoginMode;

  void switchLoginMode() {
    _isLoginMode = !isLoginMode;
    notifyListeners();
  }

  void signInOrSignUp(
      {required String email,
      required String password,
      required String confirmPassword,
      required BuildContext context}) async {
    isLoginMode
        ? _signUserIn(email: email, password: password, context: context)
        : _signUserUp(email: email, password: password, confirmPassword: confirmPassword, context: context);
  }

  void _signUserIn({required String email, required String password, required BuildContext context}) async {
    try {
      await AuthService().signInWithEmailAndPassword(email: email, password: password);
      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('User not found');
      } else if (error.code == 'wrong-password') {
        print('Wrong password');
      }
    }
  }

  void _signUserUp(
      {required String email,
      required String password,
      required String confirmPassword,
      required BuildContext context}) async {
    if (password == confirmPassword) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (context.mounted) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (error) {
        print(error.code);
      }
    } else {
      print('hasla nie pasuja');
    }
  }

  signInWithGoogle(BuildContext context) async {
    await AuthService().signInWithGoogle();
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
