import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/mixins/keyboard_scroll_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/post_dialog_mixin.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/buttons/general_button.dart';
import 'package:job_finder_app/products/widgets/texts/title_text.dart';
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

class _PostDialogState extends State<PostDialog>
    with PostTransactionsMixin, BaseViewMixin, KeyboardScrollMixin, PostDialogMixin {
  @override
  Widget build(BuildContext context) {
    scrollToBottomOnKeyboardOpen(context);
    return Center(
        child: SingleChildScrollView(
            controller: scrollController,
            child: AlertDialog(
              titlePadding: EdgeInsets.zero,
              title: Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(onPressed: () => closeDialog(), icon: const Icon(Icons.close_outlined))),
                  //LargeTitleText(widget.title, context: context),
                  TitleText(widget.title, context: context)
                ],
              ),
              content: SizedBox(
                // height: context.sized.dynamicHeight(.69),
                width: context.sized.dynamicWidth(.7),
                child: widget.items,
              ),
              actions: [
                Center(
                    child: GeneralButton(
                        onPressed: () => widget.onPressed(), title: widget.buttonTitle, context: context)),
              ],
            )));
  }
}
