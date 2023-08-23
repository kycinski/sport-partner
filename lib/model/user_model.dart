class UserModel {
  String uid;
  String? name;
  String? birthDate;
  String? sex;
  String? profilePhotoUrl;

  UserModel({
    required this.uid,
    this.name,
    this.birthDate,
    this.sex,
    this.profilePhotoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      birthDate: json['birthDate'],
      sex: json['sex'],
      profilePhotoUrl: json['profilePhotoUrl'],
    );
  }
}
