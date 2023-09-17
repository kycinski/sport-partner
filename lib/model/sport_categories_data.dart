import 'package:easy_localization/easy_localization.dart';
import 'package:sport_partner/model/sport_category.dart';

class SportCategoriesData {
  static final List<SportCategory> _categories = [
    SportCategory(id: "1", name: 'categories.tennis'.tr(), image: 'assets/images/tennis.jpg'),
    SportCategory(id: "2", name: 'categories.squash'.tr(), image: 'assets/images/squash.jpg'),
    SportCategory(id: "3", name: 'categories.table_tennis'.tr(), image: 'assets/images/table_tennis.jpg'),
    SportCategory(id: "4", name: 'categories.badminton'.tr(), image: 'assets/images/badminton.jpg'),
    SportCategory(id: "5", name: 'categories.padel'.tr(), image: 'assets/images/padel.jpg'),
    SportCategory(id: "6", name: 'categories.billiard'.tr(), image: 'assets/images/bilard.jpg'),
  ];

  static List<SportCategory> get categories => _categories;
}
