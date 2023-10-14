import 'package:flutter/material.dart';

class CustomGradientBackground extends StatelessWidget {
  const CustomGradientBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/gradient.jpeg'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
