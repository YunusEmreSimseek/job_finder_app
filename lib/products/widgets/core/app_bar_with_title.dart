import 'package:flutter/material.dart';
import 'package:job_finder_app/products/widgets/loading/loading_with_child.dart';
import 'package:job_finder_app/products/widgets/loading/loading_without_child.dart';
import 'package:job_finder_app/products/widgets/texts/app_bar_title_text.dart';

final class AppBarWithTitle extends AppBar {
  AppBarWithTitle(
      {super.key, required BuildContext context, required String titleText, super.leading, required Widget actions})
      : super(title: AppBarTitleText(titleText, context: context), actions: [LoadingWithChild(child: actions)]);

  AppBarWithTitle.onlyLeading(
      {super.key, required BuildContext context, required String titleText, super.leading, Widget? actions})
      : super(title: AppBarTitleText(titleText, context: context), actions: [const LoadingWithoutChild()]);

  AppBarWithTitle.onlyActions(
      {super.key, required BuildContext context, required String titleText, required Widget actions})
      : super(title: AppBarTitleText(titleText, context: context), actions: [LoadingWithChild(child: actions)]);

  AppBarWithTitle.onlyTitle({super.key, required BuildContext context, required String titleText})
      : super(title: AppBarTitleText(titleText, context: context), actions: [const LoadingWithoutChild()]);
}
