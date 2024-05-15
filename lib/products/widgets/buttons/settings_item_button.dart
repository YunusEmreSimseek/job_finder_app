import 'package:flutter/material.dart';
import 'package:job_finder_app/products/widgets/cards/settings_item_card.dart';
import 'package:kartal/kartal.dart';

final class SettingsItemButton extends InkWell {
  SettingsItemButton({super.key, super.onTap, required BuildContext context, required String title})
      : super(
            child: SizedBox(
          height: context.sized.dynamicHeight(.11),
          child: SettingsItemCard(
            context: context,
            title: title,
          ),
        ));
}
