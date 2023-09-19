import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/find_partner_controller.dart';
import 'package:sport_partner/controller/user_controller.dart';
import 'package:sport_partner/enums/post_category.dart';
import 'package:sport_partner/enums/skill_level.dart';
import 'package:sport_partner/model/post.dart';
import 'package:sport_partner/view/widgets/post_card_button.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  Image _buildImage(String? profileImageUrl) {
    const imageSize = 50.0;
    if (profileImageUrl != null) {
      return Image.network(
        profileImageUrl,
        height: imageSize,
        width: imageSize,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/images/profile_picture.jpeg',
        height: imageSize,
        width: imageSize,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userController = context.read<UserController>();
    final findPartnerController = context.read<FindPartnerController>();
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
                    child: _buildImage(post.profileImageUrl),
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
                          post.skillLevel.skillLevelToString(),
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
            ),
          ),
          if (userController.userLoggedIn)
            Builder(
              builder: (context) {
                final myUser = userController.user!;
                switch (context.read<FindPartnerController>().checkPost(myUser, post)) {
                  case PostCategory.myPost:
                    return PostCardButton(
                      color: Colors.red,
                      child: Text('delete'.tr()),
                      onTap: () => findPartnerController.deletePost(post.uid),
                    );
                  case PostCategory.available:
                    return PostCardButton(
                      color: Colors.amber,
                      child: Text('reply'.tr()),
                      onTap: () {},
                    );
                  case PostCategory.unavailable:
                    return PostCardButton(
                      color: Colors.grey,
                      child: const Text('This post is not available'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Post niedostępny'),
                              content: Text('Nie mozesz odpowiedziec na ten post'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                }
              },
            ),
        ],
      ),
    );
  }
}
