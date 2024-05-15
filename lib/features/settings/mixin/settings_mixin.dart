import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/features/login/view/login_view.dart';
import 'package:job_finder_app/features/settings/view/settings_view.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';
import 'package:job_finder_app/products/widgets/dialogs/company/add_company_dialog.dart';
import 'package:kartal/kartal.dart';
import 'package:logger/logger.dart';

mixin SettingsMixin on BaseViewMixin<SettingsView> {
  late final ValueNotifier<String> imageUrlNotifier;

  @override
  void initState() {
    super.initState();
    imageUrlNotifier = ValueNotifier<String>(getCubit<UserCubit>().state.loggedInUser!.imageUrl ?? '');
  }

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

  Future<void> navigateToAddCompany() async {
    await AddCompanyDialog.show(context: context);
  }

  void setUserImage() {}
}
