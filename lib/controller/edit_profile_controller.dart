import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sport_partner/controller/user_controller.dart';
import 'package:sport_partner/model/user_model.dart';
import 'package:sport_partner/services/users_service.dart';

class EditProfileController with ChangeNotifier {
  UserModel? _userModel;
  late UserController _userController;
  String _newName = '';
  String? _imageUrl;
  String? _newImageUrl;
  DateTime? _selectedDate;
  String? _selectedGender;
  File? _pickedImage;
  bool _profileImageHasBeenRemoved = false;
  String? _error;

  EditProfileController({required UserController userController}) {
    _userController = userController;
    _userModel = userController.user;
    _selectedDate = userController.user?.birthDate;
    _selectedGender = userController.user?.gender;
    _imageUrl = userController.user?.profileImageUrl;
  }

  String? get selectedDateAsString {
    return _selectedDate?.toLocal().toString().split(' ')[0];
  }

  String? get selectedGender => _selectedGender;

  File? get pickedImage {
    if (_pickedImage != null) {
      return _pickedImage;
    }
    return null;
  }

  String? get profileImageUrl {
    return _imageUrl;
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

  void selectGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  Future<void> editProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 150);
    if (pickedFile == null) {
      return;
    }
    _profileImageHasBeenRemoved = false;
    _pickedImage = File(pickedFile.path);
    notifyListeners();
  }

  Future<void> removeProfileImage() async {
    if (_pickedImage != null) {
      _pickedImage = null;
    } else if (_imageUrl != null) {
      _imageUrl = null;
      _profileImageHasBeenRemoved = true;
    }
    notifyListeners();
  }

  Future<void> onSaveClicked(String newName) async {
    _newName = newName;
    _error = null;
    if (_isDataValid() && _hasDataChange()) {
      if (_pickedImage != null) {
        await _uploadUserImage();
      } else if (_profileImageHasBeenRemoved) {
        await _removeUserImageFromStorage();
      }
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
    if (_selectedGender == null) {
      _error = 'Musisz podać płeć';
      return false;
    }
    return true;
  }

  bool _hasDataChange() {
    if (_newName != _userModel?.name ||
        _selectedDate != _userModel?.birthDate ||
        _pickedImage != null ||
        _profileImageHasBeenRemoved ||
        _selectedGender != _userModel?.gender) {
      return true;
    }
    return false;
  }

  Future<void> _uploadUserImage() async {
    final imageUrl = await UserService().uploadUserImage(
      userUid: _userModel!.uid,
      imageFile: _pickedImage!,
    );
    _newImageUrl = imageUrl;
  }

  Future<void> _removeUserImageFromStorage() async {
    await UserService().removeUserImage(userUid: _userModel!.uid);
    _newImageUrl = null;
  }

  Future<void> _changeUserData() async {
    try {
      final newUserModel = UserModel(
        uid: _userModel!.uid,
        name: _newName,
        birthDate: _selectedDate,
        gender: _selectedGender,
        profileImageUrl: _newImageUrl,
      );
      await _userController.updateUserData(
        userModel: newUserModel,
      );
    } catch (error) {
      _error = error.toString();
    }
  }
}
