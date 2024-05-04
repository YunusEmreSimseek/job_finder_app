import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/states/base/base_state.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';

part 'post_state.dart';

final class PostCubit extends Cubit<PostState> {
  PostCubit() : super(const PostState());

  void setPosts({required List<PostViewModel> posts, required String userId}) {
    final createdPosts = posts.where((element) => element.user!.id == userId).toList();
    final favouritesPosts =
        posts.where((element) => element.usersWhoAddedFavourites?.any((e) => e!.id == userId) ?? false).toList();
    emit(state.copyWith(
        posts: posts, createdPosts: createdPosts, favouritesPosts: favouritesPosts, isUpdated: !state.isUpdated));
  }
}
