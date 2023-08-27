import 'package:flutter/material.dart';
import 'package:sport_partner/controller/user_controller.dart';
import 'package:sport_partner/model/user_model.dart';

class EditProfileController with ChangeNotifier {
  UserModel? _userModel;
  late UserController _userController;
  String _newName = '';
  DateTime? _selectedDate;
  String? _error;

  EditProfileController({required UserController userController}) {
    _userController = userController;
    _userModel = userController.user;
    _selectedDate = userController.user?.birthDate;
  }

  String get selectedDateAsString {
    if (_selectedDate == null) {
      return 'Wybierz datę';
    }
    return _selectedDate!.toLocal().toString().split(' ')[0];
  }

  String? get error => _error;

  Future<void> selectBirthDate(BuildContext context) async {
    final currentDate = DateTime.now();
    final minDate = currentDate.subtract(const Duration(days: 365 * 100));
    final lastDate = currentDate.subtract(const Duration(days: 365 * 13));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: minDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
    }
    notifyListeners();
  }

  Future<void> onSaveClicked(String newName) async {
    _newName = newName;
    _error = null;
    if (_isDataValid() && _hasDataChange()) {
      await _changeUserData();
    }
    notifyListeners();
  }

  bool _isDataValid() {
    if (_newName.isEmpty) {
      _error = 'Imię nie moze być puste';
      return false;
    }
    if (_selectedDate == null) {
      _error = 'Musisz podać datę urodzenia';
      return false;
    }
    return true;
  }

  bool _hasDataChange() {
    if (_newName != _userModel?.name || _selectedDate != _userModel?.birthDate) {
      return true;
    }
    return false;
  }

  Future<void> _changeUserData() async {
    try {
      final newUserModel = UserModel(
        uid: _userModel!.uid,
        name: _newName,
        birthDate: _selectedDate,
        sex: _userModel?.sex,
        profilePhotoUrl: _userModel?.profilePhotoUrl,
      );
      await _userController.updateUserData(
        userModel: newUserModel,
      );
    } catch (error) {
      _error = error.toString();
    }
  }
}
