import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/firebase_options.dart';
import 'package:logger/logger.dart';

@immutable

/// This class is used to initialize the application.
final class ApplicationInitialize {
  /// It's only use for setup business
  const ApplicationInitialize._();

  /// This method is used to initialize the application.
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// Safety zone
    await runZonedGuarded<Future<void>>(_initialize, (error, stack) {
      Logger().e(error);
      Logger().e(stack);
    });
  }

  static Future<void> _initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = (details) {
      Logger().e(details.exceptionAsString());
    };
  }
}
