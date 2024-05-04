import 'package:flutter/material.dart';

final class BaseDialog {
  BaseDialog._();

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      useSafeArea: false,
      builder: builder,
    );
  }
}
