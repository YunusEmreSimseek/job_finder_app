import 'package:flutter/material.dart';
import 'package:job_finder_app/features/job_detail/view/job_detail_view.dart';
import 'package:job_finder_app/features/posts/view/posts_view.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/dialogs/create_post_dialog.dart';
import 'package:job_finder_app/products/widgets/dialogs/edit_post_dialog.dart';
import 'package:kartal/kartal.dart';

mixin PostsMixin on State<PostsView> {
  final ValueNotifier<bool> isCreatedPosts = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> createAd() async {
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

  Future<void> navigateToEditDialog(PostViewModel post) async {
    await EditPostDialog.show(context: context, post: post);
  }

  void onChangedDropDownButton(int value) {
    if (value == 0) {
      changePostSourceToFavourites();
      return;
    }
    changePostSourceToCreated();
  }
}
