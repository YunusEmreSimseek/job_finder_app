import 'package:flutter/material.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:kartal/kartal.dart';

final class JobLocation extends Row {
  JobLocation({super.key, required String location, required BuildContext context})
      : super(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Icon(Icons.location_on_outlined),
          context.sized.emptySizedWidthBoxLow,
          SizedBox(
              width: context.sized.dynamicWidth(.2),
              child: GeneralText(
                location,
                context: context,
                textAlign: TextAlign.left,
              )),
        ]);
}
