import 'package:flutter/material.dart';
import 'package:job_finder_app/features/job_detail/view/job_detail_view.dart';
import 'package:job_finder_app/features/posts/view/posts_view.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/company_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/job_applicants_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/states/post/post_cubit.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/dialogs/applicants/applicants_dialog.dart';
import 'package:job_finder_app/products/widgets/dialogs/create_post/create_post_dialog.dart';
import 'package:job_finder_app/products/widgets/dialogs/question_dialog.dart';
import 'package:kartal/kartal.dart';

mixin PostsMixin
    on BaseViewMixin<PostsView>, JobApplicantsTransactionsMixin, CompanyTransactionsMixin, PostTransactionsMixin {
  late final ValueNotifier<bool> isCreatedPosts;

  @override
  void initState() {
    super.initState();
    isCreatedPosts = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> showCreatePostDialog() async {
    await CreatePostDialog.show(context: context);
  }

  void changePostSourceToCreated() {
    isCreatedPosts.value = true;
  }

  void changePostSourceToFavourites() {
    isCreatedPosts.value = false;
  }

  void navigateToJobDetailView(PostViewModel post) {
    context.route.navigateToPage(JobDetailView(post: post));
  }

  Future<void> showApplicantsDialog(PostViewModel post) async {
    final jobApplicants = post.jobApplicants;
    if (jobApplicants == null) {
      await ApplicantsDialog.show(context: context, jobApplicants: null, post: post.toPostModel());
      return;
    }
    final jobViewModelList = await Future.wait(jobApplicants.map((e) => toJobApplicantsViewModel(e)));
    if (!mounted) return;
    await ApplicantsDialog.show(context: context, jobApplicants: jobViewModelList, post: post.toPostModel());
  }

  void onChangedDropDownButton(int value) {
    if (value == 0) {
      changePostSourceToFavourites();
      return;
    }
    changePostSourceToCreated();
  }

  Future<bool> confirmDismissed() async =>
      await QuestionDialog.show(context: context, question: 'Are you sure you want to delete this post?');

  Future<void> removePost(String postId) async {
    final response = await postServiceManager.deletePost(postId);
    if (!response) return;
    final posts = getCubit<PostCubit>().state.posts;
    if (posts != null) {
      posts.removeWhere((element) => element.id == postId);
      getCubit<PostCubit>().setPosts(posts: posts, userId: getCubit<UserCubit>().state.loggedInUser!.id!);
    }
  }

  Future<void> onPageRefreshed() {
    return Future.delayed(const Duration(seconds: 1), () async {
      await getAndSetCompanies();
      await getAllPostsAndConvertToViewModel();
    });
  }
}
