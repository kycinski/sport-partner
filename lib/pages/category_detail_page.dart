import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/providers/sport_provider.dart';

class CategoryDetailPage extends StatelessWidget {
  String categoryId;
  CategoryDetailPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final choosenCategory = Provider.of<SportProvider>(context, listen: false).findById(categoryId);
    return Scaffold(
      appBar: AppBar(
        title: Text(choosenCategory.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ChooseActionButton(
                text: 'ZNAJDŹ PARTNERA',
                imagePath: 'assets/images/find_partner.jpg',
                onClick: () {},
              ),
              SizedBox(height: 20),
              ChooseActionButton(
                text: 'ZASADY GRY',
                imagePath: 'assets/images/rules.jpg',
                onClick: () {},
              ),
              SizedBox(height: 20),
              ChooseActionButton(
                text: 'ZNAJDŹ MIEJSCE DO GRY',
                imagePath: 'assets/images/find_place.jpg',
                onClick: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseActionButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final Function()? onClick;

  ChooseActionButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0, 4),
                blurRadius: 4,
              )
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
