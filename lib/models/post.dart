import 'package:flutter/material.dart';
import 'package:sport_partner/enums/skill_level.dart';
import 'package:sport_partner/utils/date_to_age_converter.dart';

class Post {
  String uid;
  String userId;
  String name;
  int age;
  String description;
  SkillLevel skillLevel;
  String? profileImageUrl;
  String desiredGender;
  RangeValues desiredAgeRange;

  Post({
    required this.uid,
    required this.userId,
    required this.name,
    required this.age,
    required this.description,
    required this.skillLevel,
    this.profileImageUrl,
    required this.desiredGender,
    required this.desiredAgeRange,
  });

  factory Post.fromJson(dynamic data, dynamic userData) {
    return Post(
      uid: data.id,
      userId: data['userRef'].id,
      name: userData['name'],
      age: DateToAgeConverter.calculateAgeFromStringDate(userData['birthDate']),
      description: data['description'],
      skillLevel: SkillLevelExtension.parseSkillLevel(data['skillLevel']),
      profileImageUrl: userData['profileImageUrl'],
      desiredGender: data['desiredGender'],
      desiredAgeRange: RangeValues(data['desiredAgeRange'][0].toDouble(), data['desiredAgeRange'][1].toDouble()),
    );
  }
}
