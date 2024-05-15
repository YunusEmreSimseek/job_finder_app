import 'package:job_finder_app/products/utilities/constants/string_constant.dart';
import 'package:job_finder_app/products/widgets/buttons/general_button.dart';

final class RegisterButton extends GeneralButton {
  RegisterButton({
    super.key,
    required super.context,
    super.onPressed,
  }) : super(
          title: StringConstant.registerButton,
        );
}
