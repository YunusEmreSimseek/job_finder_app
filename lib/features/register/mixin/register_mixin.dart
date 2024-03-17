import 'package:flutter/material.dart';
import 'package:job_finder_app/features/base_scaffold/view/base_scaffold_view.dart';
import 'package:job_finder_app/features/register/view/register_view.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/services/auth/auth_service.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/post_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/user_mixin.dart';
import 'package:kartal/kartal.dart';

mixin RegisterMixin on BaseViewMixin<RegisterView>, UserMixin<RegisterView>, PostMixin<RegisterView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmController;
  late final TextEditingController nameController;
  late final GlobalKey<FormState> formKey;
  late final IAuthService _authService;

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  void initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    nameController = TextEditingController();
    formKey = GlobalKey();
    _authService = AuthService();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    nameController.dispose();
  }

  void navigateToHomeView() {
    directSafeOperarion(() {
      context.route.navigation.pushReplacement(MaterialPageRoute(builder: (context) => const BaseScaffoldView()));
    });
  }

  Future<void> register() async {
    changeLoading();
    final user = UserModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    final response = await _authService.register(user: user);
    if (response) {
      await getLoggedInUser(emailController.text);
      await getAllPosts();
      changeLoading();
      navigateToHomeView();
      return;
    }
    changeLoading();
  }
}
