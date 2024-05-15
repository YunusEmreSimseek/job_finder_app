import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/enums/font_size.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:kartal/kartal.dart';

final class DropDownFormField<T> extends StatelessWidget {
  const DropDownFormField({
    super.key,
    required this.items,
    required this.onChanged,
    this.hintText,
    this.prefixIconData,
    this.value,
  });
  final List<DropdownMenuItem<T>> items;
  final void Function(T) onChanged;
  final T? value;
  final String? hintText;
  final IconData? prefixIconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.085),
      child: DropdownButtonFormField(
        padding: EdgeInsets.zero,
        value: value,
        isExpanded: true,
        style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(context.border.normalRadius)),
          hintStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
          hintText: hintText,
          prefixIcon: Icon(prefixIconData, size: IconSize.lowMid.value),
        ),
        items: items,
        onChanged: (value) => onChanged(value as T),
      ),
    );
  }
}
