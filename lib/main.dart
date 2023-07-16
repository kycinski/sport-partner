import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/pages/sport_categories_page.dart';
import 'package:sport_partner/providers/sport_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => SportProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const SportCategoriesPage(),
      ),
    );
  }
}
