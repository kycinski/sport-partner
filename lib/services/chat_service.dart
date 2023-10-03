import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_partner/model/chat_list_tile_model.dart';
import 'package:sport_partner/model/message_model.dart';

class ChatService {
  Future<List<ChatListTileModel>> fetchChatsFromFirestore(String userUid) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userUid);

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('chats').where('participants', arrayContains: userRef).get();
    List<ChatListTileModel> chats = [];
    for (final doc in querySnapshot.docs) {
      var interlocutor;
      if (doc.get('participants')[0] != userRef) {
        interlocutor = await doc.get('participants')[0].get();
      } else {
        interlocutor = await doc.get('participants')[1].get();
      }
      String chatId = doc.id;
      String interlocutorUid = interlocutor.id;
      String interlocutorName = interlocutor['name'];
      String? interlocutorImageUrl = interlocutor['profileImageUrl'];
      chats.add(
        ChatListTileModel(
            chatId: chatId,
            interlocutorUid: interlocutorUid,
            interlocutorName: interlocutorName,
            interlocutorImageUrl: interlocutorImageUrl),
      );
    }
    return chats;
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .map((querySnapshot) {
      List<MessageModel> messagesList = [];
      for (var doc in querySnapshot.docs) {
        messagesList.add(MessageModel.fromJson(doc.data()));
      }
      return messagesList;
    });
  }
}
