import 'package:flutter/material.dart';
import 'package:job_finder_app/products/enums/font_size.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';

final class SubtitleText extends GeneralText {
  SubtitleText(super.data, {super.key, required super.context, TextAlign? textAlign})
      : super(
          textAlign: textAlign ?? TextAlign.center,
          fontSize: FontSize.lowMid.value,
        );
}
