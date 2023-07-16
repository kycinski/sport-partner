import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/pages/category_detail_page.dart';
import 'package:sport_partner/providers/sport_provider.dart';

class SportCategoriesPage extends StatelessWidget {
  const SportCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<SportProvider>(context, listen: false);
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
            itemCount: categoriesProvider.sportCategories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryDetailPage(
                        categoryId: categoriesProvider.sportCategories[index].id,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: AssetImage(categoriesProvider.sportCategories[index].image), fit: BoxFit.cover),
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
                      categoriesProvider.sportCategories[index].name,
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
