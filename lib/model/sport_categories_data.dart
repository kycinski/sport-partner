import 'package:easy_localization/easy_localization.dart';
import 'package:sport_partner/model/sport_category.dart';

class SportCategoriesData {
  static final List<SportCategory> _categories = [
    SportCategory(idName: "tennis", name: 'categories.tennis'.tr(), image: 'assets/images/tennis.jpg'),
    SportCategory(idName: "squash", name: 'categories.squash'.tr(), image: 'assets/images/squash.jpg'),
    SportCategory(
        idName: "table_tennis", name: 'categories.table_tennis'.tr(), image: 'assets/images/table_tennis.jpg'),
    SportCategory(idName: "badminton", name: 'categories.badminton'.tr(), image: 'assets/images/badminton.jpg'),
    SportCategory(idName: "padel", name: 'categories.padel'.tr(), image: 'assets/images/padel.jpg'),
    SportCategory(idName: "billiard", name: 'categories.billiard'.tr(), image: 'assets/images/bilard.jpg'),
  ];

  static List<SportCategory> get categories => _categories;
}
