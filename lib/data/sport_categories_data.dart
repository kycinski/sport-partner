import 'package:sport_partner/models/sport_category.dart';

class SportCategoriesData {
  static final List<SportCategory> _categories = [
    SportCategory(name: "tennis", imagePath: 'assets/images/tennis.jpeg'),
    SportCategory(name: "squash", imagePath: 'assets/images/squash.jpeg'),
    SportCategory(name: "table_tennis", imagePath: 'assets/images/table_tennis.jpeg'),
    SportCategory(name: "badminton", imagePath: 'assets/images/badminton.jpeg'),
    SportCategory(name: "dart", imagePath: 'assets/images/dart.jpeg'),
    SportCategory(name: "billiard", imagePath: 'assets/images/billiard.jpeg'),
  ];

  static List<SportCategory> get categories => _categories;
}
