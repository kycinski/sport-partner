import 'package:flutter/material.dart';
import 'package:sport_partner/model/chat_info_model.dart';
import 'package:sport_partner/model/message_model.dart';
import 'package:sport_partner/services/chat_service.dart';

class ChatsController with ChangeNotifier {
  List<ChatInfoModel> _chats = [];

  List<ChatInfoModel> get chats => _chats;

  Future<void> fetchChatList(String userUid) async {
    _chats = await ChatService().fetchChatsFromFirestore(userUid);
    notifyListeners();
  }

  Future<ChatInfoModel> getChatInfoModelForUsers(String userUid, String interlocutorId, String interlocutorName) async {
    await fetchChatList(userUid);
    return chats.firstWhere(
      (chat) => chat.interlocutorUid == interlocutorId,
      orElse: () => ChatInfoModel(chatId: null, interlocutorUid: interlocutorId, interlocutorName: interlocutorName),
    );
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return ChatService().getMessages(chatId);
  }

  Future<void> sendMessage(String textMessage, String userUid, String chatId) async {
    final messageModel = MessageModel(authorId: userUid, text: textMessage);
    await ChatService().postMessage(chatId, messageModel);
  }

  Future<String> createNewChat(String firstTextMessage, String userUid, String interlocutorId) async {
    final newChatId = await ChatService().createNewChat(userUid, interlocutorId);
    await sendMessage(firstTextMessage, userUid, newChatId);
    return newChatId;
  }
}
