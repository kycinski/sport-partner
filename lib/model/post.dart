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
      skillLevel: _parseSkillLevel(data['skillLevel']),
      profileImageUrl: userData['profileImageUrl'],
    );
  }

  static SkillLevel _parseSkillLevel(String levelString) {
    switch (levelString) {
      case 'beginner':
        return SkillLevel.beginner;
      case 'intermediate':
        return SkillLevel.intermediate;
      case 'advanced':
        return SkillLevel.advanced;
      default:
        throw ArgumentError('Nieprawidłowy poziom zaawansowania: $levelString');
    }
  }

  static String _skillLevelToString(SkillLevel level) {
    switch (level) {
      case SkillLevel.beginner:
        return 'beginner';
      case SkillLevel.intermediate:
        return 'intermediate';
      case SkillLevel.advanced:
        return 'advanced';
    }
  }
}
