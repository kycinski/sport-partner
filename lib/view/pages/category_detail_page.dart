import 'package:flutter/material.dart';
import 'package:sport_partner/model/sport_category.dart';

class CategoryDetailPage extends StatelessWidget {
  final SportCategory choosenCategory;

  const CategoryDetailPage({super.key, required this.choosenCategory});

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 20),
              ChooseActionButton(
                text: 'ZASADY GRY',
                imagePath: 'assets/images/rules.jpg',
                onClick: () {},
              ),
              const SizedBox(height: 20),
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

  const ChooseActionButton({
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
                offset: const Offset(0, 4),
                blurRadius: 4,
              )
            ]),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
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
