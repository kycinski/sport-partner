import 'package:flutter/material.dart';
import 'package:sport_partner/model/sport_categories_data.dart';
import 'package:sport_partner/view/pages/category_detail_page.dart';
import 'package:sport_partner/view/widgets/app_drawer.dart';
import 'package:sport_partner/view/widgets/main_image_button.dart';

class SportCategoriesPage extends StatelessWidget {
  const SportCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = SportCategoriesData.categories;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Kategorie'),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return MainImageButton(
              text: categories[index].name,
              imagePath: categories[index].image,
              onClick: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CategoryDetailPage(
                    choosenCategory: categories[index],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
