import 'package:flutter/widgets.dart';
import 'package:job_finder_app/products/services/notification/notification_facade.dart';

mixin NotificationMixin<T extends StatefulWidget> on State<T> {
  late final NotificationFacade _notificationFacade;

  @override
  void initState() {
    super.initState();
    _notificationFacade = NotificationFacade(context);
  }

  void showSneackbar(String message) {
    _notificationFacade.showSnackbar(message);
  }

  void showTextDialog(String message) {
    _notificationFacade.showDialog(message);
  }
}
