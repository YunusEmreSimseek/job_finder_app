import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/features/base_scaffold/view/base_scaffold_view.dart';
import 'package:job_finder_app/features/login/view/login_view.dart';
import 'package:job_finder_app/products/services/auth/auth_service.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/post_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/user_mixin.dart';
import 'package:kartal/kartal.dart';

mixin LoginMixin on BaseViewMixin<LoginView>, UserMixin<LoginView>, PostMixin<LoginView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final IAuthService _authService;

  void initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _authService = AuthService();
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
      await getLoggedInUser(FirebaseAuth.instance.currentUser!.email!);
      await getAllPosts();
      changeLoading();
      navigateToHomeView();
    }
  }

  Future<void> login() async {
    final response = await _authService.login(email: emailController.text, password: passwordController.text);
    if (response) {
      changeLoading();
      await getLoggedInUser(emailController.text);
      await getAllPosts();
      changeLoading();
      // ignore: use_build_context_synchronously
      navigateToHomeView();
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    isLoggedIn();
    initControllers();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
}
