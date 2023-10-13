import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sport_partner/models/user_model.dart';

class UserService {
  static const String _usersCollection = 'users';
  static const String _usersImagesBucket = 'users_images';
  Future<UserModel> getUserData({required String userId}) async {
    final userData = await FirebaseFirestore.instance.collection(_usersCollection).doc(userId).get();
    if (!userData.exists) {
      return UserModel(uid: userId);
    } else {
      return UserModel.fromJson(userId, userData.data()!);
    }
  }

  Future<void> setUserData({required UserModel userModel}) async {
    await FirebaseFirestore.instance.collection(_usersCollection).doc(userModel.uid).set(userModel.toJson());
  }

  Future<String> uploadUserImage({required String userId, required File imageFile}) async {
    final ref = FirebaseStorage.instance.ref().child(_usersImagesBucket).child('$userId.jpg');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  Future<void> removeUserImage({required String userId}) async {
    final ref = FirebaseStorage.instance.ref().child(_usersImagesBucket).child('$userId.jpg');
    await ref.delete();
  }
}
