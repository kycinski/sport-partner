import 'package:easy_localization/easy_localization.dart';
import 'package:sport_partner/models/sport_category.dart';

class SportCategoriesData {
  static final List<SportCategory> _categories = [
    SportCategory(idName: "tennis", name: 'categories.tennis'.tr(), image: 'assets/images/tennis.jpeg'),
    SportCategory(idName: "squash", name: 'categories.squash'.tr(), image: 'assets/images/squash.jpeg'),
    SportCategory(
        idName: "table_tennis", name: 'categories.table_tennis'.tr(), image: 'assets/images/table_tennis.jpeg'),
    SportCategory(idName: "badminton", name: 'categories.badminton'.tr(), image: 'assets/images/badminton.jpeg'),
    SportCategory(idName: "dart", name: 'categories.dart'.tr(), image: 'assets/images/dart.jpeg'),
    SportCategory(idName: "billiard", name: 'categories.billiard'.tr(), image: 'assets/images/billiard.jpeg'),
  ];

  static List<SportCategory> get categories => _categories;
}
