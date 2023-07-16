import 'package:flutter/material.dart';
import 'package:sport_partner/model/sport.dart';

class SportProvider with ChangeNotifier {
  final List<Sport> _categories = [
    Sport(id: "1", name: 'Tenis', image: 'assets/images/tennis.jpg'),
    Sport(id: "2", name: 'Squash', image: 'assets/images/squash.jpg'),
    Sport(id: "3", name: 'Tenis stołowy', image: 'assets/images/table_tennis.jpg'),
    Sport(id: "4", name: 'Badminton', image: 'assets/images/badminton.jpg'),
    Sport(id: "5", name: 'Padel', image: 'assets/images/padel.jpg'),
    Sport(id: "6", name: 'Bilard', image: 'assets/images/bilard.jpg'),
  ];

  List<Sport> get sportCategories => _categories;

  Sport findById(String id) {
    return _categories.firstWhere((element) => element.id == id);
  }
}
