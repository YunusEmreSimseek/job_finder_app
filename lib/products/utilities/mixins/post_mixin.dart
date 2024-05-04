import 'package:flutter/material.dart';
import 'package:job_finder_app/products/enums/job_skills.dart';
import 'package:job_finder_app/products/models/post_model.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/services/company/company_service_manager.dart';
import 'package:job_finder_app/products/services/post/post_service_manager.dart';
import 'package:job_finder_app/products/services/user/user_service_manager.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/states/post/post_cubit.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';

mixin PostMixin<T extends StatefulWidget> on BaseViewMixin<T> {
  late final PostServiceManager _postServiceManager;
  late final CompanyServiceManager _companyServiceManager;
  late final UserServiceManager _userServiceManager;

  @override
  void initState() {
    super.initState();
    _postServiceManager = PostServiceManager(PostService.instance);
    _companyServiceManager = CompanyServiceManager(CompanyService.instance);
    _userServiceManager = UserServiceManager(UserService.instance);
  }

  Future<void> getAllPosts() async {
    changeLoading();
    final response = await _postServiceManager.getAllPosts();
    if (response != null) {
      final posts = await Future.wait(response.map((e) => toPostViewModel(e)).toList());
      getCubit<PostCubit>().setPosts(posts: posts, userId: getCubit<UserCubit>().state.loggedInUser!.id!);
    }
    changeLoading();
  }

  Future<List<UserModel?>?> getUsersWhoAddedFavourites(List<String>? userIds) async {
    if (userIds == null) return null;
    final users = await Future.wait(userIds.map((e) => _userServiceManager.getUserById(e)).toList());
    if (users.isEmpty) return null;
    return users;
  }

  Future<PostViewModel> toPostViewModel(PostModel post) async {
    final company = await _companyServiceManager.getCompanyById(post.companyId!);
    final user = await _userServiceManager.getUserById(post.userId!);
    final usersWhoAddedFavourites = await getUsersWhoAddedFavourites(post.usersWhoAddedFavourites);

    return PostViewModel(
      id: post.id,
      title: post.title,
      content: post.content,
      date: post.date,
      location: post.location,
      pricePerHour: post.pricePerHour,
      isFullTime: post.isFullTime,
      jobSkills: post.jobSkills?.map((e) => JobSkills.values.firstWhere((element) => element.name == e)).toList(),
      usersWhoAddedFavourites: usersWhoAddedFavourites,
      company: company,
      user: user,
    );
  }

  Future<void> addToFavourites(PostModel post) async {
    changeLoading();
    await _postServiceManager.addToFavourites(post: post, userId: getCubit<UserCubit>().state.loggedInUser!.id!);
    await getAllPosts();
    changeLoading();
  }

  Future<void> deleteFromFavourites(PostModel post) async {
    changeLoading();
    await _postServiceManager.deleteFromFavourites(post: post, userId: getCubit<UserCubit>().state.loggedInUser!.id!);
    await getAllPosts();
    changeLoading();
  }

  Future<bool> createPost(PostModel post) async {
    changeLoading();
    final response = await _postServiceManager.createPost(post);
    await getAllPosts();
    changeLoading();
    return response;
  }

  Future<void> updatePost(PostModel post) async {
    changeLoading();
    await _postServiceManager.updatePost(post);
    await getAllPosts();
    changeLoading();
  }
}
