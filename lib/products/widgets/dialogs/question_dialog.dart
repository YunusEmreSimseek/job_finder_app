import 'package:flutter/material.dart';
import 'package:job_finder_app/products/widgets/dialogs/base_dialog.dart';
import 'package:job_finder_app/products/widgets/texts/general_button_text.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';

final class QuestionDialog extends StatelessWidget {
  const QuestionDialog({super.key, required this.question});
  final String question;

  static Future<bool> show({required BuildContext context, required String question}) async {
    final response = await BaseDialog.show<bool>(
      context: context,
      builder: (context) => QuestionDialog(
        question: question,
      ),
      barrierDismissible: true,
    );
    return response ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: GeneralText(
        question,
        context: context,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: GeneralButtonText(
            'No',
            context: context,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: GeneralButtonText('Yes', context: context),
        ),
      ],
    );
  }
}
