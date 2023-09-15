import 'package:sport_partner/enums/skill_level.dart';
import 'package:sport_partner/helpers/date_to_age_converter.dart';

class Post {
  String uid;
  String name;
  int age;
  String description;
  SkillLevel skillLevel;
  String? profileImageUrl;

  Post({
    required this.uid,
    required this.name,
    required this.age,
    required this.description,
    required this.skillLevel,
    this.profileImageUrl,
  });

  factory Post.fromJson(dynamic data, dynamic userData) {
    return Post(
      uid: data.id,
      name: userData['name'],
      age: DateToAgeConverter.calculateAge(userData['birthDate']),
      description: data['description'],
      skillLevel: SkillLevelExtension.parseSkillLevel(data['skillLevel']),
      profileImageUrl: userData['profileImageUrl'],
    );
  }
}
