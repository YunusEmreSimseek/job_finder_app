import 'package:flutter/material.dart';
import 'package:job_finder_app/products/widgets/texts/general_button_text.dart';
import 'package:kartal/kartal.dart';

class GeneralButton extends ElevatedButton {
  GeneralButton({super.key, required super.onPressed, required String title, required BuildContext context})
      : super(
          child: Padding(
            padding: context.padding.verticalNormal,
            // child: GeneralText(title, context: context),
            child: GeneralButtonText(title, context: context),
          ),
        );
}
