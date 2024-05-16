import 'package:flutter/material.dart';
import 'package:job_finder_app/features/base_scaffold/view/base_scaffold_view.dart';
import 'package:job_finder_app/features/register/view/register_view.dart';
import 'package:job_finder_app/products/services/auth/auth_manager.dart';
import 'package:job_finder_app/products/services/auth/auth_service.dart';
import 'package:job_finder_app/products/services/commands/create_user_command.dart';
import 'package:job_finder_app/products/utilities/mixins/keyboard_scroll_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/notification_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/company_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/user_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:kartal/kartal.dart';

mixin RegisterMixin
    on
        BaseViewMixin<RegisterView>,
        UserTransactionMixin,
        PostTransactionsMixin,
        CompanyTransactionsMixin,
        KeyboardScrollMixin,
        NotificationMixin<RegisterView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmController;
  late final TextEditingController nameController;
  late final GlobalKey<FormState> formKey;
  late final AuthManager _authServiceManager;

  @override
  void initState() {
    super.initState();
    initControllers();
    _authServiceManager = AuthManager(AuthService.instance);
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
    if (formKey.currentState!.validate() && passwordController.text == passwordConfirmController.text) {
      changeLoading();
      final isContain = await checkEmailUsing(emailController.text);
      if (isContain) {
        changeLoading();
        showTextDialog('This email is already in use');
        emailController.clear();
        return;
      }

      final createUserCommand =
          CreateUserCommand(name: nameController.text, email: emailController.text, password: passwordController.text);
      final responseAuthService = await _authServiceManager.register(createUserCommand);
      if (!responseAuthService) {
        changeLoading();
        showTextDialog('Register failed');
        return;
      }
      final responseUserService = await createUser(createUserCommand);
      if (responseUserService) {
        await getAndSetLoggedInUser(emailController.text);
        await getAndSetCompanies();
        await getAllPostsAndConvertToViewModel();
        changeLoading();
        navigateToHomeView();
        return;
      }
      changeLoading();
    }
  }
}
