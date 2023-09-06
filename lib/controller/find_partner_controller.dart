import 'package:flutter/material.dart';
import 'package:sport_partner/model/post.dart';

class FindPartnerController with ChangeNotifier {
  List<Post> _posts = [
    Post(userUid: 'userUid', name: 'name', age: 1, description: 'description', level: 'Początkujący'),
    Post(
        userUid: '1',
        name: 'Krzysiek',
        age: 25,
        description:
            'dlugin tekst blablalb alb al bl blas bla blks ;a jlj klfda hklsah kshda lkhkl ahlk haslk hklash lkashl sah lash lksah sadlj ash aslk hkahl kalk hklah khaslk hklash lksah klhaslks hlkh lkaskl ',
        level: 'Zaawansowany')
  ];

  List<Post> get posts => _posts;
}
