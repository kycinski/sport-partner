import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MainImageButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final Function()? onClick;

  const MainImageButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: MediaQuery.of(context).size.height / 4,
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
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onClick,
        child: Center(
          child: GradientText(
            text,
            colors: [Colors.grey.shade300, Colors.white],
            gradientType: GradientType.linear,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
