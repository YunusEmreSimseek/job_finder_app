import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/enums/font_size.dart';
import 'package:job_finder_app/products/enums/text_field_type.dart';
import 'package:job_finder_app/products/utilities/mixins/is_obscure_mixin.dart';
import 'package:job_finder_app/products/utilities/states/is_obscure/is_obscure_cubit.dart';
import 'package:kartal/kartal.dart';

final class LoginFormField extends StatelessWidget with IsObscureMixin {
  const LoginFormField({super.key, required this.controller, required this.type});
  final TextEditingController controller;
  final TextFieldType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsObscureCubit, IsObscureState>(
      builder: (context, state) {
        return SizedBox(
          height: context.sized.dynamicHeight(.06),
          child: TextFormField(
            style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.lowMid.value),
            autovalidateMode: AutovalidateMode.disabled,
            controller: controller,
            obscureText: type.isPassword ? state.isObscure : false,
            keyboardType: type.keyboardType,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(context.border.normalRadius)),
              hintText: type.hintText,
              prefixIcon: type.prefixIcon,
              suffix: type.isPassword
                  ? InkWell(
                      onTap: () => changeObscure(context),
                      child: Icon(state.isObscure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }
}
