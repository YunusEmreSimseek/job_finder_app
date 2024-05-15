import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/features/base_scaffold/view/base_scaffold_view.dart';
import 'package:job_finder_app/features/login/view/login_view.dart';
import 'package:job_finder_app/products/services/auth/auth_manager.dart';
import 'package:job_finder_app/products/services/auth/auth_service.dart';
import 'package:job_finder_app/products/utilities/mixins/keyboard_scroll_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/company_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/user_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/widgets/dialogs/text_dialog.dart';
import 'package:kartal/kartal.dart';

mixin LoginMixin
    on
        BaseViewMixin<LoginView>,
        UserTransactionMixin,
        PostTransactionsMixin,
        CompanyTransactionsMixin,
        KeyboardScrollMixin {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final AuthManager _authServiceManager;

  void initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  void navigateToHomeView() {
    directSafeOperarion(() {
      context.route.navigation.pushReplacement(MaterialPageRoute(builder: (context) => const BaseScaffoldView()));
    });
  }

  Future<void> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      changeLoading();
      await getAndSetLoggedInUser(FirebaseAuth.instance.currentUser!.email!);
      await getAndSetCompanies();
      await getAllPostsAndConvertToViewModel();
      changeLoading();
      navigateToHomeView();
    }
  }

  Future<void> tryLogin() async {
    changeLoading();
    final response = await _authServiceManager.login(email: emailController.text, password: passwordController.text);
    if (response) {
      await getAndSetLoggedInUser(emailController.text);
      await getAndSetCompanies();
      await getAllPostsAndConvertToViewModel();
      changeLoading();
      navigateToHomeView();
      return;
    }
    changeLoading();
    await safeOperation(() => TextDialog.show(context: context, text: 'Please check your email and password'));
  }

  @override
  void initState() {
    super.initState();
    isLoggedIn();
    initControllers();
    _authServiceManager = AuthManager(AuthService.instance);
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }
}
