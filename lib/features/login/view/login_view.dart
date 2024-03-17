import 'package:flutter/material.dart';
import 'package:job_finder_app/features/login/mixin/login_mixin.dart';
import 'package:job_finder_app/features/register/view/register_view.dart';
import 'package:job_finder_app/products/constants/string_constant.dart';
import 'package:job_finder_app/products/enums/text_field_type.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/keyboard_scroll_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/post_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/user_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/widgets/buttons/login_button.dart';
import 'package:job_finder_app/products/widgets/buttons/navigate_button.dart';
import 'package:job_finder_app/products/widgets/fields/login_form_field.dart';
import 'package:job_finder_app/products/widgets/loading/loading_without_child.dart';
import 'package:job_finder_app/products/widgets/texts/app_bar_title_text.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:kartal/kartal.dart';

final class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with BaseViewMixin, UserMixin, PostMixin, LoginMixin, KeyboardScrollMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [LoadingWithoutChild()]),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: ProjectPadding.allNormalDynamic(context),
          child: Center(
              child: Column(
            children: [
              context.sized.emptySizedHeightBoxHigh,
              Icon(Icons.search_outlined, size: 100, color: context.general.colorScheme.primary),
              context.sized.emptySizedHeightBoxLow3x,
              AppBarTitleText(StringConstant.appName, context: context),
              context.sized.emptySizedHeightBoxLow3x,
              LoginFormField(controller: emailController, type: TextFieldType.email),
              context.sized.emptySizedHeightBoxLow,
              LoginFormField(controller: passwordController, type: TextFieldType.password),
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
        Expanded(child: LoginButton(onPressed: () => login(), context: context)),
        context.sized.emptySizedWidthBoxNormal,
        Expanded(
            child: NavigateButton(page: const RegisterView(), context: context, title: StringConstant.registerButton))
      ],
    );
  }
}
