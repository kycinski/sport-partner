import 'package:flutter/material.dart';
import 'package:sport_partner/model/sport_categories_data.dart';
import 'package:sport_partner/view/pages/category_detail_page.dart';

class SportCategoriesPage extends StatelessWidget {
  const SportCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = SportCategoriesData.categories;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('Kategorie'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 20,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryDetailPage(
                        choosenCategory: categories[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(image: AssetImage(categories[index].image), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(2, 4),
                          blurRadius: 4,
                        )
                      ]),
                  child: Center(
                    child: Text(
                      categories[index].name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
