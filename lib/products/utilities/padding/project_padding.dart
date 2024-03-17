import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kartal/kartal.dart';

/// Project Paddings
final class ProjectPadding extends EdgeInsets {
  /// Dynamic padding for all sides with normal value
  ProjectPadding.allNormalDynamic(this.context)
      : super.only(
          top: context.sized.dynamicHeight(0.02),
          bottom: context.sized.dynamicHeight(0.02),
          left: context.sized.dynamicWidth(0.04),
          right: context.sized.dynamicWidth(0.04),
        );

  /// Padding for all sides with normal value
  ProjectPadding.allNormal(this.context) : super.all(context.sized.normalValue);
  final BuildContext context;
}
