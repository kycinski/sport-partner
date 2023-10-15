import 'package:flutter/material.dart';
import 'package:sport_partner/enums/post_category.dart';
import 'package:sport_partner/utils/date_to_age_converter.dart';
import 'package:sport_partner/models/post.dart';
import 'package:sport_partner/models/user_model.dart';
import 'package:sport_partner/services/city_service.dart';
import 'package:sport_partner/services/post_service.dart';

class FindPartnerController with ChangeNotifier {
  List<Post> _posts = [];
  String? _categoryIdName;

  List<Post> get posts => _posts;

  FindPartnerController(String categoriIdName) {
    _categoryIdName = categoriIdName;
  }

  Future<void> fetchPosts() async {
    final city = await CityService().getSelectedCity();
    _posts = await PostService().fetchPostsFromFirestore(city: city!, category: _categoryIdName!);
    notifyListeners();
  }

  PostCategory checkPost(UserModel currentUser, Post post) {
    bool isGenderMatched() {
      if (post.desiredGender == 'all' || post.desiredGender == currentUser.gender) {
        return true;
      }
      return false;
    }

    bool isAgeMatched() {
      final age = DateToAgeConverter.calculateAgeFromDateTime(currentUser.birthDate!);
      if (age >= post.desiredAgeRange.start && age <= post.desiredAgeRange.end) {
        return true;
      }
      return false;
    }

    if (currentUser.uid == post.userId) {
      return PostCategory.myPost;
    }
    if (isGenderMatched() && isAgeMatched()) {
      return PostCategory.available;
    } else {
      return PostCategory.unavailable;
    }
  }

  Future<void> deletePost(String postUid) async {
    final city = await CityService().getSelectedCity();
    try {
      await PostService().deletePost(postUid: postUid, city: city!);
      _posts.removeWhere((post) => post.uid == postUid);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
