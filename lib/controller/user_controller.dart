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
  bool get userConfirmedDetails {
    if (user?.name != null && user?.gender != null && user?.birthDate != null) {
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> setUserData({required String userId}) async {
    final userData = await UserService().getUserData(userId: userId);
    _userLoggedIn = true;
    _user = userData;
    notifyListeners();
  }

  Future<void> updateUserData({required UserModel userModel}) async {
    try {
      await UserService().setUserData(userModel: userModel);
      _user = userModel;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void resetState() {
    _userLoggedIn = false;
    _user = null;
    notifyListeners();
  }
}
