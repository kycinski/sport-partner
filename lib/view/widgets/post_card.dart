import 'package:flutter/material.dart';
import 'package:sport_partner/model/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(2, 4),
            blurRadius: 4,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/profile_picture.jpeg',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${post.name}, ${post.age}',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        post.level,
                        style: const TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            post.description,
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          SizedBox(
            height: 35,
            width: double.infinity,
            child: Material(
              color: Colors.amber,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              child: InkWell(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                onTap: () {},
                child: const Center(
                  child: Text(
                    'Odpowiedz',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
