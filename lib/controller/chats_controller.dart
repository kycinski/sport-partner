import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sport_partner/model/chat_list_tile_model.dart';
import 'package:sport_partner/model/message_model.dart';
import 'package:sport_partner/services/chat_service.dart';

class ChatsController with ChangeNotifier {
  List<ChatListTileModel> _chats = [];

  List<ChatListTileModel> get chats => _chats;

  Future<void> fetchChatList(String userUid) async {
    _chats = await ChatService().fetchChatsFromFirestore(userUid);
    notifyListeners();
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return ChatService().getMessages(chatId);
  }

  void sendMessage(String textMessage, String userUid, String chatId) {
    FirebaseFirestore.instance.collection('chats').doc(chatId).collection('messages').add({
      'text': textMessage,
      'createdAt': Timestamp.now(),
      'userUid': userUid,
    });
  }
}
