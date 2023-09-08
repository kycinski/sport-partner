import 'package:flutter/material.dart';
import 'package:sport_partner/model/post.dart';
import 'package:sport_partner/services/city_service.dart';
import 'package:sport_partner/services/post_service.dart';

class FindPartnerController with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<void> fetchPosts() async {
    final city = await CityService().getSelectedCity();
    _posts = await PostService().fetchPostsFromFirestore(city: city!, category: 'tennis');
    notifyListeners();
  }
}
