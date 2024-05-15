import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_finder_app/products/models/post_model.dart';
import 'package:job_finder_app/products/utilities/enums/firebase_collections.dart';
import 'package:logger/logger.dart';

part 'post_service.dart';

final class PostManager {
  final IPostService _postService;

  PostManager(IPostService postService) : _postService = postService;

  Future<List<PostModel>?> getAllPosts() async {
    final response = await _postService.getAllPosts();
    return response;
  }

  Future<PostModel?> getPostById(String postId) async {
    final response = await _postService.getPostById(postId);
    return response;
  }

  Future<bool> createPost(PostModel post) async {
    final response = await _postService.createPost(post);
    return response;
  }

  Future<void> updatePost(PostModel post) async {
    await _postService.updatePost(post);
  }

  Future<bool> deletePost(String postId) async {
    final response = await _postService.deletePost(postId);
    return response;
  }

  Future<List<PostModel>?> getFavouritePostsOfUser(String userId) async {
    final response = await _postService.getFavouritePostsOfUser(userId);
    return response;
  }

  Future<void> addToFavourites({required PostModel post, required String userId}) async {
    await _postService.addToFavourites(post: post, userId: userId);
  }

  Future<void> deleteFromFavourites({required PostModel post, required String userId}) async {
    await _postService.deleteFromFavourites(post: post, userId: userId);
  }
}
