import 'dart:convert';

import 'package:flutter/services.dart';

class SportCategoriesService {
  Future<Map<String, dynamic>> fetchSportCategories() async {
    final jsonString = await rootBundle.loadString('lib/data/sport_categories_data.json');
    return json.decode(jsonString);
  }
}
