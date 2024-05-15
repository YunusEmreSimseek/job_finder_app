import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/widgets/images/user_image_with_radius.dart';
import 'package:job_finder_app/products/widgets/texts/semi_title_text.dart';
import 'package:kartal/kartal.dart';

final class SettingsItemCard extends Card {
  SettingsItemCard({super.key, required BuildContext context, String? imageUrl, required String title})
      : super(
            shape: RoundedRectangleBorder(borderRadius: context.border.normalBorderRadius),
            child: Padding(
              padding: ProjectPadding.allNormalDynamic(context),
              child: Row(
                children: [
                  imageUrl != null
                      ? SizedBox(
                          width: context.sized.dynamicWidth(.17),
                          child: UserImageWithRadius.network(imageUrl: imageUrl, context: context))
                      : const SizedBox(),
                  imageUrl != null ? context.sized.emptySizedWidthBoxNormal : const SizedBox(),
                  SemiTitleText(title, context: context),
                  const Spacer(),
                  const Icon(Icons.chevron_right_sharp),
                ],
              ),
            ));
}
