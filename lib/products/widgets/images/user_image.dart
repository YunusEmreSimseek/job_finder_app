import 'dart:io';

import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';

class UserImage extends Image {
  UserImage.network({super.key, required String? imageUrl, required BuildContext context})
      : super(
          image: NetworkImage(imageUrl ?? ''),
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.no_photography_outlined,
            size: IconSize.high.value,
          ),
          fit: BoxFit.cover,
        );

  UserImage.file({super.key, required File file, required BuildContext context})
      : super(
          image: FileImage(file),
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.no_photography_outlined,
            size: IconSize.high.value,
          ),
          fit: BoxFit.cover,
        );
}
