class UserModel {
  String uid;
  String? name;
  DateTime? birthDate;
  String? sex;
  String? profilePhotoUrl;

  UserModel({
    required this.uid,
    this.name,
    this.birthDate,
    this.sex,
    this.profilePhotoUrl,
  });

  factory UserModel.fromJson(String userUid, Map<String, dynamic> json) {
    return UserModel(
      uid: userUid,
      name: json['name'],
      birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      sex: json['sex'],
      profilePhotoUrl: json['profilePhotoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthDate': birthDate?.toIso8601String(),
      'sex': sex,
      'profilePhotoUrl': profilePhotoUrl,
    };
  }
}
