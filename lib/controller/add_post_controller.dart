import 'package:flutter/material.dart';
import 'package:sport_partner/enums/skill_level.dart';
import 'package:sport_partner/model/post_creation.dart';
import 'package:sport_partner/model/user_model.dart';
import 'package:sport_partner/services/city_service.dart';
import 'package:sport_partner/services/post_service.dart';

class AddPostController with ChangeNotifier {
  UserModel? _user;
  final List<String> _genders = ['all', 'woman', 'man'];
  SkillLevel? _selectedSkillLevel;
  String _selectedGender = 'all';
  final double _minAge = 18;
  final double _maxAge = 80;
  RangeValues _selectedAgeRange = const RangeValues(18, 80);
  String _description = '';
  String? _categoryIdName;
  String? _error;

  AddPostController({required UserModel user, required String categoryIdName}) {
    _user = user;
    _categoryIdName = categoryIdName;
  }

  List<String> get genders => _genders;
  SkillLevel? get selectedSkillLevel => _selectedSkillLevel;
  String get selectedGender => _selectedGender;
  RangeValues get selectedAgeRange => _selectedAgeRange;
  double get minAge => _minAge;
  double get maxAge => _maxAge;
  String? get error => _error;

  void setSelectedSkillLevel(SkillLevel value) {
    _selectedSkillLevel = value;
    notifyListeners();
  }

  void setSelectedGender(String value) {
    _selectedGender = value;
    notifyListeners();
  }

  void setSelectedAgeRange(RangeValues value) {
    _selectedAgeRange = value;
    notifyListeners();
  }

  Future<void> onAddClicked(String description) async {
    _description = description;
    _error = null;
    if (_isDataValid()) {
      await _addPost();
    }
  }

  bool _isDataValid() {
    if (_selectedSkillLevel == null) {
      _error = 'Musisz podać poziom zaawansowania';
      return false;
    }
    if (_description.isEmpty) {
      _error = 'Treść postu nie moze być pusta';
      return false;
    }
    return true;
  }

  Future<void> _addPost() async {
    final city = await CityService().getSelectedCity();
    final postCreation = PostCreation(
      userModel: _user!,
      category: _categoryIdName!,
      skillLevel: _selectedSkillLevel!,
      desiredGender: _selectedGender,
      desiredAgeRange: [_selectedAgeRange.start.toInt(), _selectedAgeRange.end.toInt()],
      description: _description,
    );
    try {
      await PostService().addPost(postCreation: postCreation, city: city!);
    } catch (error) {
      _error.toString();
    }
  }
}
