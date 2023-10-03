import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_partner/model/chat_list_tile_model.dart';
import 'package:sport_partner/model/message_model.dart';

class ChatService {
  Future<List<ChatListTileModel>> fetchChatsFromFirestore(String userUid) async {
    // final List<ChatListTileModel> chats = [];

    final userRef = FirebaseFirestore.instance.collection('users').doc(userUid);

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('chats').where('participants', arrayContains: userRef).get();

    // print(querySnapshot.docs.first.get('participants')[1] == userRef);
    // var interlocutor;
    // if (querySnapshot.docs.first.get('participants')[0] != userRef) {
    //   interlocutor = await querySnapshot.docs.first.get('participants')[0].get();
    // } else {
    //   interlocutor = await querySnapshot.docs.first.get('participants')[1].get();
    // }
    // print(interlocutor['name']);

    // List<ChatListTileModel> chats = querySnapshot.docs.map((doc) async {
    //   // print(querySnapshot.docs.first.get('participants')[1] == userRef);
    //   var interlocutor;
    //   if (doc.get('participants')[0] != userRef) {
    //     interlocutor = await doc.get('participants')[0].get();
    //   } else {
    //     interlocutor = await doc.get('participants')[1].get();
    //   }
    //   print(interlocutor['name']);
    //   String chatId = doc.id;
    //   String interlocutorUid = interlocutor.id;
    //   String interlocutorName = interlocutor['name'];
    //   return ChatListTileModel(chatId: chatId, interlocutorUid: interlocutorUid, interlocutorName: interlocutorName);
    // }).toList();
    List<ChatListTileModel> chats = [];
    for (final doc in querySnapshot.docs) {
      var interlocutor;
      if (doc.get('participants')[0] != userRef) {
        interlocutor = await doc.get('participants')[0].get();
      } else {
        interlocutor = await doc.get('participants')[1].get();
      }
      print(interlocutor['name']);
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
    // List<ChatListTileModel> placesList querySnapshot.docs.map((doc) {
    //   String name = doc['name'];
    //   GeoPoint geoPoint = doc['coordinates'];
    //   LatLng coordinates = LatLng(geoPoint.latitude, geoPoint.longitude);
    //   String address = doc['address'];
    //   String url = doc['url'];

    //   return Place(name: name, coordinates: coordinates, address: address, url: url);
    // }).toList();

    return chats;
  }

  // Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String chatId) {
  //   // final messages = FirebaseFirestore.instance.collection('chats').orderBy('createdAt', descending: true).snapshots();
  //   final messages = FirebaseFirestore.instance
  //       .collection('chats')
  //       .doc(chatId)
  //       .collection('messages')
  //       .orderBy('createdAt')
  //       .snapshots();
  //   // print(messages.data.docs);
  //   return messages;
  // }
  Stream<List<MessageModel>> getMessages(String chatId) {
    print('thisss');
    // final messages = FirebaseFirestore.instance.collection('chats').orderBy('createdAt', descending: true).snapshots();
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .map((querySnapshot) {
      List<MessageModel> messagesList = [];
      for (var doc in querySnapshot.docs) {
        print(doc.data());
        messagesList.add(MessageModel.fromJson(doc.data()));
      }
      print('messagesList');
      return messagesList;
    });
    // print(messages.data.docs);
  }
}
