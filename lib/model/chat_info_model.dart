class ChatInfoModel {
  final String? chatId;
  final String interlocutorUid;
  final String interlocutorName;
  final String? interlocutorImageUrl;

  ChatInfoModel({
    required this.chatId,
    required this.interlocutorUid,
    required this.interlocutorName,
    this.interlocutorImageUrl,
  });
}
