import 'package:flutter/material.dart';
import 'package:job_finder_app/products/widgets/buttons/close_dialog_button.dart';
import 'package:job_finder_app/products/widgets/dialogs/base_dialog.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:kartal/kartal.dart';

final class TextDialog extends StatelessWidget {
  const TextDialog({super.key, required this.text});
  final String text;

  static Future<bool> show({required BuildContext context, required String text}) async {
    await BaseDialog.show<bool>(
      context: context,
      builder: (context) => TextDialog(
        text: text,
      ),
      barrierDismissible: true,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          CloseDialogButton(context: context),
          Padding(
            padding:
                context.padding.horizontalNormal + context.padding.onlyBottomNormal + context.padding.onlyBottomNormal,
            child: GeneralText(
              text,
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
