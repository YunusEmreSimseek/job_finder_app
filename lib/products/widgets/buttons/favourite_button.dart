import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/enums/icon_size.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/post_mixin.dart';
import 'package:job_finder_app/products/utilities/states/post/post_cubit.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';

final class FavouriteButton extends StatefulWidget {
  const FavouriteButton({super.key, required this.post, this.iconsize = IconSize.def});
  final PostViewModel post;
  final IconSize iconsize;

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> with BaseViewMixin, PostMixin<FavouriteButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        if (state.favouritesPosts!.isEmpty) {
          return IconButton(
              onPressed: () => addToFavourites(widget.post.toPostModel()),
              icon: Icon(
                Icons.favorite_border,
                size: widget.iconsize.value,
              ));
        }
        if (state.favouritesPosts?.contains(widget.post) ?? false == true) {
          return IconButton(
              onPressed: () => deleteFromFavourites(widget.post.toPostModel()),
              icon: Icon(
                Icons.favorite_outlined,
                size: widget.iconsize.value,
              ));
        }
        if (!state.favouritesPosts!.contains(widget.post)) {
          return IconButton(
              onPressed: () => addToFavourites(widget.post.toPostModel()),
              icon: Icon(
                Icons.favorite_border,
                size: widget.iconsize.value,
              ));
        }
        return const SizedBox();
      },
    );
  }
}
