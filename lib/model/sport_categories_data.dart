import 'package:sport_partner/model/sport_category.dart';

class SportCategoriesData {
  static final List<SportCategory> _categories = [
    SportCategory(id: "1", name: 'Tenis', image: 'assets/images/tennis.jpg'),
    SportCategory(id: "2", name: 'Squash', image: 'assets/images/squash.jpg'),
    SportCategory(id: "3", name: 'Tenis stołowy', image: 'assets/images/table_tennis.jpg'),
    SportCategory(id: "4", name: 'Badminton', image: 'assets/images/badminton.jpg'),
    SportCategory(id: "5", name: 'Padel', image: 'assets/images/padel.jpg'),
    SportCategory(id: "6", name: 'Bilard', image: 'assets/images/bilard.jpg'),
  ];

  static List<SportCategory> get categories => _categories;
}
