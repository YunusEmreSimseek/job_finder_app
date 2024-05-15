import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/enums/auth_text_field_type.dart';
import 'package:job_finder_app/products/utilities/enums/font_size.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:job_finder_app/products/utilities/states/is_obscure/is_obscure_cubit.dart';
import 'package:job_finder_app/products/widgets/buttons/password_visibility_button.dart';
import 'package:kartal/kartal.dart';

final class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({super.key, required this.confirmPasswordController, required this.passwordController});
  final TextEditingController confirmPasswordController;
  final TextEditingController passwordController;
  final AuthTextFieldType type = AuthTextFieldType.confirmPassword;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsObscureCubit, IsObscureState>(
      builder: (context, state) {
        return TextFormField(
          // style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.low.value),
          style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          controller: confirmPasswordController,
          obscureText: state.isObscure,
          keyboardType: type.keyboardType,
          decoration: InputDecoration(
              // errorStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.low.value),
              errorStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
              errorMaxLines: 2,
              border: OutlineInputBorder(borderRadius: BorderRadius.all(context.border.normalRadius)),
              // hintStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.low.value),
              hintStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
              hintText: type.hintText,
              prefixIcon: Icon(type.prefixIconData, size: IconSize.low.value),
              suffixIcon: type.isPassword ? PasswordVisibilityButton() : const SizedBox.shrink()),
        );
      },
    );
  }
}
