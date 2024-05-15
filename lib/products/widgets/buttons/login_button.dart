import 'package:job_finder_app/products/utilities/constants/string_constant.dart';
import 'package:job_finder_app/products/widgets/buttons/general_button.dart';

final class LoginButton extends GeneralButton {
  LoginButton({super.key, required super.context, super.onPressed})
      : super(
          title: StringConstant.loginButton,
        );
}
