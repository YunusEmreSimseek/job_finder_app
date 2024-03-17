import 'package:flutter/material.dart';
import 'package:job_finder_app/products/enums/font_size.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';

final class AppBarTitleText extends GeneralText {
  AppBarTitleText(super.data, {super.key, required super.context})
      : super(
          fontSize: FontSize.veryHigh.value,
          fontWeight: FontWeight.w900,
        );
}
