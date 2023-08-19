class UserModel {
  String uid;
  String? name;
  String? birthDate;
  String? sex;

  UserModel({
    required this.uid,
    this.name,
    this.birthDate,
    this.sex,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      birthDate: json['birthDate'],
      sex: json['sex'],
    );
  }
}
