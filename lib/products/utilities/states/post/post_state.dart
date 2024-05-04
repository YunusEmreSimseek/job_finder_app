part of 'post_cubit.dart';

final class PostState extends Equatable implements BaseState {
  const PostState({this.posts, this.favouritesPosts, this.createdPosts, this.isUpdated = false});

  final List<PostViewModel>? posts;
  final List<PostViewModel>? favouritesPosts;
  final List<PostViewModel>? createdPosts;
  final bool isUpdated;

  PostState copyWith({
    List<PostViewModel>? posts,
    List<PostViewModel>? favouritesPosts,
    List<PostViewModel>? createdPosts,
    bool? isUpdated,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      favouritesPosts: favouritesPosts ?? favouritesPosts,
      createdPosts: createdPosts ?? this.createdPosts,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }

  @override
  List<Object?> get props => [posts, favouritesPosts, createdPosts, isUpdated];
}
