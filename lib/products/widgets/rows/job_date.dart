import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/extensions/month_extension.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:kartal/kartal.dart';

final class JobDate extends Row {
  JobDate({super.key, required DateTime date, required BuildContext context})
      : super(children: [
          const Icon(Icons.date_range),
          context.sized.emptySizedWidthBoxLow,
          SizedBox(
              width: context.sized.dynamicWidth(.15),
              child: GeneralText('${date.month.toMonth()}, ${date.day}', context: context)),
        ]);
}
