import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_partner/models/chat_info_model.dart';
import 'package:sport_partner/models/message_model.dart';

class ChatService {
  Future<List<ChatInfoModel>> fetchChatsFromFirestore(String userUid) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userUid);

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('chats').where('participants', arrayContains: userRef).get();
    List<ChatInfoModel> chats = [];
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
        ChatInfoModel(
          chatId: chatId,
          interlocutorUid: interlocutorUid,
          interlocutorName: interlocutorName,
          interlocutorImageUrl: interlocutorImageUrl,
        ),
      );
    }
    return chats;
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((querySnapshot) {
      List<MessageModel> messagesList = [];
      for (var doc in querySnapshot.docs) {
        messagesList.add(MessageModel.fromJson(doc.data()));
      }
      return messagesList;
    });
  }

  Future<void> postMessage(String chatId, MessageModel messageModel) async {
    await FirebaseFirestore.instance.collection('chats').doc(chatId).collection('messages').add(messageModel.toJson());
  }

  Future<String> createNewChat(String userUid, String interlocutorId) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userUid);
    final interlocutorRef = FirebaseFirestore.instance.collection('users').doc(interlocutorId);
    final chatRef = await FirebaseFirestore.instance.collection('chats').add({
      'participants': [userRef, interlocutorRef],
    });
    return chatRef.id;
  }
}
