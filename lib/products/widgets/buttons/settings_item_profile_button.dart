import 'package:flutter/material.dart';
import 'package:job_finder_app/features/profile/view/profile_view.dart';
import 'package:job_finder_app/products/widgets/cards/settings_item_card.dart';
import 'package:kartal/kartal.dart';

final class SettingsItemProfileButton extends InkWell {
  SettingsItemProfileButton(
      {super.key, required BuildContext context, required String? imageUrl, required String title})
      : super(
            onTap: () => context.route.navigateToPage(const ProfileView()),
            child: SizedBox(
              height: context.sized.dynamicHeight(.125),
              child: SettingsItemCard.withImage(
                context: context,
                imageUrl: imageUrl ?? '',
                title: title,
              ),
            ));
}
