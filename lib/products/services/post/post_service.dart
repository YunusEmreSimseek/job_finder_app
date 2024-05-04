part of 'post_service_manager.dart';

abstract class IPostService {
  Future<PostModel?> getPostById(String postId);
  Future<List<PostModel>?> getAllPosts();
  Future<bool> createPost(PostModel post);
  Future<void> updatePost(PostModel post);
  Future<List<PostModel>?> getFavouritePostsOfUser(String userId);
  Future<void> addToFavourites({required PostModel post, required String userId});
  Future<void> deleteFromFavourites({required PostModel post, required String userId});
}

final class PostService implements IPostService {
  // Singleton
  static PostService? _instance;
  static PostService get instance {
    _instance ??= PostService._init();
    return _instance!;
  }

  PostService._init();

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

  @override
  Future<bool> createPost(PostModel post) async {
    final response = await _postReference.add(post.toJson());
    if (response.id.isEmpty) {
      Logger().e('Register Firestore Failed');
      return false;
    }
    Logger().i('Register Firestore Success');
    await _addIdIntoPost(response);
    return true;
  }

  @override
  Future<void> updatePost(PostModel post) async {
    await _postReference.doc(post.id).update(post.toJson());
  }

  Future<void> _addIdIntoPost(DocumentReference docRef) async {
    await docRef.update({'id': docRef.id});
  }

  @override
  Future<List<PostModel>?> getFavouritePostsOfUser(String userId) async {
    final response = await _postReference
        .where('usersWhoAddedFavourites', arrayContains: userId)
        .withConverter(
          fromFirestore: (snapshot, options) => const PostModel().fromFirebase(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();
    if (response.docs.isNotEmpty) {
      final posts = response.docs.map((e) => e.data()).toList();
      Logger().i('Favourite Posts found');
      return posts;
    }
    Logger().e('Favourite Posts not found');
    return null;
  }

  @override
  Future<void> addToFavourites({required PostModel post, required String userId}) async {
    if (post.usersWhoAddedFavourites == null || post.usersWhoAddedFavourites!.isEmpty) {
      final newPost = post.copyWith(usersWhoAddedFavourites: [userId]);
      await _postReference.doc(post.id).update(newPost.toJson());
      return;
    }
    if (post.usersWhoAddedFavourites!.contains(userId)) {
      return;
    }
    post.usersWhoAddedFavourites!.add(userId);
    await _postReference.doc(post.id).update(post.toJson());
  }

  @override
  Future<void> deleteFromFavourites({required PostModel post, required String userId}) async {
    if (post.usersWhoAddedFavourites == null || post.usersWhoAddedFavourites!.isEmpty) {
      return;
    }
    if (!post.usersWhoAddedFavourites!.contains(userId)) {
      return;
    }
    post.usersWhoAddedFavourites!.remove(userId);
    await _postReference.doc(post.id).update(post.toJson());
  }
}
