import 'package:flutter/material.dart';
import 'package:job_finder_app/products/widgets/buttons/auth_button.dart';
import 'package:kartal/kartal.dart';

final class NavigateButton extends AuthButton {
  NavigateButton({super.key, required super.title, required super.context, required Widget page})
      : super(onPressed: () => context.route.navigateToPage(page));
}
