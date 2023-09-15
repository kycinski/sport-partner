import 'package:flutter/material.dart';

class AddPostController with ChangeNotifier {
  final List<String> _skillLevels = ['beginner', 'intermediate', 'advanced'];
  final List<String> _genders = ['all', 'women', 'men'];
  String? _selectedSkillLevel;
  String _selectedGender = 'all';
  final double _minAge = 18;
  final double _maxAge = 80;
  RangeValues _selectedAgeRange = const RangeValues(18, 80);
  String _description = '';
  String? _error;

  List<String> get skillLevels => _skillLevels;
  List<String> get genders => _genders;
  String? get selectedSkillLevel => _selectedSkillLevel;
  String get selectedGender => _selectedGender;
  RangeValues get selectedAgeRange => _selectedAgeRange;
  double get minAge => _minAge;
  double get maxAge => _maxAge;
  String? get error => _error;

  void setSelectedSkillLevel(String? value) {
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

  Future<void> onSaveClicked(String description) async {
    _description = description;
    _error = null;
    if (_isDataValid()) {
      //save post
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
}
