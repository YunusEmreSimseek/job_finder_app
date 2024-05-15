import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_finder_app/products/utilities/enums/font_size.dart';
import 'package:kartal/kartal.dart';

class GeneralText extends Text {
  GeneralText(
    super.data, {
    super.key,
    required BuildContext context,
    TextAlign? textAlign,
    TextStyle? style,
    int? maxLines,
  }) : super(
          textAlign: textAlign ?? TextAlign.center,
          style: style ?? context.general.textTheme.titleLarge?.copyWith(fontSize: FontSizes.def.value),
          maxLines: maxLines ?? 100,
          overflow: TextOverflow.ellipsis,
        );
}
