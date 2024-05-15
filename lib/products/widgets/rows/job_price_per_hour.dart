import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:job_finder_app/products/widgets/texts/small_text.dart';

final class JobPricePerHour extends Row {
  JobPricePerHour({super.key, required String pricePerHour, required BuildContext context})
      : super(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.euro,
            size: IconSize.low.value,
          ),
          pricePerHour.length > 4
              ? SmallText('${pricePerHour.substring(0, 3).toString()}/h', context: context)
              : SmallText('$pricePerHour/h', context: context),
        ]);
}
