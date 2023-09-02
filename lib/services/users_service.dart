import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sport_partner/model/user_model.dart';

class UserService {
  static const String _usersCollection = 'users';
  static const String _usersImagesBucket = 'users_images';
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

  Future<String> uploadUserImage({required String userUid, required File imageFile}) async {
    final ref = FirebaseStorage.instance.ref().child(_usersImagesBucket).child('$userUid.jpg');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  Future<void> removeUserImage({required String userUid}) async {
    final ref = FirebaseStorage.instance.ref().child(_usersImagesBucket).child('$userUid.jpg');
    await ref.delete();
  }
}
