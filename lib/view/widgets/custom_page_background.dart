import 'dart:ui';

import 'package:flutter/material.dart';

class CustomPageBackground extends StatelessWidget {
  final Widget child;

  const CustomPageBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/images/tennis.jpeg"),
          alignment: Alignment.centerRight,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: child,
      ),
    );
  }
}
