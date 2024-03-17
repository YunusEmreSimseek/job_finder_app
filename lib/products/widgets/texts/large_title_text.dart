import 'package:flutter/material.dart';
import 'package:job_finder_app/products/enums/font_size.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';

final class LargeTitleText extends GeneralText {
  LargeTitleText(super.data, {super.key, required super.context})
      : super(
          fontSize: FontSize.high.value,
          fontWeight: FontWeight.w600,
        );
}
