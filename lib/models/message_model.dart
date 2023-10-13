import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String authorId;
  String text;

  MessageModel({required this.authorId, required this.text});

  factory MessageModel.fromJson(dynamic data) {
    return MessageModel(
      authorId: data['userId'],
      text: data['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': authorId,
      'text': text,
      'createdAt': Timestamp.now(),
    };
  }
}
