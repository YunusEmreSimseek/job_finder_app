import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/enums/font_size.dart';
import 'package:job_finder_app/products/enums/text_field_type.dart';
import 'package:job_finder_app/products/utilities/mixins/is_obscure_mixin.dart';
import 'package:job_finder_app/products/utilities/states/is_obscure/is_obscure_cubit.dart';
import 'package:kartal/kartal.dart';

final class FormFieldWithValid extends StatelessWidget with IsObscureMixin {
  const FormFieldWithValid({super.key, required this.controller, required this.type});
  final TextEditingController controller;
  final AuthTextFieldType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsObscureCubit, IsObscureState>(
      builder: (context, state) {
        return TextFormField(
          style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.lowMid.value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => type.func == null ? null : type.func!(value),
          controller: controller,
          obscureText: type.isPassword ? state.isObscure : false,
          keyboardType: type.keyboardType,
          decoration: InputDecoration(
            errorStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.lowMid.value),
            errorMaxLines: 2,
            border: OutlineInputBorder(borderRadius: BorderRadius.all(context.border.normalRadius)),
            hintStyle: context.general.textTheme.titleMedium?.copyWith(
              fontSize: FontSize.lowMid.value,
            ),
            hintText: type.hintText,
            prefixIcon: type.prefixIcon,
            suffixIcon: type.isPassword
                ? InkWell(
                    onTap: () => changeObscure(context),
                    child: Icon(state.isObscure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
