import 'package:flutter/material.dart';
import 'package:job_finder_app/features/login/mixin/login_mixin.dart';
import 'package:job_finder_app/features/register/view/register_view.dart';
import 'package:job_finder_app/products/utilities/constants/string_constant.dart';
import 'package:job_finder_app/products/utilities/enums/auth_text_field_type.dart';
import 'package:job_finder_app/products/utilities/mixins/keyboard_scroll_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/company_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/user_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/widgets/buttons/login_button.dart';
import 'package:job_finder_app/products/widgets/buttons/navigate_button.dart';
import 'package:job_finder_app/products/widgets/core/app_bar_with_title.dart';
import 'package:job_finder_app/products/widgets/core/app_icon.dart';
import 'package:job_finder_app/products/widgets/core/app_name_text.dart';
import 'package:job_finder_app/products/widgets/fields/login_form_field.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:kartal/kartal.dart';

final class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with
        PostTransactionsMixin,
        BaseViewMixin,
        UserTransactionMixin,
        CompanyTransactionsMixin,
        KeyboardScrollMixin,
        LoginMixin {
  @override
  Widget build(BuildContext context) {
    scrollToBottomOnKeyboardOpen(context);
    return Scaffold(
      appBar: AppBarWithTitle.onlyTitle(context: context, titleText: StringConstant.login),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: ProjectPadding.allNormalDynamic(context),
          child: Center(
              child: Column(
            children: [
              context.sized.emptySizedHeightBoxHigh,
              const AppIcon(),
              context.sized.emptySizedHeightBoxLow3x,
              AppNameText(context: context),
              context.sized.emptySizedHeightBoxLow3x,
              LoginFormField(controller: emailController, type: AuthTextFieldType.email),
              context.sized.emptySizedHeightBoxLow,
              LoginFormField(controller: passwordController, type: AuthTextFieldType.password),
              context.sized.emptySizedHeightBoxNormal,
              _textContainer(context),
              context.sized.emptySizedHeightBoxLow,
              _buttonsRow(context),
            ],
          )),
        ),
      ),
    );
  }

  Container _textContainer(BuildContext context) {
    return Container(
        margin: context.padding.onlyLeftHigh + context.padding.onlyLeftHigh,
        child: GeneralText(StringConstant.loginDontHaveAnAccount, context: context));
  }

  Row _buttonsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: LoginButton(onPressed: () => tryLogin(), context: context)),
        context.sized.emptySizedWidthBoxNormal,
        Expanded(
            child: NavigateButton(page: const RegisterView(), context: context, title: StringConstant.registerButton))
      ],
    );
  }
}
