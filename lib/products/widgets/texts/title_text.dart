import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/enums/font_size.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:kartal/kartal.dart';

class TitleText extends GeneralText {
  TitleText(super.data, {super.key, required super.context, super.textAlign})
      : super(
          style: context.general.textTheme.titleLarge
              ?.copyWith(fontSize: FontSizes.high.value, fontWeight: FontWeight.w700),
        );
}
