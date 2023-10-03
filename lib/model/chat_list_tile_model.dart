class ChatListTileModel {
  final String chatId;
  final String interlocutorUid;
  final String interlocutorName;
  final String? interlocutorImageUrl;

  ChatListTileModel({
    required this.chatId,
    required this.interlocutorUid,
    required this.interlocutorName,
    this.interlocutorImageUrl,
  });
}
