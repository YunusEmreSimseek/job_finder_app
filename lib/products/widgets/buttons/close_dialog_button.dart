import 'package:flutter/material.dart';

final class CloseDialogButton extends Align {
  CloseDialogButton({super.key, required BuildContext context})
      : super(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        );
}
