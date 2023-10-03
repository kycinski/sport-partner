import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/chats_controller.dart';
import 'package:sport_partner/controller/user_controller.dart';
import 'package:sport_partner/model/chat_list_tile_model.dart';
import 'package:sport_partner/view/widgets/message_bubble.dart';
import 'package:sport_partner/view/widgets/new_message_field.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.chatListTileModel});

  final ChatListTileModel chatListTileModel;

  @override
  Widget build(BuildContext context) {
    final myUser = context.read<UserController>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder(
                stream: context.read<ChatsController>().getMessages(chatListTileModel.chatId),
                builder: (context, chatSnapshot) {
                  if (chatSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final chatDocs = chatSnapshot.data;
                  return ListView.builder(
                    itemCount: chatDocs!.length,
                    itemBuilder: (context, index) {
                      final message = chatDocs[index];
                      return message.authorId == myUser!.uid
                          ? MessageBubble(
                              message: message.text,
                              isMe: true,
                              username: myUser.name!,
                              userImage: myUser.profileImageUrl!,
                              valueKey: ValueKey(message.text),
                            )
                          : MessageBubble(
                              message: message.text,
                              isMe: false,
                              username: chatListTileModel.interlocutorName,
                              userImage: chatListTileModel.interlocutorImageUrl!,
                              valueKey: ValueKey(message.text),
                            );
                    },
                  );
                }),
          ),
          NewMessageField(
            onSend: (message) {
              context.read<ChatsController>().sendMessage(message, myUser!.uid, chatListTileModel.chatId);
            },
          ),
        ],
      ),
    );
  }
}
