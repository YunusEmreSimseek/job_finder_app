import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_finder_app/products/widgets/images/user_image.dart';
import 'package:kartal/kartal.dart';

final class UserImageWithRadius extends ClipRRect {
  UserImageWithRadius.network({super.key, required String? imageUrl, required BuildContext context})
      : super(
          borderRadius: BorderRadius.all(context.border.normalRadius),
          child: UserImage.network(imageUrl: imageUrl, context: context),
        );

  UserImageWithRadius.file({super.key, required File file, required BuildContext context})
      : super(
          borderRadius: BorderRadius.all(context.border.normalRadius),
          child: UserImage.file(file: file, context: context),
        );
}
