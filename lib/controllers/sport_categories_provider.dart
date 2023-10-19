import 'package:flutter/material.dart';
import 'package:sport_partner/models/sport_category.dart';

class SportCategoriesProvider with ChangeNotifier {
  final List<SportCategory> _categories = [];

  List<SportCategory> get categories => _categories;

  SportCategoriesProvider(Map<String, dynamic> jsonData, String languageCode) {
    jsonData.forEach((key, value) {
      _categories.add(SportCategory.fromJson(key, languageCode, value));
    });
  }
}
