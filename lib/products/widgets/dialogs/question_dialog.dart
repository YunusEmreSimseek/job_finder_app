import 'package:flutter/material.dart';
import 'package:job_finder_app/products/widgets/dialogs/base_dialog.dart';

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
      title: Text(question),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
