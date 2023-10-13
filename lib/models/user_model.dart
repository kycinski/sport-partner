class UserModel {
  String uid;
  String? name;
  DateTime? birthDate;
  String? gender;
  String? profileImageUrl;

  UserModel({
    required this.uid,
    this.name,
    this.birthDate,
    this.gender,
    this.profileImageUrl,
  });

  factory UserModel.fromJson(String userUid, Map<String, dynamic> json) {
    return UserModel(
      uid: userUid,
      name: json['name'],
      birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      gender: json['gender'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthDate': birthDate?.toIso8601String(),
      'gender': gender,
      'profileImageUrl': profileImageUrl,
    };
  }
}
