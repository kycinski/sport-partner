import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterController with ChangeNotifier {
  bool _isRegisterMode = false;
  DateTime _selectedDate = DateTime.now();

  bool get isRegisterMode => _isRegisterMode;
  String get selectedDateAsString {
    return _selectedDate.toLocal().toString().split(' ')[0];
  }

  void switchBetweenLoginAndRegister() {
    _isRegisterMode = !_isRegisterMode;
    notifyListeners();
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

  void signUserUp(
      {required String name, required String email, required String password, required String confirmPassword}) async {
    if (password == confirmPassword) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (error) {
        print(error.code);
      }
    } else {
      print('hasla nie pasuja');
    }
  }
}
