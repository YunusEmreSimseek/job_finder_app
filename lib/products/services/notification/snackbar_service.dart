import 'package:flutter/material.dart';
import 'package:job_finder_app/products/services/notification/notification_service.dart';

final class SnackbarService implements NotificationService {
  final BuildContext context;

  SnackbarService(this.context);

  @override
  void showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
