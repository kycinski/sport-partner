import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.imageUrl, required this.size});

  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: imageUrl != null
          ? Image.network(
              imageUrl!,
              height: size,
              width: size,
              fit: BoxFit.cover,
            )
          : Image.asset(
              'assets/images/profile_picture.jpeg',
              height: size,
              width: size,
              fit: BoxFit.cover,
            ),
    );
  }
}
