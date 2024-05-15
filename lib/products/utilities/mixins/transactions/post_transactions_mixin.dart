import 'package:job_finder_app/products/models/post_model.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/services/post/post_manager.dart';
import 'package:job_finder_app/products/services/user/user_manager.dart';
import 'package:job_finder_app/products/utilities/enums/job_skills.dart';
import 'package:job_finder_app/products/utilities/states/company/company_cubit.dart';
import 'package:job_finder_app/products/utilities/states/post/post_cubit.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';

mixin PostTransactionsMixin {
  late final PostManager _postServiceManager = PostManager(PostService.instance);
  late final UserManager _userServiceManager = UserManager(UserService.instance);

  String get loggedInUserId => UserCubit.instance.state.loggedInUser?.id ?? '';

  Future<void> getAllPostsAndConvertToViewModel() async {
    final response = await _postServiceManager.getAllPosts();
    if (response != null) {
      final posts = await Future.wait(response.map((e) => toPostViewModel(e)).toList());
      PostCubit.instance.setPosts(posts: posts, userId: loggedInUserId);
    }
  }

  Future<List<UserModel?>?> getUsersWhoAddedFavourites(List<String>? userIds) async {
    if (userIds == null) return null;
    final users = await Future.wait(userIds.map((e) async => await _userServiceManager.getUserById(e)).toList());
    if (users.isEmpty) return null;
    return users;
  }

  Future<PostViewModel> toPostViewModel(PostModel post) async {
    final companies = CompanyCubit.instance.state.companies;
    final company = companies?.firstWhere((element) => element.id == post.companyId);
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
      jobApplicants: post.jobApplicants,
    );
  }

  Future<void> addToFavourites(PostModel post) async {
    await _postServiceManager.addToFavourites(post: post, userId: loggedInUserId);
    await getAllPostsAndConvertToViewModel();
  }

  Future<void> deleteFromFavourites(PostModel post) async {
    await _postServiceManager.deleteFromFavourites(post: post, userId: loggedInUserId);
    await getAllPostsAndConvertToViewModel();
  }

  Future<bool> createPost(PostModel post) async {
    final response = await _postServiceManager.createPost(post);
    await getAllPostsAndConvertToViewModel();
    return response;
  }

  Future<void> updatePost(PostModel post) async {
    await _postServiceManager.updatePost(post);
    await getAllPostsAndConvertToViewModel();
  }
}
