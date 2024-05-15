import 'package:flutter/material.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/dialogs/edit_post/edit_post_dialog.dart';

final class EditButton extends InkWell {
  EditButton({super.key, required BuildContext context, required PostViewModel post})
      : super(
            onTap: () async => await EditPostDialog.show(context: context, post: post), child: const Icon(Icons.edit));
}
