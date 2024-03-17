part of 'post_cubit.dart';

final class PostState extends Equatable implements BaseState {
  const PostState({this.posts});

  final List<PostViewModel>? posts;

  PostState copyWith({List<PostViewModel>? posts}) {
    return PostState(posts: posts ?? this.posts);
  }

  @override
  List<Object?> get props => [posts];
}
