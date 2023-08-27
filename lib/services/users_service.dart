import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_partner/model/user_model.dart';

class UserService {
  static const String _usersCollection = 'users';
  Future<UserModel> getUserData({required String userUid}) async {
    final userData = await FirebaseFirestore.instance.collection(_usersCollection).doc(userUid).get();
    if (!userData.exists) {
      return UserModel(uid: userUid);
    } else {
      return UserModel.fromJson(userUid, userData.data()!);
    }
  }

  Future<void> setUserData({required UserModel userModel}) async {
    await FirebaseFirestore.instance.collection(_usersCollection).doc(userModel.uid).set(userModel.toJson());
  }
}
