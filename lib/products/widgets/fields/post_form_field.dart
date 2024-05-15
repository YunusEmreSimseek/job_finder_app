import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/enums/create_ad_text_field_type.dart';
import 'package:job_finder_app/products/utilities/enums/font_size.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:job_finder_app/products/utilities/states/is_obscure/is_obscure_cubit.dart';
import 'package:kartal/kartal.dart';

final class PostFormField extends StatelessWidget {
  const PostFormField({super.key, required this.controller, required this.type});
  final TextEditingController controller;
  final CreateAdTextFieldType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsObscureCubit, IsObscureState>(
      builder: (context, state) {
        return SizedBox(
          height: context.sized.dynamicHeight(.085),
          child: TextFormField(
            style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
            controller: controller,
            keyboardType: type.keyboardType,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(context.border.normalRadius)),
              hintStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
              hintText: type.hintText,
              prefixIcon: Icon(type.prefixIcon, size: IconSize.lowMid.value),
            ),
          ),
        );
      },
    );
  }
}
