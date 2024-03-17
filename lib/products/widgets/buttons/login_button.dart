import 'package:job_finder_app/products/constants/string_constant.dart';
import 'package:job_finder_app/products/widgets/buttons/auth_button.dart';

final class LoginButton extends AuthButton {
  LoginButton({super.key, required super.context, super.onPressed})
      : super(
          title: StringConstant.loginButton,
        );
}
