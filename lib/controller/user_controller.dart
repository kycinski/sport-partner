import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_partner/model/user_model.dart';
import 'package:sport_partner/services/users_service.dart';

class UserController with ChangeNotifier {
  UserModel? _user;
  bool _userLoggedIn = false;

  UserModel? get user => _user;
  bool get userLoggedIn => _userLoggedIn;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> setUserData({required String userUid}) async {
    final userData = await UserService().getUserData(userUid: userUid);
    _userLoggedIn = true;
    _user = userData;
    notifyListeners();
  }

  void resetState() {
    _userLoggedIn = false;
    _user = null;
    notifyListeners();
  }
}
