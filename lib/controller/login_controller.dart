import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sport_partner/services/auth_service.dart';

class LoginController with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  String get selectedDateAsString {
    return _selectedDate.toLocal().toString().split(' ')[0];
  }

  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
    }
    notifyListeners();
  }

  void signUserIn({required String email, required String password, required BuildContext context}) async {
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
