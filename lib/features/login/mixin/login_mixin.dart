import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/features/base_scaffold/view/base_scaffold_view.dart';
import 'package:job_finder_app/features/login/view/login_view.dart';
import 'package:job_finder_app/products/services/auth/auth_service_manager.dart';
import 'package:job_finder_app/products/utilities/mixins/post_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/user_mixin.dart';
import 'package:kartal/kartal.dart';

mixin LoginMixin on UserMixin<LoginView>, PostMixin<LoginView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final AuthServiceManager _authServiceManager;

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
      await getAllPosts();
      changeLoading();
      navigateToHomeView();
    }
  }

  Future<void> tryLogin() async {
    final response = await _authServiceManager.login(email: emailController.text, password: passwordController.text);
    if (response) {
      changeLoading();
      await getAndSetLoggedInUser(emailController.text);
      await getAllPosts();
      changeLoading();
      navigateToHomeView();
      return;
    }
  }

  void setAllPosts() {}

  @override
  void initState() {
    super.initState();
    isLoggedIn();
    initControllers();
    _authServiceManager = AuthServiceManager(AuthService.instance);
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
}
