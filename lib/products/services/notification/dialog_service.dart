import 'package:flutter/material.dart';
import 'package:job_finder_app/products/services/notification/notification_service.dart';
import 'package:job_finder_app/products/widgets/dialogs/text_dialog.dart';

final class DialogService implements NotificationService {
  final BuildContext context;

  DialogService(this.context);

  @override
  void showNotification(String message) {
    TextDialog.show(context: context, text: message);
  }
}
