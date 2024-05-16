import 'package:flutter/widgets.dart';
import 'package:job_finder_app/products/services/notification/dialog_service.dart';
import 'package:job_finder_app/products/services/notification/notification_service.dart';
import 'package:job_finder_app/products/services/notification/snackbar_service.dart';

/// Facade Pattern
final class NotificationFacade {
  final NotificationService _dialogService;
  final NotificationService _snackbarService;

  NotificationFacade(BuildContext context)
      : _dialogService = DialogService(context),
        _snackbarService = SnackbarService(context);

  void showSnackbar(String message) {
    _snackbarService.showNotification(message);
  }

  void showDialog(String message) {
    _dialogService.showNotification(message);
  }
}
