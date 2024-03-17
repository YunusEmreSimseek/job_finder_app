import 'package:flutter/material.dart';
import 'package:job_finder_app/products/enums/icon_size.dart';
import 'package:job_finder_app/products/widgets/texts/subtitle_text.dart';

final class JobPricePerHour extends Row {
  JobPricePerHour({super.key, required String pricePerHour, required BuildContext context})
      : super(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.euro,
            size: IconSize.low.value,
          ),
          SubtitleText('$pricePerHour/h', context: context),
        ]);
}
