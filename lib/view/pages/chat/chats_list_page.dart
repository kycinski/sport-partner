import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/chats_controller.dart';
import 'package:sport_partner/controllers/user_controller.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:sport_partner/view/pages/chat/chat_page.dart';
import 'package:sport_partner/view/widgets/profile_image.dart';

class ChatsListPage extends StatelessWidget {
  const ChatsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userUid = context.read<UserController>().user!.uid;
    context.read<ChatsController>().fetchChatList(userUid);
    return Scaffold(
      appBar: AppBar(
        title: Text('chatsList'.tr()),
        flexibleSpace: AppTheme.defaultAppBarTheme,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Consumer<ChatsController>(builder: (context, chatsController, _) {
        return ListView.builder(
          itemCount: chatsController.chats.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: ProfileImage(imageUrl: chatsController.chats[index].interlocutorImageUrl, size: 40),
              title: Text(chatsController.chats[index].interlocutorName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      chatListTileModel: chatsController.chats[index],
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
