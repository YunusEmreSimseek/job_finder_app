import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/states/base/base_state.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';

part 'post_state.dart';

final class PostCubit extends Cubit<PostState> {
  PostCubit() : super(const PostState());

  void setPosts(List<PostViewModel> posts) {
    emit(state.copyWith(posts: posts));
  }
}
