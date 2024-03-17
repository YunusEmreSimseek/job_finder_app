import 'package:job_finder_app/products/enums/firebase_collections.dart';
import 'package:job_finder_app/products/models/post_model.dart';
import 'package:logger/logger.dart';

abstract class IPostService {
  Future<PostModel?> getPostById(String postId);
  Future<List<PostModel>?> getAllPosts();
}

final class PostService implements IPostService {
  final _postReference = FirebaseCollections.post.reference;

  @override
  Future<List<PostModel>?> getAllPosts() async {
    final response = await _postReference
        .withConverter(
          fromFirestore: (snapshot, options) => const PostModel().fromFirebase(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();
    if (response.docs.isNotEmpty) {
      Logger().i('Posts found');
      final posts = response.docs.map((e) => e.data()).toList();
      return posts;
    }
    Logger().i('Posts not found');
    return null;
  }

  @override
  Future<PostModel?> getPostById(String postId) async {
    final response = await _postReference
        .where('id', isEqualTo: postId)
        .withConverter(
          fromFirestore: (snapshot, options) => const PostModel(),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();
    if (response.docs.isNotEmpty) {
      Logger().i('Post found');
      final post = response.docs.map((e) => e.data()).first;
      return post;
    }
    Logger().i('Post not found');
    return null;
  }
}
