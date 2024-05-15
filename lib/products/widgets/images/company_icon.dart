import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:kartal/kartal.dart';

final class CompanyIcon extends SizedBox {
  CompanyIcon({super.key, required BuildContext context, required String imageUrl})
      : super(
          height: context.sized.dynamicHeight(.05),
          width: context.sized.dynamicWidth(.13),
          child: Image.network(
            imageUrl,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.error_outline_rounded,
              size: IconSize.high.value,
            ),
            fit: BoxFit.contain,
          ),
        );
}
