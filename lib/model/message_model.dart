class MessageModel {
  String authorId;
  String text;
  // DateTime createdAt;

  MessageModel({required this.authorId, required this.text});

  factory MessageModel.fromJson(dynamic data) {
    return MessageModel(
      authorId: data['userUid'],
      text: data['text'],
      // createdAt: data['createdAt'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userUid': authorId,
      'text': text,
      // 'createdAt': createdAt.toString(),
    };
  }
}
