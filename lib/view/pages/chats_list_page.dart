import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/chats_controller.dart';
import 'package:sport_partner/controller/user_controller.dart';
import 'package:sport_partner/view/pages/chat_page.dart';

class ChatsListPage extends StatelessWidget {
  const ChatsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userUid = context.read<UserController>().user!.uid;
    context.read<ChatsController>().fetchChatList(userUid);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats list'),
      ),
      body: Consumer<ChatsController>(builder: (context, chatsController, _) {
        return ListView.builder(
          itemCount: chatsController.chats.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: ClipOval(
                child: chatsController.chats[index].interlocutorImageUrl != null
                    ? Image.network(
                        chatsController.chats[index].interlocutorImageUrl!,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/profile_picture.jpeg',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
              ),
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
