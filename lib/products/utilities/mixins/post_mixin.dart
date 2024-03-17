import 'package:flutter/material.dart';
import 'package:job_finder_app/products/enums/job_skills.dart';
import 'package:job_finder_app/products/models/post_model.dart';
import 'package:job_finder_app/products/services/company/company_service.dart';
import 'package:job_finder_app/products/services/post/post_service.dart';
import 'package:job_finder_app/products/services/user/user_service.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/states/post/post_cubit.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';

mixin PostMixin<T extends StatefulWidget> on BaseViewMixin<T> {
  final IPostService _postService = PostService();
  final ICompanyService _companyService = CompanyService();
  final IUserService _userService = UserService();

  Future<void> getAllPosts() async {
    final response = await _postService.getAllPosts();
    if (response != null) {
      final posts = await Future.wait(response.map((e) => toPostViewModel(e)).toList());
      getCubit<PostCubit>().setPosts(posts);
    }
  }

  Future<PostViewModel> toPostViewModel(PostModel post) async {
    final company = await _companyService.getCompanyById(post.companyId!);
    final user = await _userService.getUserById(post.userId!);

    return PostViewModel(
      id: post.id,
      title: post.title,
      content: post.content,
      date: post.date,
      location: post.location,
      pricePerHour: post.pricePerHour,
      isFullTime: post.isFullTime,
      jobSkills: post.jobSkills?.map((e) => JobSkills.values.firstWhere((element) => element.name == e)).toList(),
      company: company,
      user: user,
    );
  }
}
