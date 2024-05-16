import 'package:flutter/material.dart';
import 'package:job_finder_app/products/widgets/decorator/base_decorator.dart';

/// Padding decorator for widgets
final class PaddingDecorator extends BaseDecorator {
  final double padding;
  final EdgeInsets paddingStyle;
  PaddingDecorator.all({super.key, required this.padding, required Widget child})
      : paddingStyle = EdgeInsets.all(padding),
        super(child);

  PaddingDecorator.horizontal({super.key, required this.padding, required Widget child})
      : paddingStyle = EdgeInsets.symmetric(horizontal: padding),
        super(child);

  PaddingDecorator.vertical({super.key, required this.padding, required Widget child})
      : paddingStyle = EdgeInsets.symmetric(vertical: padding),
        super(child);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingStyle,
      child: super.build(context),
    );
  }
}
