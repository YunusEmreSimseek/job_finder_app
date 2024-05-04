import 'package:flutter/material.dart';
import 'package:job_finder_app/products/enums/font_size.dart';
import 'package:kartal/kartal.dart';

final class DropDownFormField<T> extends StatelessWidget {
  const DropDownFormField({
    super.key,
    required this.items,
    required this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.value,
  });
  final List<DropdownMenuItem<T>> items;
  final void Function(T) onChanged;
  final T? value;
  final String? hintText;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.07),
      child: DropdownButtonFormField(
        value: value,
        isExpanded: true,
        style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.lowMid.value),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(context.border.normalRadius)),
          hintStyle: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.lowMid.value),
          hintText: hintText,
          prefixIcon: prefixIcon,
        ),
        items: items,
        onChanged: (value) => onChanged(value as T),
      ),
    );
  }
}
