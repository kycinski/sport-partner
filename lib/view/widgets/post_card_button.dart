import 'package:flutter/material.dart';

class PostCardButton extends StatelessWidget {
  const PostCardButton({super.key, required this.child, required this.onTap, this.color});

  final Widget child;
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: double.infinity,
      child: Material(
        color: color,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        child: InkWell(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
          onTap: onTap,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
