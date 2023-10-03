import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/chats_controller.dart';
import 'package:sport_partner/controller/user_controller.dart';
import 'package:sport_partner/model/chat_list_tile_model.dart';
import 'package:sport_partner/services/chat_service.dart';
import 'package:sport_partner/view/widgets/message_bubble.dart';
import 'package:sport_partner/view/widgets/new_message_field.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.chatListTileModel});

  final ChatListTileModel chatListTileModel;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _newMessageController = TextEditingController();

  @override
  void dispose() {
    _newMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myUser = context.read<UserController>().user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder(
                stream: context.read<ChatsController>().getMessages(widget.chatListTileModel.chatId),
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
                              username: widget.chatListTileModel.interlocutorName,
                              userImage: widget.chatListTileModel.interlocutorImageUrl!,
                              valueKey: ValueKey(message.text),
                            );
                    },
                  );
                }),
          ),
          NewMessageField(
            controller: _newMessageController,
            onSend: () {
              context
                  .read<ChatsController>()
                  .sendMessage(_newMessageController.text, myUser!.uid, widget.chatListTileModel.chatId);
            },
          ),
        ],
      ),
    );
  }
}
