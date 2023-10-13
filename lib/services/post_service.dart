import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_partner/models/post.dart';
import 'package:sport_partner/models/post_creation.dart';

class PostService {
  Future<List<Post>> fetchPostsFromFirestore({required String city, required String category}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cities')
          .doc(city)
          .collection('posts')
          .where('category', isEqualTo: category)
          .orderBy('createdAt', descending: true)
          .get();
      List<Post> posts = [];
      for (final doc in querySnapshot.docs) {
        final userData = await doc['userRef'].get();
        posts.add(
          Post.fromJson(doc, userData),
        );
      }
      return posts;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> addPost({required PostCreation postCreation, required String city}) async {
    await FirebaseFirestore.instance.collection('cities').doc(city).collection('posts').add(postCreation.toJson());
  }

  Future<void> deletePost({required String postUid, required String city}) async {
    await FirebaseFirestore.instance.collection('cities').doc(city).collection('posts').doc(postUid).delete();
  }
}
