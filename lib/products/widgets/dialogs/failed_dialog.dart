import 'package:flutter/material.dart';
import 'package:job_finder_app/products/widgets/dialogs/base_dialog.dart';

final class FailedDialog extends StatelessWidget {
  const FailedDialog({super.key});

  static Future<bool> show({required BuildContext context}) async {
    await BaseDialog.show<bool>(
      context: context,
      builder: (context) => const FailedDialog(),
      barrierDismissible: true,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Failed'),
    );
  }
}
