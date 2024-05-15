import 'package:job_finder_app/products/utilities/enums/font_size.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:kartal/kartal.dart';

final class SmallText extends GeneralText {
  SmallText(super.data, {super.key, required super.context, super.textAlign, super.maxLines})
      : super(
          style: context.general.textTheme.titleLarge?.copyWith(fontSize: FontSizes.lowMid.value),
        );
}
