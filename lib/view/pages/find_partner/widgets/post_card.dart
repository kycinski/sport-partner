import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/chats_controller.dart';
import 'package:sport_partner/controllers/find_partner_controller.dart';
import 'package:sport_partner/controllers/user_controller.dart';
import 'package:sport_partner/enums/post_category.dart';
import 'package:sport_partner/enums/skill_level.dart';
import 'package:sport_partner/models/post.dart';
import 'package:sport_partner/view/pages/chat/chat_page.dart';
import 'package:sport_partner/view/pages/find_partner/widgets/post_card_button.dart';
import 'package:sport_partner/view/widgets/profile_image.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final userController = context.read<UserController>();
    final findPartnerController = context.read<FindPartnerController>();
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
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
                  ProfileImage(imageUrl: post.profileImageUrl, size: 50),
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
          if (userController.userLoggedIn && userController.userConfirmedDetails)
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
                      onTap: () async {
                        await context
                            .read<ChatsController>()
                            .getChatInfoModelForUsers(myUser.uid, post.userId, post.name)
                            .then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                chatListTileModel: value,
                              ),
                            ),
                          );
                        });
                      },
                    );
                  case PostCategory.unavailable:
                    return PostCardButton(
                      color: Colors.grey,
                      child: Text('postNotAvailable'.tr()),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('postNotAvailable'.tr()),
                              content: Text('postNotAvailableExplanation'.tr()),
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
