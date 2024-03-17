import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/features/login/view/login_view.dart';
import 'package:job_finder_app/features/settings/view/settings_view.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:kartal/kartal.dart';
import 'package:logger/logger.dart';

mixin SettingsMixin on State<SettingsView>, BaseViewMixin<SettingsView> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Logger().i('Sign Out Success');
    navigateToLoginView();
  }

  void navigateToLoginView() {
    directSafeOperarion(() {
      context.route.navigation.pushReplacement(MaterialPageRoute(builder: (context) => const LoginView()));
    });
  }
}
