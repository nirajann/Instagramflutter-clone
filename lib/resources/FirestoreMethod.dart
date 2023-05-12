import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/Posts.dart';
import 'package:instagram_flutter/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload poast
  Future<String> uploadPost(String description, String uid, String username,
      Uint8List file, String profImages) async {
    String res = 'some error occured';
    try {
      String photoUrl =
          await StorageMethod().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();

      Post post = Post(
          description: description,
          uid: uid,
          postId: postId,
          username: username,
          datePublished: DateTime.now(),
          PostUrl: photoUrl,
          profImages: profImages,
          likes: {});

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
