import 'package:flutter/material.dart';
import 'package:job_finder_app/features/base_scaffold/view/base_scaffold_view.dart';
import 'package:job_finder_app/features/register/view/register_view.dart';
import 'package:job_finder_app/products/constants/project_constants.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/services/auth/auth_service_manager.dart';
import 'package:job_finder_app/products/utilities/mixins/post_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/user_mixin.dart';
import 'package:kartal/kartal.dart';

mixin RegisterMixin on UserMixin<RegisterView>, PostMixin<RegisterView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmController;
  late final TextEditingController nameController;
  late final GlobalKey<FormState> formKey;
  late final AuthServiceManager _authServiceManager;

  @override
  void initState() {
    super.initState();
    initControllers();
    _authServiceManager = AuthServiceManager(AuthService.instance);
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

  Future<void> tryRegister() async {
    changeLoading();
    final user = UserModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      imageUrl: ProjectConstants.defUserPicUrl,
    );
    final response = await _authServiceManager.register(user);
    if (response) {
      await getAndSetLoggedInUser(emailController.text);
      await getAllPosts();
      changeLoading();
      navigateToHomeView();
      return;
    }
    changeLoading();
  }
}
