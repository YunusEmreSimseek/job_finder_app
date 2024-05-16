import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/widgets/images/user_image_with_radius.dart';
import 'package:job_finder_app/products/widgets/texts/subtitle_text.dart';
import 'package:kartal/kartal.dart';

final class SettingsItemCard extends Card {
  SettingsItemCard({super.key, required BuildContext context, required String title})
      : super(
            shape: RoundedRectangleBorder(borderRadius: context.border.normalBorderRadius),
            child: Padding(
              padding: ProjectPadding.allNormalDynamic(context),
              child: Row(
                children: [
                  SubtitleText(title, context: context),
                  const Spacer(),
                  const Icon(Icons.chevron_right_sharp),
                ],
              ),
            ));

  SettingsItemCard.withImage(
      {super.key, required BuildContext context, required String imageUrl, required String title})
      : super(
            shape: RoundedRectangleBorder(borderRadius: context.border.normalBorderRadius),
            child: Padding(
              padding: ProjectPadding.allNormalDynamic(context),
              child: Row(
                children: [
                  UserImageWithRadius.network(context: context, imageUrl: imageUrl),
                  context.sized.emptySizedWidthBoxNormal,
                  SubtitleText(title, context: context),
                  const Spacer(),
                  const Icon(Icons.chevron_right_sharp),
                ],
              ),
            ));
}
