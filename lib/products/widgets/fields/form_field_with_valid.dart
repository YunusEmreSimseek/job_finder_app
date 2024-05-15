import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/enums/auth_text_field_type.dart';
import 'package:job_finder_app/products/utilities/enums/font_size.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:job_finder_app/products/utilities/states/is_obscure/is_obscure_cubit.dart';
import 'package:job_finder_app/products/widgets/buttons/password_visibility_button.dart';
import 'package:kartal/kartal.dart';

final class FormFieldWithValid extends StatelessWidget {
  const FormFieldWithValid({super.key, required this.controller, required this.type});
  final TextEditingController controller;
  final AuthTextFieldType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsObscureCubit, IsObscureState>(
      builder: (context, state) {
        return TextFormField(
          // style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.low.value),
          style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => type.func == null ? null : type.func!(value),
          controller: controller,
          obscureText: type.isPassword ? state.isObscure : false,
          keyboardType: type.keyboardType,
          decoration: InputDecoration(
              // errorStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.low.value),
              errorStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
              errorMaxLines: 2,
              border: OutlineInputBorder(borderRadius: BorderRadius.all(context.border.normalRadius)),
              // hintStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.lowMid.value),
              hintStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
              hintText: type.hintText,
              // prefixIcon: Icon(type.prefixIconData, size: IconSize.low.value),
              prefixIcon: Icon(type.prefixIconData, size: IconSize.lowMid.value),
              suffixIcon: type.isPassword ? PasswordVisibilityButton() : const SizedBox.shrink()),
        );
      },
    );
  }
}
