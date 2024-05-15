import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/enums/company_text_field_types.dart';
import 'package:job_finder_app/products/utilities/enums/font_size.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:kartal/kartal.dart';

final class AddCompanyFormField extends StatelessWidget {
  const AddCompanyFormField({super.key, required this.controller, required this.type});
  final TextEditingController controller;
  final CompanyTextFieldTypes type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.085),
      child: TextFormField(
        maxLines: null,
        validator: (value) => value!.isEmpty ? 'This field cannot be empty' : null,
        // style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.low.value),
        style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
        controller: controller,
        keyboardType: type.keyboardType,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.all(context.border.normalRadius)),
            hintStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
            // hintStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.low.value),
            errorStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
            hintText: type.hintText,
            // prefixIcon: Icon(type.prefixIconData, size: IconSize.low.value)),
            prefixIcon: Icon(type.prefixIconData, size: IconSize.low.value)),
      ),
    );
  }
}
