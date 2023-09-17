import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_partner/enums/skill_level.dart';
import 'package:sport_partner/model/user_model.dart';

class PostCreation {
  UserModel userModel;
  String category;
  SkillLevel skillLevel;
  String desiredGender;
  List<int> desiredAgeRange;
  String description;

  PostCreation({
    required this.userModel,
    required this.category,
    required this.skillLevel,
    required this.desiredGender,
    required this.desiredAgeRange,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    final userRef = FirebaseFirestore.instance.collection("users").doc(userModel.uid);
    return {
      'category': category,
      'description': description,
      'skillLevel': skillLevel.name,
      'desiredGender': desiredGender,
      'desiredAgeRange': desiredAgeRange,
      'userRef': userRef,
      'createdAt': Timestamp.now(),
    };
  }
}
