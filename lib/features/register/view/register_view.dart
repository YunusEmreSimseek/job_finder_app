import 'package:flutter/material.dart';
import 'package:job_finder_app/features/login/view/login_view.dart';
import 'package:job_finder_app/features/register/mixin/register_mixin.dart';
import 'package:job_finder_app/products/constants/string_constant.dart';
import 'package:job_finder_app/products/enums/text_field_type.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/keyboard_scroll_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/post_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/user_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/widgets/buttons/navigate_button.dart';
import 'package:job_finder_app/products/widgets/buttons/register_button.dart';
import 'package:job_finder_app/products/widgets/containers/auth_question_text_container.dart';
import 'package:job_finder_app/products/widgets/fields/form_field_with_valid.dart';
import 'package:job_finder_app/products/widgets/loading/loading_without_child.dart';
import 'package:job_finder_app/products/widgets/texts/app_bar_title_text.dart';
import 'package:kartal/kartal.dart';

final class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with BaseViewMixin, UserMixin, PostMixin, RegisterMixin, KeyboardScrollMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [LoadingWithoutChild()]),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Form(
            key: formKey,
            child: Padding(
              padding: ProjectPadding.allNormalDynamic(context),
              child: Center(
                child: Column(
                  children: [
                    context.sized.emptySizedHeightBoxLow3x,
                    Icon(Icons.search_outlined, size: 100, color: context.general.colorScheme.primary),
                    context.sized.emptySizedHeightBoxLow3x,
                    AppBarTitleText(StringConstant.appName, context: context),
                    context.sized.emptySizedHeightBoxLow3x,
                    FormFieldWithValid(controller: nameController, type: TextFieldType.name),
                    context.sized.emptySizedHeightBoxLow,
                    FormFieldWithValid(controller: emailController, type: TextFieldType.email),
                    context.sized.emptySizedHeightBoxLow,
                    FormFieldWithValid(controller: passwordController, type: TextFieldType.password),
                    context.sized.emptySizedHeightBoxLow,
                    FormFieldWithValid(controller: passwordConfirmController, type: TextFieldType.confirmPassword),
                    context.sized.emptySizedHeightBoxNormal,
                    AuthQuestionTextContainer(title: StringConstant.registerAlreadyHaveAnAccount, context: context),
                    context.sized.emptySizedHeightBoxLow,
                    _buttonsRow(context),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Row _buttonsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: RegisterButton(
          context: context,
          onPressed: () async => await register(),
        )),
        context.sized.emptySizedWidthBoxNormal,
        Expanded(
            child: NavigateButton(
          context: context,
          title: StringConstant.loginButton,
          page: const LoginView(),
        ))
      ],
    );
  }
}
