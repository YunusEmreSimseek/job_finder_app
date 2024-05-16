import 'package:flutter/widgets.dart';

abstract class BaseDecorator extends StatelessWidget {
  final Widget child;
  const BaseDecorator(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
