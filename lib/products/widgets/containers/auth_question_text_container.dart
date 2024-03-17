import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:kartal/kartal.dart';

final class AuthQuestionTextContainer extends Container {
  AuthQuestionTextContainer({super.key, required String title, required BuildContext context})
      : super(
            margin: context.padding.onlyLeftHigh + context.padding.onlyLeftHigh,
            child: GeneralText(title, context: context));
}
