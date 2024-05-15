import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:job_finder_app/products/widgets/texts/small_text.dart';
import 'package:kartal/kartal.dart';

final class JobLocation extends Row {
  JobLocation({super.key, required String location, required BuildContext context})
      : super(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(
            Icons.location_on_outlined,
            size: IconSize.def.value,
          ),
          context.sized.emptySizedWidthBoxLow,
          SizedBox(
              width: context.sized.dynamicWidth(.21),
              child: SmallText(
                location,
                context: context,
                textAlign: TextAlign.left,
                maxLines: 1,
              )),
        ]);
}
