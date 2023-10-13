import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/chats_controller.dart';
import 'package:sport_partner/controllers/user_controller.dart';
import 'package:sport_partner/models/chat_info_model.dart';
import 'package:sport_partner/view/pages/chat/widgets/message_bubble.dart';
import 'package:sport_partner/view/pages/chat/widgets/new_message_field.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.chatListTileModel});

  final ChatInfoModel chatListTileModel;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late String? chatId;

  @override
  void initState() {
    super.initState();
    chatId = widget.chatListTileModel.chatId;
  }

  @override
  Widget build(BuildContext context) {
    final myUser = context.read<UserController>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: chatId != null
                ? StreamBuilder(
                    stream: context.read<ChatsController>().getMessages(chatId!),
                    builder: (context, chatSnapshot) {
                      if (chatSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final chatDocs = chatSnapshot.data;
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        reverse: true,
                        itemCount: chatDocs!.length,
                        itemBuilder: (context, index) {
                          final message = chatDocs[index];
                          return message.authorId == myUser!.uid
                              ? MessageBubble(
                                  message: message.text,
                                  isMe: true,
                                  username: myUser.name!,
                                  userImageUrl: myUser.profileImageUrl,
                                  valueKey: ValueKey(message.text),
                                )
                              : MessageBubble(
                                  message: message.text,
                                  isMe: false,
                                  username: widget.chatListTileModel.interlocutorName,
                                  userImageUrl: widget.chatListTileModel.interlocutorImageUrl,
                                  valueKey: ValueKey(message.text),
                                );
                        },
                      );
                    },
                  )
                : const SizedBox(),
          ),
          NewMessageField(
            onSend: (message) {
              chatId != null
                  ? context.read<ChatsController>().sendMessage(message, myUser!.uid, chatId!)
                  : context
                      .read<ChatsController>()
                      .createNewChat(message, myUser!.uid, widget.chatListTileModel.interlocutorUid)
                      .then((value) {
                      setState(() {
                        chatId = value;
                      });
                    });
            },
          ),
        ],
      ),
    );
  }
}
