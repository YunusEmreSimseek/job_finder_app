import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/states/is_obscure/is_obscure_cubit.dart';

final class PasswordVisibilityButton extends InkWell {
  PasswordVisibilityButton({super.key})
      : super(
          onTap: () => IsObscureCubit.instance.changeObscure(),
          child: Icon(IsObscureCubit.instance.state.isObscure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
        );
}
