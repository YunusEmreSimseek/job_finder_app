import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/post_dialog_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/post_mixin.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/buttons/general_button.dart';
import 'package:job_finder_app/products/widgets/texts/large_title_text.dart';
import 'package:kartal/kartal.dart';

final class PostDialog extends StatefulWidget {
  const PostDialog(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.buttonTitle,
      required this.items,
      this.post});
  final PostViewModel? post;
  final String title;
  final void Function() onPressed;
  final String buttonTitle;
  final Column items;

  @override
  State<PostDialog> createState() => _PostDialogState();
}

class _PostDialogState extends State<PostDialog> with BaseViewMixin, PostMixin, PostDialogMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(onPressed: () => closeDialog(), icon: const Icon(Icons.close_outlined))),
          LargeTitleText(widget.title, context: context)
        ],
      ),
      content: SizedBox(
        height: context.sized.dynamicHeight(.53),
        width: context.sized.dynamicWidth(.7),
        child: widget.items,
      ),
      actions: [
        Center(child: GeneralButton(onPressed: () => widget.onPressed(), title: widget.buttonTitle, context: context)),
      ],
    )));
  }
}
