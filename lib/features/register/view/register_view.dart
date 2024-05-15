import 'package:flutter/material.dart';
import 'package:job_finder_app/features/login/view/login_view.dart';
import 'package:job_finder_app/features/register/mixin/register_mixin.dart';
import 'package:job_finder_app/products/utilities/constants/string_constant.dart';
import 'package:job_finder_app/products/utilities/enums/auth_text_field_type.dart';
import 'package:job_finder_app/products/utilities/mixins/keyboard_scroll_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/company_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/user_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/widgets/buttons/navigate_button.dart';
import 'package:job_finder_app/products/widgets/buttons/register_button.dart';
import 'package:job_finder_app/products/widgets/containers/auth_question_text_container.dart';
import 'package:job_finder_app/products/widgets/core/app_bar_with_title.dart';
import 'package:job_finder_app/products/widgets/core/app_icon.dart';
import 'package:job_finder_app/products/widgets/core/app_name_text.dart';
import 'package:job_finder_app/products/widgets/fields/confirm_password_field.dart';
import 'package:job_finder_app/products/widgets/fields/form_field_with_valid.dart';
import 'package:kartal/kartal.dart';

final class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with
        PostTransactionsMixin,
        BaseViewMixin,
        UserTransactionMixin,
        CompanyTransactionsMixin,
        KeyboardScrollMixin,
        RegisterMixin {
  @override
  Widget build(BuildContext context) {
    scrollToBottomOnKeyboardOpen(context);
    return Scaffold(
      appBar: AppBarWithTitle.onlyTitle(context: context, titleText: StringConstant.register),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Padding(
              padding: ProjectPadding.allNormalDynamic(context),
              child: Center(
                child: Column(
                  children: [
                    context.sized.emptySizedHeightBoxLow3x,
                    const AppIcon(),
                    context.sized.emptySizedHeightBoxLow3x,
                    AppNameText(context: context),
                    context.sized.emptySizedHeightBoxLow3x,
                    FormFieldWithValid(controller: nameController, type: AuthTextFieldType.name),
                    context.sized.emptySizedHeightBoxLow,
                    FormFieldWithValid(controller: emailController, type: AuthTextFieldType.email),
                    context.sized.emptySizedHeightBoxLow,
                    FormFieldWithValid(controller: passwordController, type: AuthTextFieldType.password),
                    context.sized.emptySizedHeightBoxLow,
                    ConfirmPasswordField(
                        confirmPasswordController: passwordConfirmController, passwordController: passwordController),
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
          onPressed: () async => await tryRegister(),
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
